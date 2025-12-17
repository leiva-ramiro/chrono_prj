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
         --CLK_OUT_AFF : out STD_LOGIC;
         --CLK_OUT_COUNT : out STD_LOGIC;
         
         -- E/S component Comptage
         CE : in std_logic;
         --CLK : in std_logic; Pas necessaire car la CLK de ce module est la CLK de l'entity CLK_DIV
         RESET : in std_logic;
         TC : out std_logic;
         LED_OUT : out std_logic_vector (9 downto 0);
         --OUT_DIZ_MIN : out std_logic_vector (3 downto 0);
         --OUT_DIZ_SEC : out std_logic_vector (3 downto 0);
         --OUT_UNIT_MIN : out std_logic_vector (3 downto 0);
         --OUT_UNIT_SEC : out std_logic_vector (3 downto 0);
         
                  
        -- E/S component Affichage
        -- E/S component Affichage
        -- CLK          : in  STD_LOGIC;
        --RESET        : in  STD_LOGIC;
        -- OUT_UNIT_SEC : in  STD_LOGIC_VECTOR(3 downto 0);
        -- OUT_DIZ_SEC  : in  STD_LOGIC_VECTOR(3 downto 0);
        -- OUT_UNIT_MIN : in  STD_LOGIC_VECTOR(3 downto 0);
        -- OUT_DIZ_MIN  : in  STD_LOGIC_VECTOR(3 downto 0);
        ANODES       : out STD_LOGIC_VECTOR(3 downto 0); -- Sortie de U8
        AFF          : out STD_LOGIC_VECTOR(6 downto 0)  -- Sortie de U7
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
component  Affichage
    Port ( 
        CLK          : in  STD_LOGIC;
        RESET        : in  STD_LOGIC;
        OUT_UNIT_SEC : in  STD_LOGIC_VECTOR(3 downto 0);
        OUT_DIZ_SEC  : in  STD_LOGIC_VECTOR(3 downto 0);
        OUT_UNIT_MIN : in  STD_LOGIC_VECTOR(3 downto 0);
        OUT_DIZ_MIN  : in  STD_LOGIC_VECTOR(3 downto 0);
        ANODES       : out STD_LOGIC_VECTOR(3 downto 0); -- Sortie de U8
        AFF          : out STD_LOGIC_VECTOR(6 downto 0));  -- Sortie de U7
end component;


-- Signaux internes : 

signal clk_out_count_int : std_logic; 

signal sel_anode : STD_LOGIC_VECTOR(1 downto 0);
signal mux_out   : STD_LOGIC_VECTOR(3 downto 0);

-- Signaux pour le temps venant de U10
signal s_unit_sec : STD_LOGIC_VECTOR(3 downto 0);
signal s_diz_sec  : STD_LOGIC_VECTOR(3 downto 0);
signal s_unit_min : STD_LOGIC_VECTOR(3 downto 0);
signal s_diz_min  : STD_LOGIC_VECTOR(3 downto 0);

-- Signal d'horloge venant de U11
signal clk_out_aff_int : std_logic := '0'; -- on initialise
begin

-- Components Port maps : 

-- *******************************************************
--          Counter Port map : Clem Candice

Affichage_1 : Affichage
    port map (
        CLK          => clk_out_aff_int, -- Connecté à la sortie CLK_OUT_AFF de U11
        RESET        => RESET,           -- RESET global du système
        OUT_UNIT_SEC => s_unit_sec,      -- Reçoit l'unité des secondes de U10
        OUT_DIZ_SEC  => s_diz_sec,       -- Reçoit la dizaine des secondes de U10
        OUT_UNIT_MIN => s_unit_min,      -- Reçoit l'unité des minutes de U10
        OUT_DIZ_MIN  => s_diz_min,       -- Reçoit la dizaine des minutes de U10
        ANODES       => ANODES,          -- Sortie physique vers la carte
        AFF          => AFF              -- Sortie physique vers la carte
    );

-- *******************************************************
--          Counter Port map : Hadrien et Chris
--
--          Note : On passe par un signal interne pour relier la clock de sortie de clk au counter. 
--                 Pour cela on utilise 'clk_out_count_int' qui est relie au clk et counter, c'est comme une 
--                 variable partagee, clk la modifie et les modifications sont lues par le counter.
-- *******************************************************

 
COUNTER_DIXIEME_MIN_SEC_1 : COUNTER_DIXIEME_MIN_SEC port map ( 
                                RESET => RESET, CLK => clk_out_count_int, 
                                CE => CE, 
                                LED_OUT => LED_OUT, 
                                OUT_DIZ_MIN => s_diz_min, 
                                OUT_DIZ_SEC => s_diz_sec, 
                                OUT_UNIT_MIN => s_unit_min, 
                                OUT_UNIT_SEC => s_unit_sec, 
                                TC => TC); 

-- *******************************************************
--          Clock Port map : Ramiro et Radu
-- *******************************************************

-- Pour ce port map on est straightforward, on relie les E/S de top 
clk_div_1 : CLK_DIV port map(
    CLK_IN => CLK_IN , 
    SEL_SPEED_CLK => SEL_SPEED_CLK, 
    CLK_OUT_COUNT => clk_out_count_int,
    CLK_OUT_AFF   => clk_out_aff_int); 
    


--rappel : <= (Affectation) : Sert à donner une valeur à un signal
-- = > (Association) : Sert à faire des branchements
end Behavioral;
