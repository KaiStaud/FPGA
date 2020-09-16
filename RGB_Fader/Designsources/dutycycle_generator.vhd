----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2020 18:08:12
-- Design Name: 
-- Module Name: dutycycle_generator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- Increments the dutycyle when flag is raised.
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
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

entity dutycycle_generator is
    Port ( clk : in STD_LOGIC;
           increment : in STD_LOGIC;
           dutycycle : out unsigned (15 downto 0));
end dutycycle_generator;

architecture Behavioral of dutycycle_generator is

signal dutycycle_counter,next_dutycycle_counter: unsigned (15 downto 0):= x"0000";


begin
dutycycle <= dutycycle_counter;

upcounter: process(increment)
begin
if(rising_edge(increment))then
 dutycycle_counter <= next_dutycycle_counter + x"0001";
end if;
end process upcounter;

 

-- Assign counter values and check for overflows
counter_register: process(clk)
begin
if(rising_edge(clk))then
    -- assign new counter_values
    next_dutycycle_counter <= dutycycle_counter;
    -- check if counter has overflown:
    if(next_dutycycle_counter = x"0004")then
        next_dutycycle_counter <= x"0000";
    end if;
    
end if;

end process counter_register;
end Behavioral;
