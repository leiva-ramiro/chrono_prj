
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Transcodeur_anodes is
    Port (sel_anode : in STD_LOGIC_VECTOR (1 downto 0);
          vect_anode : out STD_LOGIC_VECTOR (3 downto 0));
end Transcodeur_anodes;

architecture Behavioral of Transcodeur_anodes is
begin
    process(sel_anode)
    begin
        case sel_anode is 
            when "00" => vect_anode <= "1110" ; -- AN0
            when "01" => vect_anode <= "1101" ; --AN1
            when "10" => vect_anode <= "1011" ; -- AN2
            when "11" => vect_anode <= "0111" ; -- AN3
            when others => vect_anode <= (others => 'X');
    end case;
 end process;
end Behavioral;
