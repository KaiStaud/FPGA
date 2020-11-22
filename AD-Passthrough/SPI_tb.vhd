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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SPI_tb is
--  Port ( );
end SPI_tb;

architecture Behavioral of SPI_tb is

component SPI_Slave
port(
           SCK : in STD_LOGIC;
           MOSI : in STD_LOGIC;
           CS : in STD_LOGIC;
           data : out unsigned (15 downto 0)
);
end component;

signal SCK_tb: std_logic;
signal MOSI_tb	 : std_logic;
signal CS_tb : std_logic;
signal data_tb: unsigned (15 downto 0);
constant test_data : unsigned (15 downto 0) := x"06A0";    
begin
SPI_Receiver : SPI_Slave port map
			(
			SCK	=> SCK_tb,
			MOSI	=> MOSI_tb,
            CS => CS_tb,
            data => data_tb
			);
			 

		clock_generator : process
		begin
		    CS_tb <= '1';
		    WAIT for 0.5 ns;
		    CS_tb <= '0';
            -- One SPI Transmission
            for i in 0 to 15 loop
            SCK_tb <= '0';
            MOSI_tb <= test_data(i);
            WAIT FOR 0.5 ns;
            
            SCK_tb <= '1';
            WAIT FOR 0.5 ns;

            end loop;    
            SCK_tb <= '0';
            WAIT for 0.5 ns;
            CS_tb <= '1';
		    WAIT for 0.5 ns;

            
            -- Stop the simulation
            assert false report "Test: OK" severity failure;
        end process clock_generator;

end Behavioral;