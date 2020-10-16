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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity statemachine is
    Port ( clk : in STD_LOGIC;
    pwm_limit_reached: in std_logic_vector(2 downto 0); -- add_gen reached limit
    value_to_adder: out std_logic_VECTOR(2 downto 0) -- 1 -> increase until upper limit; 0-> decrease until lower limit
                                                     -- at limit: transition (pwm_limit_reached) enables new state!, no error handling/preventing
                                                      -- necessary! 
    );
end statemachine;

architecture Behavioral of statemachine is

type state_color is (RGB,GB,b,RB,R,RG,G,Off);
 signal color, next_color:state_color:= Off;

begin

color_cycle:process(clk,color)
begin
if(rising_edge(clk))then
case color is

    when RGB =>
    if(pwm_limit_reached = b"011") then
    next_color <= GB;
    else
    next_color <= RGB;
    --reduce R until it reaches zero
    end if;
    value_to_adder <= b"011";
    
    when  GB =>
    if(pwm_limit_reached = b"001") then -- only blue active
    next_color <= B;
    else
    next_color <= GB;
    end if;
    value_to_adder <= B"001";
    
    when B =>
    if(pwm_limit_reached = b"101") then
    next_color <= RB;
    else
    next_color <= B;
    end if;
    value_to_adder <= b"101";
    
    when RB => 
    if(pwm_limit_reached = b"100") then
    next_color <= R;
    else
    next_color <= RB;
    end if;
    value_to_adder <= "100";
    
    when R =>
    if(pwm_limit_reached = b"110") then
    next_color <= RG;
    else
    next_color <= R;
    end if;
    value_to_adder <= "110";
    
    when RG =>
    if(pwm_limit_reached = b"010") then
    next_color <= G;
    else
    next_color <= RG;
    end if;
    value_to_adder <= "010";
    
    when G =>
    if(pwm_limit_reached = b"000") then
    next_color <= Off;
    else
    next_color <= G;
    end if;
    value_to_adder <= b"000";
    
    when Off =>
    if(pwm_limit_reached = b"111")then
    next_color <= RGB;
    else
    next_color <= Off;
    end if;
    value_to_adder <= "111";

end case;
end if;
end process color_cycle;

statemachine_register: process(clk)
begin
if(rising_edge(clk)) then
color <= next_color;
end if;

end process statemachine_register;

end Behavioral;
