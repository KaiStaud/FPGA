----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.05.2020 17:59:36
-- Design Name: 
-- Module Name: button - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- Debounces a bouncy button and returns a clean debounced signal
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity button is
    Port ( user_button : in STD_LOGIC;
           clk : in STD_LOGIC;
           q_d : out STD_LOGIC);
end button;

architecture Behavioral of button is

--Signal--
signal counter: unsigned( 15 downto 0):= x"0000";-- counter value
signal new_counter: unsigned(15 downto 0);
signal time_elapsed: std_logic;-- flag to enable sampling 
signal start_counter: std_logic := '0'; -- flag to start counting
-- Constants--
constant blocking_time: unsigned (15 downto 0) := x"000A";-- 10ms in ticks

begin

button_counter: process(clk,user_button)
begin
--once pushed start counting. counter needs to be zero to start
if(rising_edge(clk) and counter =x"0000") then
    start_counter <= '1';
end if;
end process button_counter;

delay: process(clk)
begin
-- when counter is started count up
if(rising_edge(clk) and start_counter <= '1')then
new_counter <= counter + x"0001";
end if;
--after delay time raise flagend if;  
if(rising_edge(clk) and counter = blocking_time)then
   time_elapsed <= '1'; 
end if;

end process;

button_sampler: process(clk,user_button)
begin
--after timeout sample into d- type flip flop
--set or reset q 
--reset the counter 

if(rising_edge(clk))then
    q_d <= user_button;
end if;
end process button_sampler;

reg: process(clk)
begin

if(rising_edge(clk)) then
counter <= new_counter;
--    if(new_counter >blocking_time)then --once overflown, reset counter
--        counter <= x"0000";
--    end if;    
end if;

end process;


end Behavioral;
