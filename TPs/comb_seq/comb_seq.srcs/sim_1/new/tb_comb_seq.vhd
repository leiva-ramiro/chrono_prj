----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2025 09:00:42
-- Design Name: 
-- Module Name: tb_comb_seq - Behavioral
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

entity tb_comb_seq is
--  Port ( );
end tb_comb_seq;

architecture Behavioral of tb_comb_seq is

component comb_seq is 
    Port(  input1 : in STD_LOGIC;
           input2 : in STD_LOGIC;
           out_and : out STD_LOGIC;
           out_latch : out STD_LOGIC);
   end component;
   
signal input1_int, input2_int : STD_LOGIC := '0';
signal out_latch_int, out_and_int : STD_LOGIC;

begin

comb_seq_1 : comb_seq port map( input1 => input1_int, input2 => input2_int, out_and => out_and_int, out_latch => out_latch_int);
process 
begin 
wait for 20ns; 
input1_int <= '1'; 
wait for 20ns; 
input2_int <= '1'; 
wait for 100ns; 
input1_int <= '0';
wait for 20ns; 
input2_int <='0'; 
wait for 20ns; 
input1_int <= '1'; 
wait for 60ns; 
input2_int <= '1';
wait;
end process; 

end Behavioral;
