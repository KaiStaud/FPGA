----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2020 17:35:05
-- Design Name: 
-- Module Name: clock_divider - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- Divides the clock down, generates an isolated clock domain
-- Dependencies: 
-- 
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

entity clock_divider is
    Port ( clk : in STD_LOGIC;
            clk_out: out STD_LOGIC
          );
end clock_divider;

architecture Behavioral of clock_divider is

constant time_10ms: unsigned (15 downto 0) := x"0008";
signal timer_value,next_timer_value: unsigned (15 downto 0) := x"0000";

signal clk_tb: std_logic;
signal clk_out_tb	 : std_logic;

begin

-- Downscale the clock : 1 Pulse / 10ms
timer_10ms: process(clk)
begin
if(rising_edge(clk))then
        timer_value <= next_timer_value + x"0001";
         clk_out <= '0';
if(timer_value = time_10ms)then
 clk_out <= '1';
 end if;
    
end if;

end process timer_10ms;

-- Assign counter values and check for overflows
counter_register: process(clk)
begin
if(rising_edge(clk))then
    -- assign new counter_values     
    next_timer_value <= timer_value;
   
    -- check if counter has overflown:
    if(timer_value > time_10ms) then
        next_timer_value <= x"0000";
    end if;
    
end if;

end process counter_register;

end Behavioral;
