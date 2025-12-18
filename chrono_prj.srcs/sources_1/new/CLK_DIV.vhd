----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Radu et Ramiro
-- 
-- Create Date: 14.11.2025 17:55:16
-- Design Name: Clock
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

-- Signals :
--           CLK_IN        : Horloge d'entrée 100 MHz
--           CLK_OUT_COUNT : Comptage de diziemes de secondes : 10 Hz 
--           SEL_SPEED_CLK : Switch de selection pour une frequence plus rapide : (T_sel = 1.67ms) T/60 . 1 minute en 1 seconde
--           CLK_OUT_AFF   : Horloge pour l'affichage sur les afficheurs 7 segments 


entity CLK_DIV is
    Port ( CLK_IN : in STD_LOGIC;
           SEL_SPEED_CLK : in STD_LOGIC;
           CLK_OUT_AFF : out STD_LOGIC;
           CLK_OUT_COUNT : out STD_LOGIC);
end CLK_DIV;

architecture Behavioral of CLK_DIV is

-- Signaux pour le comptage de fronts pour diviser la frequence

-- Il faut au moins 24 bits pour compter jusqu'a 100 000 000 
-- La valeur max du comptage a ete calculé en faisant le rapport de la periode de sortie sur la periode d'entree 
signal Q_int_clk_lent : unsigned (23 downto 0) := (others => '0'); -- compteur de 0 - 10^7/2 pour diviser la frequence : 10 Hz,0,1s
signal Q_int_clk_rapide : unsigned (17 downto 0) := (others => '0'); -- compteur de 0 - 167 000/2 pour avoir une frequence 60 plus vite : 600 Hz, 1,67ms 
signal Q_int_clk_aff : unsigned (18 downto 0) := (others => '0'); -- compteur de 0 - 
signal clk_out_count_int : std_logic := '0'; 
signal clk_out_count_int_aff : std_logic := '0'; --8ms

begin


-- On ne peut pas lire un signal de sortie, alors il faut passer par une varibale de buffer
    CLK_OUT_COUNT <= clk_out_count_int;
    CLK_OUT_AFF <= clk_out_count_int_aff;

-- Process du comptage de 0 a 10^7 - 1 pour avoir 10 Hz
    process(CLK_IN)
        begin
        if(rising_edge(CLK_IN)) then 
            if (SEL_SPEED_CLK = '0') then -- Choix de la frequence lente
                Q_int_clk_rapide <= (others => '0'); -- RAZ du compteur rapide
                if Q_int_clk_lent = 4999999 then -- valeur du comptage max de 0 a 4 999 999 pour generer le sigal carré. 
                    Q_int_clk_lent <= (others => '0'); -- reset du compteur 
                    clk_out_count_int <= not clk_out_count_int; -- toggle du signal int
                else
                    Q_int_clk_lent <= Q_int_clk_lent + 1; -- sinon, on continue a compter 
                end if;
            else
                Q_int_clk_lent <= (others => '0'); -- RAZ du compteur lent
                if Q_int_clk_rapide = 83335 then -- valeur du comptage max 0.1/60 pour une horloge 60 fois plus rapide
                    Q_int_clk_rapide <= (others => '0'); -- reset du compteur 
                    clk_out_count_int <= not clk_out_count_int; -- toggle du signal int
                else
                    Q_int_clk_rapide <= Q_int_clk_rapide + 1; -- sinon, on continue a compter 
                end if;
            end if; 
        end if;
    end process;
    
    -- Pour ne pas avoir de la persistence retinienne il faut une periode d'affichage de 1-16ms par afficheur, 
    -- donc si on a 4 afficheurs il faut 4 fois la periode choisi. 
    
    process (CLK_IN) 
    begin
    if(rising_edge(CLK_IN)) then           
        if Q_int_clk_aff = 100000 then -- 2ms / 8ms pour les 4 afficheurs
            Q_int_clk_aff <= (others => '0'); -- reset du compteur 
            clk_out_count_int_aff <= not clk_out_count_int_aff; -- toggle du signal int
        else 
            Q_int_clk_aff <= Q_int_clk_aff + 1;
        end if;
    end if; 
    end process; 
    
end Behavioral;
