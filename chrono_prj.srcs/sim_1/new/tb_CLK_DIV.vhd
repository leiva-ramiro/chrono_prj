----------------------------------------------------------------------------------
-- Company: INSA de Lyon 
-- Engineer: Radu et Ramiro 
-- 
-- Create Date: 07.11.2025 12:12:33
-- Design Name: 
-- Module Name: tb_CLK_DIV Bench
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

entity tb_CLK_DIV is
end tb_CLK_DIV;

architecture Behavioral of tb_CLK_DIV is

-- Module Declaration 

component CLK_DIV
Port (     CLK_IN : in STD_LOGIC;
           SEL_SPEED_CLK : in STD_LOGIC;
           CLK_OUT_AFF : out STD_LOGIC;
           CLK_OUT_COUNT : out STD_LOGIC);
end component;

signal clk_int : STD_LOGIC :='0';
signal sel_speed_int : STD_LOGIC :='0';
signal clk_out_aff_s   : std_logic;
signal clk_out_count_s : std_logic;



begin

-- Module Mapping 
-- Attention : Tous les signaux du module doivent etre connecte
clk_div_1 : CLK_DIV port map (CLK_IN => clk_int , SEL_SPEED_CLK => sel_speed_int, CLK_OUT_COUNT => clk_out_count_s,CLK_OUT_AFF => clk_out_aff_s);
-- Frequence de l'horloge invariable 
 clk_int <= not clk_int after 5 ns;

 
 process 
 begin 
    sel_speed_int <= '0';
    wait for 1000 ms; 
    sel_speed_int <= '1';
    wait for 1000 ms;
 end process;
  
end Behavioral;
