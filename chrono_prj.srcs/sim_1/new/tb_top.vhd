
-- Module Name: tb_top - Behavioral
-- Project Name: chrono_prj

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is

component top is Port(
         --E/S component clock 
         CLK_IN : in STD_LOGIC;
         SEL_SPEED_CLK : in STD_LOGIC;
         --CLK_OUT_AFF : out STD_LOGIC;
         --CLK_OUT_COUNT : out STD_LOGIC; Gere en interne dans le top 
         
         -- E/S component Comptage
         CE : in std_logic;
         -- CLK : in std_logic; Pas necessaire car la CLK de ce module est la CLK de l'entity CLK_DIV
         RESET : in std_logic;
         TC : out std_logic;
         LED_OUT : out std_logic_vector (9 downto 0);
         --OUT_DIZ_MIN : out std_logic_vector (3 downto 0);
         --OUT_DIZ_SEC : out std_logic_vector (3 downto 0);
         --OUT_UNIT_MIN : out std_logic_vector (3 downto 0);
         --OUT_UNIT_SEC : out std_logic_vector (3 downto 0);
        
        
        -- E/S component Affichage
        --CLK          : in  STD_LOGIC;
        --RESET        : in  STD_LOGIC;
        -- OUT_UNIT_SEC : in  STD_LOGIC_VECTOR(3 downto 0);
        -- OUT_DIZ_SEC  : in  STD_LOGIC_VECTOR(3 downto 0);
        -- OUT_UNIT_MIN : in  STD_LOGIC_VECTOR(3 downto 0);
        -- OUT_DIZ_MIN  : in  STD_LOGIC_VECTOR(3 downto 0);
        ANODES       : out STD_LOGIC_VECTOR(3 downto 0); -- Sortie de U8
        AFF          : out STD_LOGIC_VECTOR(6 downto 0)  -- Sortie de U7
    );
        

         
         
 end component; 


-- *************************************************
--          Signaux internes pour la simulation :
--**************************************************

-- Sorties 
signal LED_OUT_int : std_logic_vector (9 downto 0);
signal OUT_DIZ_MIN_int, OUT_DIZ_SEC_int, OUT_UNIT_MIN_int, OUT_UNIT_SEC_int :  std_logic_vector (3 downto 0);
signal TC_int : std_logic ;
signal ANODES_int : std_logic_vector(3 downto 0); -- Pour voir quelle anode est active
signal AFF_int    : std_logic_vector(6 downto 0); -- Pour voir le segment allumé

-- INPUTS

-- Counter
signal RESET_int, CE_int : std_logic := '0';
-- CLK_DIV
signal sel_speed_int : STD_LOGIC :='0'; 
signal clk_out_aff_s : std_logic ; 
signal clk_int,clk_out_count_s : std_logic :='0'; 


-- **********************************************
--                  begin 
-- **********************************************

begin

 -- Top Instantiation 

chronometre : top port map (CLK_IN => clk_int, 
                            SEL_SPEED_CLK => sel_speed_int, 
                            --CLK_OUT_AFF => clk_out_aff_s, 
                            CE => CE_int, RESET => RESET_int, 
                            TC => TC_int, LED_OUT => LED_OUT_int, 
                            --OUT_DIZ_MIN => OUT_DIZ_MIN_int, 
                            --OUT_DIZ_SEC => OUT_DIZ_SEC_int, 
                            --OUT_UNIT_MIN => OUT_UNIT_MIN_int,
                            --OUT_UNIT_SEC => OUT_UNIT_SEC_int, 
                            ANODES        => ANODES_int,
                            AFF           => AFF_int);

-- *************************************
--           Generated Stimulus 
-- *************************************

-- 1. SEULE horloge nécessaire : l'horloge système 100MHz
clk_int <= not clk_int after 5 ns; 

-- 2. Paramètres de contrôle
CE_int    <= '1';
sel_speed_int <= '1'; -- '1' : cela active le mode rapide dans CLK_DIV (83612 cycles au lieu de 5 millions)

-- 3. Initialisation reset
--RESET_int <= '1', '0' after 100 ns;

-- 4. Valeurs de test pour voir le multiplexage
--OUT_UNIT_SEC_int <= "0001"; -- Affiche 1 sur AN0
--OUT_DIZ_SEC_int  <= "0010"; -- Affiche 2 sur AN1
--OUT_UNIT_MIN_int <= "0011"; -- Affiche 3 sur AN2
--OUT_DIZ_MIN_int  <= "0100"; -- Affiche 4 sur AN3


end Behavioral;
