----------------------------------------------------------------------------------
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
         CLK_OUT_AFF : out STD_LOGIC;
         --CLK_OUT_COUNT : out STD_LOGIC; Gere en interne dans le top 
         
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
 end component; 


-- *************************************************
--          Signaux internes pour la simulation :
--**************************************************

-- Sorties 
signal LED_OUT_int : std_logic_vector (9 downto 0);
signal OUT_DIZ_MIN_int, OUT_DIZ_SEC_int, OUT_UNIT_MIN_int, OUT_UNIT_SEC_int :  std_logic_vector (3 downto 0);
signal TC_int : std_logic ;

-- INPUTS

-- Counter
signal RESET_int, CE_int : std_logic := '0';
-- CLK_DIV
signal sel_speed_int : STD_LOGIC :='0'; signal clk_out_aff_s : std_logic; signal clk_int,clk_out_count_s : std_logic :='0'; 


-- **********************************************
--                  begin 
-- **********************************************

begin

 -- Top Instantiation 

chronometre : top port map (CLK_IN => clk_int, SEL_SPEED_CLK => sel_speed_int, CLK_OUT_AFF => clk_out_aff_s, CE => CE_int, RESET => RESET_int, 
                  TC => TC_int, LED_OUT => LED_OUT_int, OUT_DIZ_MIN => OUT_DIZ_MIN_int, OUT_DIZ_SEC => OUT_DIZ_SEC_int, OUT_UNIT_MIN => OUT_UNIT_MIN_int,
                  OUT_UNIT_SEC => OUT_UNIT_SEC_int);

-- *************************************
--          Generated Stimulus 
-- *************************************

-- CLK_DIV stimulus
sel_speed_int <= '0'; 
clk_int <= not clk_int after 5 ns; -- 50ms

-- Counter stimulus 
CE_int <= '1';
RESET_int <= '0'; 

end Behavioral;
