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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_master_tb is
--  Port ( );
end spi_master_tb;

architecture Behavioral of spi_master_tb is

component spi_master
    Port ( sys_clk : in std_logic;
           clk_in : in STD_LOGIC; -- this is the spi clock, not the sys clock!
           sck : out STD_LOGIC;
           cs : out STD_LOGIC;
           miso : in STD_LOGIC;
           mosi : out STD_LOGIC;
           rdy : out std_logic; -- master finished transmission
           new_data : in std_logic; -- new data available
           data_in : in std_logic_vector (7 downto 0); --from fpga to spi entity
           data_out: out std_logic_vector(7 downto 0) -- form outside the fpga into the entity
           );
end component;


signal sys_clk_tb: std_logic;
signal clk_in_tb : STD_LOGIC; -- this is the spi clock, not the sys clock!
signal sck_tb :  STD_LOGIC;
signal cs_tb :  STD_LOGIC;
signal miso_tb : STD_LOGIC;
signal mosi_tb : STD_LOGIC;
signal rdy_tb : std_logic; -- master finished transmission
signal new_data_tb : std_logic; -- new data available
signal data_in_tb : std_logic_vector (7 downto 0):= x"f3";
signal data_out_tb : std_logic_vector (7 downto 0):= x"00";

signal miso_test : std_logic_vector (11 downto 0) := x"123";
begin

DUT_spi_master : spi_master port map
			(
			sys_clk	=> sys_clk_tb,
			clk_in => clk_in_tb,
			sck => sck_tb,
			cs => cs_tb,
			miso => miso_tb,
			mosi => mosi_tb,
			rdy => rdy_tb,
			new_data =>new_data_tb,
			data_in => data_in_tb,
			data_out => data_out_tb
			);
			 

		clock_generator : process
		begin
			sys_clk_tb <= '0';
			WAIT FOR 0.5 ns;

			sys_clk_tb <= '1';
			WAIT FOR 0.5 ns;
		end process clock_generator;
		
		spi_generator: process
		begin
		new_data_tb <= '1';
		WAIT FOR 1 ns;
        new_data_tb <= '0';
		-- generate 8 clock cycles
		for i in 0 to 10 loop
			clk_in_tb <= '0';
			WAIT FOR 0.5 ns;

			clk_in_tb <= '1';
			miso_tb <= miso_test(i);
			WAIT FOR 0.5 ns;
		end loop;
		            -- Stop the simulation
            assert false report "Test: OK" severity failure;
		end process spi_generator;
		
		

end Behavioral;