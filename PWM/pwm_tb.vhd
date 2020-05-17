----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2020 19:20:29
-- Design Name: 
-- Module Name: pwm_tb - Behavioral
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
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm_tb is
--  Port ( );
end pwm_tb;

architecture Behavioral of pwm_tb is

component pwm
port(
clk: in std_logic;
q : out std_logic
);
end component;

signal clk_tb: std_logic;
signal q_tb	 : std_logic;

begin
DUT_pwm : pwm port map
			(
			clk	=> clk_tb,
			q	=> q_tb
			);
			 

		clock_generator : process
		begin
			clk_tb <= '0';
			WAIT FOR 0.5 ns;

			clk_tb <= '1';
			WAIT FOR 0.5 ns;
		end process clock_generator;

end Behavioral;
