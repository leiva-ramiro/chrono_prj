library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_dixieme_RE is
    Port ( CE : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CLK : in STD_LOGIC;
           LED_OUT : out STD_LOGIC_VECTOR (9 downto 0);
           TC : out STD_LOGIC);
end Counter_dixieme_RE;

architecture Behavioral of Counter_dixieme_RE is
    signal LED_OUT1 : unsigned (9 downto 0) := (others => '0');
    signal TC1 : STD_LOGIC := '0';
begin

    process (CLK, RESET)
    begin
        if RESET = '1' then
            -- Reset asynchrone
            LED_OUT1 <= (others => '0');
            TC1 <= '0';
            
        elsif rising_edge(CLK) then
            -- Comportement synchrone sur front montant
            if CE = '1' then
                TC1 <= '0';  -- Par défaut, TC à 0
                if LED_OUT1 = "0000000000" then
                    LED_OUT1 <= LED_OUT1 + 1;
                elsif LED_OUT1 = "1000000000" then
                    -- Retour à 0 et génération du Terminal Count
                    LED_OUT1 <= (others => '0');
                    TC1 <= '1';
                else
                    -- Incrémentation normale
                    LED_OUT1 <= LED_OUT1 + LED_OUT1;
                end if;
            end if;
        end if;
    end process;

    -- Affectation des sorties
    LED_OUT <= std_logic_vector(LED_OUT1);
    TC <= TC1;
    
end Behavioral;