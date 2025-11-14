----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Radu et Ramiro
-- 
-- Create Date: 14.11.2025 17:55:16
-- Design Name: 
-- Module Name: CLK_DIV - Behavioral
-- Project Name: chrono_prj
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

entity CLK_DIV is
    Port ( CLK_IN : in STD_LOGIC;
           SEL_SPEED_CLK : in STD_LOGIC;
           CLK_OUT_AFF : out STD_LOGIC;
           CLK_OUT_COUNT : out STD_LOGIC);
end CLK_DIV;

architecture Behavioral of CLK_DIV is
signal Q_int : unsigned (23 downto 0) := (others => '0'); -- compteur de 0 - 10^7 pour diviser la frequence
signal clk_out_count_int : std_logic := '0';

begin

-- Process du comptage de 0 a 10^7 - 1 pour avoir 10 Hz
    process(CLK_IN,SEL_SPEED_CLK)
        begin
        if SEL_SPEED_CLK = '0' then 
            Q_int <= (others => '0');
            clk_out_count_int <= '0';
        elsif rising_edge (CLK_IN) then 
            if Q_int = 9999999 then
                Q_int <= (others => '0');
                clk_out_count_int <= not clk_out_count_int;
            else
                Q_int <= Q_int + 1; 
            end if;
        end if;
    end process;
    
    CLK_OUT_COUNT <= clk_out_count_int;


end Behavioral;
