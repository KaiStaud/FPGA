----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2020 19:39:28
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk : in STD_LOGIC);
end top;

architecture Behavioral of top is

component clock_divider is port 
(
clk: in std_logic;
clk_out: out std_logic
);
end component;

component dutycycle_generator is port
(
clk : in STD_LOGIC;
increment : in STD_LOGIC;
dutycycle : out unsigned (15 downto 0)
);
end component;

signal slow_clk:std_logic;
signal dutycycle_int: unsigned (15 downto 0);

begin

clk_div: clock_divider port map
(
clk =>clk,
clk_out => slow_clk
);

dutycycle_gen: dutycycle_generator port map
(
clk => clk,
increment => slow_clk,
dutycycle => dutycycle_int
);

end Behavioral;
