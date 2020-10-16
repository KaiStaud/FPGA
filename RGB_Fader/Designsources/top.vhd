----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2020 20:55:19
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
    Port ( clk : in STD_LOGIC);
end top;

architecture Behavioral of top is

component address_generator is
port(
    clk : in STD_LOGIC;
    addr : out unsigned(3 downto 0);
    dir: in std_logic;
    limit_reached : out std_logic
    );
end component;

component statemachine is
port(
clk : in STD_LOGIC;
    pwm_limit_reached: in std_logic_vector(2 downto 0);
    value_to_adder: out std_logic_VECTOR(2 downto 0)
);
end component;

signal r_addr,g_addr,b_addr: unsigned(3 downto 0);
signal int_value_to_adder,int_pwm_limit_reached: std_logic_vector(2 downto 0);
signal int_dir: std_logic;
begin

i_statemachine: statemachine port map
(
clk => clk,
pwm_limit_reached => int_pwm_limit_reached,
value_to_adder => int_value_to_adder
);

-- assign each bit of the value_to_adder bus to one input of an address generator
-- one instance per color
i_r_address_generator: address_generator port map
(
clk => clk,
addr => r_addr,
dir => int_value_to_adder(2),
limit_reached => int_pwm_limit_reached(2)
);

i_g_address_generator: address_generator port map
(
clk => clk,
addr => g_addr,
dir => int_value_to_adder(1),
limit_reached => int_pwm_limit_reached(1)
);

i_b_address_generator: address_generator port map
(
clk => clk,
addr => b_addr,
dir => int_value_to_adder(0),
limit_reached => int_pwm_limit_reached(0)
);


end Behavioral;
