library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Ici je déclare tous mes entrées sorties de Compteur_2b et Transcodeur anodes
entity Counter_2b is
    Port ( RESET : in STD_LOGIC; -- sert à réinitialiser ton compteur immédiatement, peu importe l'horloge
           CLK : in STD_LOGIC;  -- c'est l'horloge, sert à aux circuits séquentiels de se mettre à jour
           OUTPUT : out STD_LOGIC_VECTOR(1 downto 0)); -- J'utilise STD_LOGIC_VECTOR car quand on plusieurs bit on utilise ça 
end Counter_2b;

architecture Behavioral of Counter_2b is 
signal OUTPUT_INT : unsigned (1 downto 0) := (others => '0'); 
begin
-- Je déclare une variable interne OUTPUT_INT pour faire des opérations mathématiques plus facilement
-- ici unsigned 1 downto 0 permet de "convertir en un nombre décimal" (en réalité le nombre binaire 
-- n'est pas convertit en décimal il reste binaire mais pour VHDL il le voit comme un entier positif)
-- puis il initialise OUTPUT_int 



process(CLK, RESET)-- Ce bloc s'active quand il y a une horloge ou un reset
    begin
        if RESET = '1' then -- Si on appuie sur le reset, le compteur revient à 0, tout de suite
            OUTPUT_INT <= (others => '0');
        elsif rising_edge(CLK) then
            OUTPUT_INT <= OUTPUT_INT + 1;--on ajoute 1 au compteur
        end if;
    end process;

    OUTPUT <= std_logic_vector(OUTPUT_INT); -- On envoie la valeur du compteur vers la sortie Q
                                            -- et On convertit juste le type pour être compatible
end Behavioral;