----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2020 18:54:06
-- Design Name: 
-- Module Name: pwm - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- Implements a pwm signal @ 1kHz 50% dutycycle 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity pwm is
    Port ( clk :     in STD_LOGIC;
           q :       out STD_LOGIC
--           ext_freq:     in unsigned(15 downto 0);
--           ext_dutycyle: in unsigned(15 downto 0)
         );
end pwm;

architecture Behavioral of pwm is

-- Signals and Constant for PWM Creation--
--constant topvalue : unsigned (15 downto 0) := x"30D4";
--signal dutycycle  : unsigned (15 downto 0) := x"186A";
--signal count      : unsigned (15 downto 0) := x"0000";
--constant topvalue_1ms : unsigned (23 downto 0) := x"01E848";
--signal count_1ms      : unsigned (23 downto 0) := x"000000";

--Simulation Set--
constant topvalue :     unsigned (15 downto 0) := x"000A";
signal dutycycle  :     unsigned (15 downto 0) := x"0008";
signal count      :     unsigned (15 downto 0) := x"0000";
constant topvalue_1ms : unsigned (15 downto 0) := x"0014";
signal count_1ms      : unsigned (15 downto 0) := x"0000";

begin

--Increment counter--
counter : process(clk)
begin
if(rising_edge(clk)) then
    count <= count + x"0001";
if(count > topvalue) then
    count <= x"0000";
end if;
end if;
end process counter;

SR_Q : process(clk)
begin
if(rising_edge (CLK))then
    if(count < dutycycle) then
        q <= '1';
    else
        q <= '0';
    end if;
end if;
end process SR_Q;

end Behavioral;