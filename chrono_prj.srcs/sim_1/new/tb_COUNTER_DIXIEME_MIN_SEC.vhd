----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2025 12:44:59
-- Design Name: 
-- Module Name: tb_COUNTER_DIXIEME_MIN_SEC - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_COUNTER_DIXIEME_MIN_SEC is
--  Port ( );
end tb_COUNTER_DIXIEME_MIN_SEC;

architecture Behavioral of tb_COUNTER_DIXIEME_MIN_SEC is

component COUNTER_DIXIEME_MIN_SEC is 
    Port( CE : in std_logic;
          CLK : in std_logic;
          RESET : in std_logic;
          TC : out std_logic;
          LED_OUT : out std_logic_vector (9 downto 0);
          OUT_DIZ_MIN : out std_logic_vector (3 downto 0);
          OUT_DIZ_SEC : out std_logic_vector (3 downto 0);
          OUT_UNIT_MIN : out std_logic_vector (3 downto 0);
          OUT_UNIT_SEC : out std_logic_vector (3 downto 0)
          );
end component;
-- OUTPUTS
signal LED_OUT_int : std_logic_vector (9 downto 0);
signal OUT_DIZ_MIN_int, OUT_DIZ_SEC_int, OUT_UNIT_MIN_int, OUT_UNIT_SEC_int :  std_logic_vector (3 downto 0);
signal TC_int : std_logic ;
-- INPUTS
signal RESET_int, CLK, CE : std_logic := '0';

begin   

COUNTER_DIXIEME_MIN_SEC_1 : COUNTER_DIXIEME_MIN_SEC port map ( RESET => RESET_int, CLK => CLK, 
CE => CE, LED_OUT => LED_OUT_int, OUT_DIZ_MIN => OUT_DIZ_MIN_int, OUT_DIZ_SEC => OUT_DIZ_SEC_int, 
OUT_UNIT_MIN => OUT_UNIT_MIN_int, OUT_UNIT_SEC => OUT_UNIT_SEC_int, TC => TC_int); 

CLK <= not CLK after 5 ns; -- 50 ms

process 
begin
    wait for 50 ns;
    CE <= '1'; 
    wait for 5000000 ns;
    RESET_int <= '1'; 
    wait for 100 ns;
    RESET_int <= '0';
    wait for 50 ns;
    CE <= '0'; 
    wait; 
end process;

end Behavioral;
