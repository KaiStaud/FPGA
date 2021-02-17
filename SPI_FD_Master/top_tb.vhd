----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.02.2021 18:39:06
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
Port(
            clk : in STD_LOGIC;
           mosi_top : out STD_LOGIC;
           miso_top : in STD_LOGIC;
           sck_top : out STD_LOGIC;
           cs_top : out STD_LOGIC);
           end component;


signal sys_clk_tb: std_logic;
signal clk_in_tb : STD_LOGIC; -- this is the spi clock, not the sys clock!
signal sck_tb :  STD_LOGIC;
signal cs_tb :  STD_LOGIC;
signal miso_tb : STD_LOGIC;
signal mosi_tb : STD_LOGIC;

begin

DUT_top : top port map
			(
			clk	=> sys_clk_tb,
			sck_top => sck_tb,
			cs_top => cs_tb,
			miso_top => miso_tb,
			mosi_top => mosi_tb
			);
			 

		clock_generator : process
		begin
		
		for i in 0 to 8 loop
			sys_clk_tb <= '0';
			WAIT FOR 0.5 ns;

			sys_clk_tb <= '1';
			WAIT FOR 0.5 ns;
			
			assert false report "Test: OK" severity failure;
        end loop;
        -- Stop the simulation
        
		end process clock_generator;

end Behavioral;