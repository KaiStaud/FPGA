----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2020 19:15:01
-- Design Name: 
-- Module Name: pwm_memory - Behavioral
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
-- Implements nine different dutycycles for a linear fade
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

entity pwm_memory is
    Port ( clk : in STD_LOGIC;
           addr : in unsigned(3 downto 0);
           dutycycle : out unsigned(15 downto 0));
end pwm_memory;

architecture Behavioral of pwm_memory is

   -- ROM-Feld als Signaltyp definieren
    type rom_mem is array (0 to 9) of unsigned(15 downto 0);
    constant ROM5 : rom_mem := (
        0  => x"0000",  -- 0
        1  => x"0001",  -- 62 (5%)
        2  => x"0002",  -- 125 (10%)
        3  => x"0003",  -- 187 (15%)
        4  => x"0004",  -- 275 (22%)
        5  => x"0005",  -- 375 (30%)
        6  => x"0006",  -- 500 (40%)
        7  => x"0007",  -- 650 (52%)
        8  => x"0009",  -- 875 (70%)
        9  => x"000A");  -- 1250 (100%)

begin

rom_read: process(clk,addr)
begin 
case addr is
            when x"0" => dutycycle <= ROM5(0);
            when x"1" => dutycycle <= ROM5(1);
            when x"2" => dutycycle <= ROM5(2);
            when x"3" => dutycycle <= ROM5(3);
            when x"4" => dutycycle <= ROM5(4);
            when x"5" => dutycycle <= ROM5(5);
            when x"6" => dutycycle <= ROM5(6);
            when x"7" => dutycycle <= ROM5(7);
            when x"8" => dutycycle <= ROM5(8);
            when x"9" => dutycycle <= ROM5(9);
            when others => dutycycle <= ROM5(0);
        end case;

end process;

end Behavioral;
