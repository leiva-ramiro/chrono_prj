----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2025 12:12:33
-- Design Name: 
-- Module Name: test - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test is
--  Port ( ); 
end test;

architecture Behavioral of test is

component CLK_DIV
Port (      CLK_IN : in STD_LOGIC;
           SEL_SPEED_CLK : in STD_LOGIC;
           CLK_OUT_AFF : out STD_LOGIC;
           CLK_OUT_COUNT : out STD_LOGIC);
end component;

signal clk_int : STD_LOGIC :='0';
signal sel_speed_int : STD_LOGIC :='0';

begin

clk_div_1 : CLK_DIV
port map (CLK_IN => clk_int , SEL_SPEED_CLK => sel_speed_int );

    clk_int <= not clk_int after 10 ns;
    sel_speed_int <= '1';
    
    
end Behavioral;
