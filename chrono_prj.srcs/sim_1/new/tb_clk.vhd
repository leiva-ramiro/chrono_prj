library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;

entity tb_clk is
--  Port ( );
end tb_clk;

architecture Behavioral of tb_clk is    

component CLK_DIV is
    Port ( CLK_IN : in STD_LOGIC;
           SEL_SPEED_CLK : in STD_LOGIC;
           CLK_OUT_AFF : out STD_LOGIC;
           CLK_OUT_COUNT : out STD_LOGIC);
end component;

-- `*******************************************
--          Signaux internes pour la simulation :
--**********************************************

-- Signal pour la clock d'entrée
signal CLK_IN_int : std_logic := '0';
-- Signal pour le switch de selection de frequence
signal SEL_SPEED_CLK_int : std_logic := '0';            
-- Signaux de sortie
signal CLK_OUT_AFF_int : std_logic; 
signal CLK_OUT_COUNT_int : std_logic;

-- ****************************************
--         begin architecture
-- ****************************************

begin

-- Instanciation du composant CLK_DIV
U_CLK_DIV : CLK_DIV

Port map(
    CLK_IN => CLK_IN_int,
    SEL_SPEED_CLK => SEL_SPEED_CLK_int,
    CLK_OUT_AFF => CLK_OUT_AFF_int,
    CLK_OUT_COUNT => CLK_OUT_COUNT_int
);
-- Generation de la clock d'entrée 100 MHz
CLK_IN_int <= not CLK_IN_int after 5 ns;

end Behavioral;
