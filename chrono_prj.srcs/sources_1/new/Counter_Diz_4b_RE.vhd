----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2025 12:22:09
-- Design Name: 
-- Module Name: Counter_Diz_4b_RE - Behavioral
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

entity Counter_Diz_4b_RE is
    Port ( RESET : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (3 downto 0);
           TC : out STD_LOGIC);
end Counter_Diz_4b_RE;

architecture Behavioral of Counter_Diz_4b_RE is
signal OUTPUT_int : unsigned (3 downto 0) := (others => '0');
signal TC_int : STD_LOGIC := '0';

begin
process (RESET,CLK,OUTPUT_int,TC_int)
begin 
    if RESET = '1' then 
        OUTPUT_int <= (others => '0');
        TC_int <= '0';
    elsif rising_edge (CLK) then 
        if OUTPUT_int = "0101" then
            OUTPUT_int <= (others => '0');
            TC_int <= '1';
        elsif TC_int = '1' then
            TC_int <= '0';
            OUTPUT_int <= OUTPUT_int + 1;
        else
            OUTPUT_int <= OUTPUT_int + 1;
        end if; 
    end if; 
end process; 
OUTPUT <= std_logic_vector (OUTPUT_int);
TC <= std_logic (TC_int); 
end Behavioral;
