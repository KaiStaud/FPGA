----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.02.2021 17:40:43
-- Design Name: 
-- Module Name: spi_master - Behavioral
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
-- 8 Bit Operation 
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

entity spi_master is
    Port ( sys_clk : in std_logic;
           clk_in : in STD_LOGIC; -- this is the spi clock, not the sys clock!
           sck : out STD_LOGIC;
           cs : out STD_LOGIC;
           miso : in STD_LOGIC;
           mosi : out STD_LOGIC;
           rdy : out std_logic; -- master finished transmission
           new_data : in std_logic; -- new data available
           data_in : in std_logic_vector (7 downto 0);
           data_out: out std_logic_vector(7 downto 0)
           );
end spi_master;

architecture Behavioral of spi_master is

signal bit_nr,next_bit_nr: unsigned(3 downto 0):= x"0";
signal next_busy,busy:std_logic := '0';


begin

cs <= not busy;
rdy <= not busy;
--Increment counter--
counter : process(clk_in)
begin
-- increment the counter
if(rising_edge(clk_in) and clk_in = '1' and bit_nr < x"8") then
    bit_nr <= next_bit_nr + x"1";
-- update the counter output     
elsif(falling_edge(clk_in) and clk_in = '0') then
    next_bit_nr <= bit_nr;
--else
--    bit_nr <= next_bit_nr;
end if;
end process counter;

--  check if transmission in process
busy_generator: process(sys_clk,new_data)
begin
if(rising_edge(sys_clk))then
    if(new_data = '1' or bit_nr < x"8") then
        busy <= '1';
    else 
        busy <= '0';
    end if;
end if;    
end process busy_generator;

-- implements the core functionality
-- LSB First, MOSI default = '0'!
shift_register: process(clk_in,data_in)
begin
if(rising_edge(clk_in) and busy = '1' and bit_nr < x"8") then
-- shift bits out to mosi
mosi <= data_in(TO_INTEGER(bit_nr));
-- shift bits in from miso
data_out(TO_INTEGER(bit_nr)) <= miso;
else
mosi <= '0';
end if;
end process shift_register;

sck_generator: process(clk_in)
begin
    if(busy = '1') then
        sck <= clk_in;
    else
        sck <= '1';
    end if;
end process;

end Behavioral;
