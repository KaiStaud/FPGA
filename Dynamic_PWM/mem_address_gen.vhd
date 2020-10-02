----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2020 19:15:01
-- Design Name: 
-- Module Name: mem_address_gen - Behavioral
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
-- Generates a new dutycycle address every second
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

entity mem_address_gen is
    Port ( clk : in STD_LOGIC;
           addr : out unsigned(3 downto 0)
           );
end mem_address_gen;

architecture Behavioral of mem_address_gen is

--constant topvalue:unsigned(27 downto 0):=x"0000009";
 
-- simulation set--
constant topvalue:unsigned(27 downto 0):=x"0000009";

-- independent signals--
signal count,next_count: unsigned(27 downto 0):= x"0000000";
signal int_addr, next_int_addr:unsigned (3 downto 0):=x"0";


begin

addr <= int_addr;

upcounter: process(clk)
begin
if(rising_edge(clk)) then
    count <= next_count +x"0000001";

    if(next_count >= topvalue) then
        count <= x"0000000"; 
        int_addr <= next_int_addr+ x"1";   
    end if;
    
    if( next_int_addr >= x"A")then
        int_addr <= x"0";
    end if;

end if;

end process upcounter;

counter_register: process(clk)
begin
if(rising_edge(clk))then
 next_count  <= count;
 next_int_addr <= int_addr;
end if;
end process counter_register;

end Behavioral;
