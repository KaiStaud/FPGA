----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.10.2020 14:12:11
-- Design Name: 
-- Module Name: clock_divider - Behavioral
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
-- Component divides the input clock down to  200 Hz
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

entity clock_divider is
    Port ( clk : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is


-- implementation set--
--constant topvalue:unsigned(15 downto 0):=x"30D4";

-- simulation set--
constant topvalue:unsigned(15 downto 0):=x"0009";

-- independent signals--
signal count,next_count: unsigned(15 downto 0):= x"0000";

begin

upcounter: process(clk)
begin
if(rising_edge(clk)) then
    count <= next_count +x"0001";

    if(next_count >= topvalue) then
        count <= x"0000";    
    end if;

end if;

end process upcounter;

SR_Q: process(clk)
begin
if(rising_edge(clk))then
    if(count = topvalue) then
        clk_out <= '1';
    else
        clk_out <= '0';
    end if;
    
end if;

end process SR_Q;


counter_register: process(clk)
begin
if(rising_edge(clk))then
 next_count  <= count;
end if;
end process counter_register;

end Behavioral;