----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2020 19:15:37
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
rgb_q : out std_logic_vector(2 downto 0)
);
end component;


signal clk_tb: std_logic;
signal rgb_q_tb : std_logic_vector(2 downto 0);

begin

DUT_top : top port map
			(
			clk	=> clk_tb,
			rgb_q => rgb_q_tb
			);
			 

		clock_generator : process
		begin
			clk_tb <= '0';
			WAIT FOR 0.5 ns;

			clk_tb <= '1';
			WAIT FOR 0.5 ns;
		end process clock_generator;

end Behavioral;