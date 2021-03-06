----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2020 20:26:55
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
  Port (
        clk : in STD_LOGIC;
        user_button: in STD_LOGIC;
        q_d: out STD_LOGIC;
        q : out STD_LOGIC
         );
end top;

architecture RTL of top is

component pwm is
Port(
        clk: in std_logic;
        q: out std_logic
    );
end component;

component button is
Port(
    user_button: in std_logic;
    clk : in std_logic;
    q_d : out std_logic
    );
end component;

begin

modul_pwm: pwm port map 
(
clk => clk,
q => q
);

modul_button : button port map
(
user_button => user_button,
clk => clk,
q_d => q_d
);

end RTL;
