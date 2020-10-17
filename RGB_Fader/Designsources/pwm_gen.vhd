----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Kai Staud
-- 
-- Create Date: 29.09.2020 18:23:52
-- Design Name: 
-- Module Name: stat_pwm_gen - Behavioral
-- Project Name: 
-- Target Devices: Digilent Cora Z7s
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- Takes the 125MHz Core Clock and generates an PWM Signal.
-- The entity expects an input for the dutycyle.
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

entity pwm_gen is
    Port ( clk : in STD_LOGIC;
           q : out STD_LOGIC;
           dutycycle: in unsigned(15 downto 0)
           );
end pwm_gen;

architecture Behavioral of pwm_gen is


-- implementation set--
constant topvalue:unsigned(15 downto 0):=x"30D4";

-- simulation set--
--constant topvalue:unsigned(15 downto 0):=x"0009";

-- independent signals--
signal dutycycle_count,next_dutycycle_count: unsigned(15 downto 0):= x"0000";

begin

upcounter: process(clk)
begin
if(rising_edge(clk)) then
    dutycycle_count <= next_dutycycle_count +x"0001";

    if(next_dutycycle_count >= topvalue) then
        dutycycle_count <= x"0000";    
    end if;

end if;

end process upcounter;

SR_Q: process(clk)
begin
if(rising_edge(clk))then
    if(dutycycle_count <= dutycycle) then
        q <= '1';
    else
        q <= '0';
    end if;
    
end if;

end process SR_Q;


counter_register: process(clk)
begin
if(rising_edge(clk))then
 next_dutycycle_count  <= dutycycle_count;
end if;
end process counter_register;

end Behavioral;
