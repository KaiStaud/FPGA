----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.09.2020 18:53:55
-- Design Name: 
-- Module Name: pwm_generator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- Generates an PWM Signal
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

entity pwm_generator is
    Port ( clk : in STD_LOGIC;
           q : out STD_LOGIC);
end pwm_generator;

architecture Behavioral of pwm_generator is
-- declare signals here:
-- simulation set
constant topvalue : unsigned (15 downto 0) := x"0004";
constant overflowvalue: unsigned(15 downto 0):= x"000A";

signal countervalue: unsigned(15 downto 0) := x"0000";
signal next_countervalue: unsigned (15 downto 0):= x"0000";

begin
-- declare behaviour here:

-- Count straight up. Counter gets reset below!
upcounter: process(clk)
begin
if(rising_edge(clk))then
 countervalue <= next_countervalue + x"0001";
end if;
end process upcounter;

-- Set / Reset output
output_stage: process(clk)
begin
if(rising_edge(clk))then
    if(countervalue >= topvalue)then
    q <= '1';
    else
    q <= '0';
    end if;
 end if;
 
 end process output_stage;

-- Assign counter values and check for overflows
counter_register: process(clk)
begin
if(rising_edge(clk))then
    -- assign new counter_values
    next_countervalue <= countervalue;
    -- check if counter has overflown:
    if(countervalue >=overflowvalue)then
        next_countervalue <= x"0000";
    end if;
    
end if;

end process counter_register;

end Behavioral;
