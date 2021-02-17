----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.02.2021 18:26:22
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port ( clk : in STD_LOGIC;
           mosi_top : out STD_LOGIC;
           miso_top : in STD_LOGIC;
           sck_top : out STD_LOGIC;
           cs_top : in STD_LOGIC);
end top;


architecture Behavioral of top is
component spi_master is
port(
 sys_clk : in std_logic;
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
end component spi_master;
begin


end Behavioral;
