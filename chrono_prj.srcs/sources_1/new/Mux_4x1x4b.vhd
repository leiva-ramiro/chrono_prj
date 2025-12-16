-- ENTITE : Affichage
-- SOUS-ENTITE : Mux_4x1x4b
-- Cette sous-entite Mux_4x1x4b est un multiplexeur permettant de 
-- selectionner la donnee a afficher sur l'anode correspondante.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux_4x1x4b is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           C : in STD_LOGIC_VECTOR (3 downto 0);
           D : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           O : out STD_LOGIC_VECTOR (3 downto 0));
end Mux_4x1x4b;


architecture Behavioral of Mux_4x1x4b is
begin
    with sel select
        O <= A when "00", -- Affiche les unites de secondes
             B when "01", -- Affiche les dizaines de secondes
             C when "10", -- Affiche les unites de minutes
             D when "11", -- Affiche les dizaines de minutes
             "0000" when others; -- Securite qui couvre les etats indefinis)
end Behavioral;