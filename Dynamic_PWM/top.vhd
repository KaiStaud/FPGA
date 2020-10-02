----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2020 19:15:01
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk : in STD_LOGIC;
           q_led : out STD_LOGIC);
end top;

architecture Behavioral of top is

component stat_pwm_gen is
port(
clk:in std_logic;
q:out std_logic
);
end component;

component mem_address_gen is
port(
clk:in std_logic;
addr: out unsigned(3 downto 0)
);
end component;

component pwm_memory is
port(
clk:in std_logic;
addr: in unsigned(3 downto 0);
dutycycle:out unsigned(15 downto 0)
);
end component;

signal addr: unsigned(3 downto 0);
signal mem_data: unsigned(15 downto 0);


begin

i_stat_pwm_gen: stat_pwm_gen port map
(
clk => clk,
q => q_led
);

i_mem_address_gen:mem_address_gen port map
(
clk => clk,
addr => addr
);

i_pwm_mem: pwm_memory port map
(
clk => clk,
addr => addr,
dutycycle => mem_data
);

end Behavioral;
