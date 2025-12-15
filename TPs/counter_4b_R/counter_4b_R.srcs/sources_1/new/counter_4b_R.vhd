----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2025 09:28:29
-- Design Name: 
-- Module Name: counter_4b_R - Behavioral
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

entity counter_4b_R is
    Port ( ARESET : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end counter_4b_R;

architecture Behavioral of counter_4b_R is
signal Q_int : unsigned (3 downto 0) := (others => '0'); 
 
begin
process (ARESET,CLK)
begin 
    if ARESET = '1' then 
        Q_int <= (others => '0');
    elsif rising_edge (clk) then 
        Q_int <= Q_int + 1; 
    end if; 
end process; 
Q <= std_logic_vector (Q_int);  
end Behavioral;
