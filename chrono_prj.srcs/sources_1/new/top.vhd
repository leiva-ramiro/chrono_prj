----------------------------------------------------------------------------------
-- Module Name: top - Behavioral
-- Project Name: chrono_prj
-- Description: Top module entity 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;

entity top is Port(

         --E/S component clock 
         CLK_IN : in STD_LOGIC;
         SEL_SPEED_CLK : in STD_LOGIC;
         CLK_OUT_AFF : out STD_LOGIC;
         --CLK_OUT_COUNT : out STD_LOGIC;
         
         -- E/S component Comptage
         CE : in std_logic;
         --CLK : in std_logic; Pas necessaire car la CLK de ce module est la CLK de l'entity CLK_DIV
         RESET : in std_logic;
         TC : out std_logic;
         LED_OUT : out std_logic_vector (9 downto 0);
         OUT_DIZ_MIN : out std_logic_vector (3 downto 0);
         OUT_DIZ_SEC : out std_logic_vector (3 downto 0);
         OUT_UNIT_MIN : out std_logic_vector (3 downto 0);
         OUT_UNIT_SEC : out std_logic_vector (3 downto 0)
         );
end top;

architecture Behavioral of top is

-- ********************************************************************
--                          Instantiation des composants 
--*********************************************************************

-- Counter Component : Hadrien et Chris 

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

-- Clock Component : Ramiro et Radu

component CLK_DIV 
    Port ( CLK_IN : in STD_LOGIC; 
    SEL_SPEED_CLK : in STD_LOGIC; 
    CLK_OUT_AFF : out STD_LOGIC; 
    CLK_OUT_COUNT : out STD_LOGIC); 
end component;

-- Affichage Component : Clem et Candice 



-- Signaux internes : 

signal clk_out_count_int : std_logic; 

begin

-- Components Port maps : 

-- *******************************************************
--          Counter Port map : Hadrien et Chris
--
--          Note : On passe par un signal interne pour relier la clock de sortie de clk au counter. 
--                 Pour cela on utilise 'clk_out_count_int' qui est relie au clk et counter, c'est comme une 
--                 variable partagee, clk la modifie et les modifications sont lues par le counter.
-- *******************************************************

 
COUNTER_DIXIEME_MIN_SEC_1 : COUNTER_DIXIEME_MIN_SEC port map ( RESET => RESET, CLK => clk_out_count_int, 
CE => CE, LED_OUT => LED_OUT, OUT_DIZ_MIN => OUT_DIZ_MIN, OUT_DIZ_SEC => OUT_DIZ_SEC, 
OUT_UNIT_MIN => OUT_UNIT_MIN, OUT_UNIT_SEC => OUT_UNIT_SEC, TC => TC); 

-- *******************************************************
--          Clock Port map : Ramiro et Radu
-- *******************************************************

-- Pour ce port map on est straightforward, on relie les E/S de top 
clk_div_1 : CLK_DIV port map (CLK_IN => CLK_IN , 
SEL_SPEED_CLK => SEL_SPEED_CLK, CLK_OUT_COUNT => clk_out_count_int,
CLK_OUT_AFF => CLK_OUT_AFF); 

end Behavioral;
