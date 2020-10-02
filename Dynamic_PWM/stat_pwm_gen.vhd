----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.09.2020 18:23:52
-- Design Name: 
-- Module Name: stat_pwm_gen - Behavioral
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
-- Takes the 125MHz Core Clock and generates an static PWM Signal with constant dutycycle
-- and constant frequency ( 50%, 10 kHz)
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

entity stat_pwm_gen is
    Port ( clk : in STD_LOGIC;
           q : out STD_LOGIC);
end stat_pwm_gen;

architecture Behavioral of stat_pwm_gen is


-- implementation set--
--constant topvalue:unsigned(15 downto 0):=x"30D4";
--constant comparevalue:unsigned(15 downto 0):=x"186A";

-- simulation set--
constant topvalue:unsigned(15 downto 0):=x"0009";
constant comparevalue:unsigned(15 downto 0):=x"0004";

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
    if(dutycycle_count <= comparevalue) then
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
