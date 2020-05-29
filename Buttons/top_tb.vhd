----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2020 21:31:34
-- Design Name: 
-- Module Name: top_tb - Behavioral
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

entity top_tb is
--  Port ( );
end top_tb;

architecture Behavioral of top_tb is

component top
port(
clk: in std_logic;
user_button : in std_logic;
q_d : out std_logic;
q : out std_logic
);
end component;

signal clk_tb: std_logic;
signal q_tb	 : std_logic;
signal user_button_tb : std_logic;
signal q_d_tb :std_logic;

begin
DUT_top : top port map
			(
			clk	=> clk_tb,
			user_button => user_button_tb,
			q_d => q_d_tb,
			q	=> q_tb
			);
			 

		clock_generator : process
		begin
			clk_tb <= '0';
			WAIT FOR 0.5 ns;

			clk_tb <= '1';
			WAIT FOR 0.5 ns;
		end process clock_generator;

		button_generator : process
		begin
			user_button_tb <= '0';
			WAIT FOR 1 ns;

			user_button_tb <= '1';
			WAIT FOR 0.5 ns;
		end process button_generator;

end Behavioral;
