----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2020 20:42:00
-- Design Name: 
-- Module Name: SPI_Slave - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- Implements an receive only SPI Slave.
-- Samples on falling edge, loads data on rising edge
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SPI_Slave is
    Port ( 
           SCK : in STD_LOGIC;
           MOSI : in STD_LOGIC;
           CS : in STD_LOGIC;
           data : out unsigned (15 downto 0)
           );
end SPI_Slave;


architecture Behavioral of SPI_Slave is

signal bit_nr: unsigned (3 downto 0);
signal bit_in: std_logic;
signal int_data: unsigned (15 downto 0):= x"0000";
signal next_int_data : unsigned(15 downto 0);
begin

shift_in_register: process(SCK,MOSI,CS)
begin
if(CS = '0') then
    if(falling_edge(SCK)) then
     bit_in <= MOSI;
    end if;
end if;
end process shift_in_register;


data_register: process(SCK,CS)
begin

if(CS = '0')then
--while CS is low: shift previous bits one to the left (MSB first)
    if(rising_edge(SCK))then
        next_int_data <= shift_left((int_data),1);
        next_int_data(0) <= bit_in;
    end if;
else 
-- when CS goes high: data is rdy!
data <= int_data;
end if;

end process data_register;

reg:process(SCK)
begin
    if(falling_edge(SCK))then
        int_data <= next_int_data;
    end if;
end process reg;

end Behavioral;
