----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2025 09:36:42
-- Design Name: 
-- Module Name: tb_counter_4b_R - Behavioral
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

entity tb_counter_4b_R is
--  Port ( );
end tb_counter_4b_R;

architecture Behavioral of tb_counter_4b_R is

component counter_4b_R is 
    Port(  ARESET : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal Q_int : std_logic_vector (3 downto 0); 
signal ARESET_int, CLK : std_logic := '0';

begin

counter_4b_R_1 : counter_4b_R port map(ARESET => ARESET_int, CLK => CLK, Q => Q_int); 
CLK <= not CLK after 5ns;

process 
begin 

    wait for 100ns;
    ARESET_int <= '1'; 
    wait for 20ns;
    ARESET_int <= '0'; 
    wait; 
end process; 
end Behavioral;
