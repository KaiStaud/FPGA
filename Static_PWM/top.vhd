----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.09.2020 20:17:10
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

entity top is
Port ( 
clk: in std_logic;
q: out std_logic
);
end top;

architecture Behavioral of top is

component stat_pwm_gen is port
(
clk: in std_logic;
q: out std_logic
);
end component;

component clock_divider is port
(
clk: in std_logic;
clk_out: out std_logic
);
end component;

component pwm_memory is port
(
clk : in STD_LOGIC;
update : in std_logic;
dutycycle : out unsigned(15 downto 0)
);
end component;

signal new_clk: std_logic;
signal dutycycle: unsigned(15 downto 0);

begin

pwm_gen: stat_pwm_gen port map
(
clk => clk,
q => q
);

clk_div: clock_divider port map
(
clk => clk,
clk_out => new_clk
);

pwm_mem: pwm_memory port map
(
clk =>clk,
update => new_clk,
dutycycle => dutycyle
);
end Behavioral;
