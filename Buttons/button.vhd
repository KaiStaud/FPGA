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
-- Default State of the button is hard coded to '0' -> Pull down.
-- Modification to this needs to be done in constant default_state
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
signal counter: unsigned( 23 downto 0):= x"000000";-- counter values
signal new_counter: unsigned(23 downto 0):= x"000000";

-- Constants--
--constant time_out: unsigned (19 downto 0) := x"0000A";
constant time_out : unsigned (23 downto 0) := x"1312D0";-- 10ms in ticks

constant default_state: std_logic := '0';
begin

-- count clock ticks --
timer: process(counter)
begin
   
        if(counter < time_out) then
            new_counter <= counter +x"000001";
        else
            new_counter <= time_out;         
    
        end if;   
    
end process timer;

sampler: process(counter,user_button)
begin

if(counter >=  time_out) then
    q_d <= user_button;
else
    q_d <= default_state;        
end if;

end process sampler;

reg : process(clk,user_button)
begin

if(user_button = default_state) then
    counter <= x"000000";
--end if;    

elsif(rising_edge(clk)) then
    counter <= new_counter;
end if;

end process reg;

end Behavioral;
