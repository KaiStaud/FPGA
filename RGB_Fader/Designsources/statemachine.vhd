----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2020 20:55:19
-- Design Name: 
-- Module Name: statemachine - Behavioral
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
-- Controls the colors of the led:
-- All Off - R - RG - RGB -  RB -  BG - G - AllOff 
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

entity statemachine is
    Port ( clk : in STD_LOGIC;
    color_saturated: in std_logic_vector(2 downto 0); -- add_gen reached limit
    color_reset: out std_logic_vector(2 downto 0) -- reset the addr_gen
    );
end statemachine;

architecture Behavioral of statemachine is

type state_color is (RGB,GB,b,RB,R,RG,G,Off);
 signal color, next_color:state_color:= Off;

begin

color_cycle:process(clk,color)
begin

case color is

when RGB =>
if(color_saturated = b"111") then
next_color <= GB;
else
next_color <= RGB;
end if;

when  GB =>
if(color_saturated = b"011") then
next_color <= B;
else
next_color <= GB;
end if;

when B =>
if(color_saturated = b"001") then
next_color <= RB;
else
next_color <= B;
end if;

when RB => 
if(color_saturated = b"101") then
next_color <= R;
else
next_color <= RB;
end if;

when R =>
if(color_saturated = b"100") then
next_color <= RG;
else
next_color <= R;
end if;

when RG =>
if(color_saturated = b"110") then
next_color <= G;
else
next_color <= RG;
end if;

when G =>
if(color_saturated = b"010") then
next_color <= Off;
else
next_color <= G;
end if;

when Off =>
if(color_saturated = b"000")then
next_color <= RGB;
else
next_color <= Off;
end if;

end case;

end process color_cycle;

end Behavioral;
