library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Affichage is
    Port (
        CLK          : in  STD_LOGIC;
        RESET        : in  STD_LOGIC;
        OUT_UNIT_SEC : in  STD_LOGIC_VECTOR(3 downto 0);
        OUT_DIZ_SEC  : in  STD_LOGIC_VECTOR(3 downto 0);
        OUT_UNIT_MIN : in  STD_LOGIC_VECTOR(3 downto 0);
        OUT_DIZ_MIN  : in  STD_LOGIC_VECTOR(3 downto 0);
        ANODES       : out STD_LOGIC_VECTOR(3 downto 0); -- Sortie de U8
        AFF          : out STD_LOGIC_VECTOR(6 downto 0)  -- Sortie de U7
    );
end Affichage;



architecture Behavioral of Affichage is
    -- Signaux "fils" internes
    signal sel_anode : STD_LOGIC_VECTOR(1 downto 0);
    signal mux_out   : STD_LOGIC_VECTOR(3 downto 0);

    -- Déclarations des composants :
    component Counter_2b is
        Port ( RESET, CLK : in STD_LOGIC; 
               OUTPUT : out STD_LOGIC_VECTOR(1 downto 0) );
    end component;

    component Transcodeur_anodes is
        Port ( sel_anode : in STD_LOGIC_VECTOR(1 downto 0); 
               vect_anode : out STD_LOGIC_VECTOR(3 downto 0) );
    end component;

    component Mux_4x1x4b is
        Port ( A, B, C, D : in STD_LOGIC_VECTOR(3 downto 0); 
               sel : in STD_LOGIC_VECTOR(1 downto 0);
               O : out STD_LOGIC_VECTOR(3 downto 0) );
    end component;

    component Transcodeur_7seg is
        Port ( entree : in STD_LOGIC_VECTOR(3 downto 0); 
               sortie : out STD_LOGIC_VECTOR(6 downto 0));
    end component;

begin

    -- U5 : Compteur
    U5 : Counter_2b
        port map (
            RESET  => RESET,
            CLK    => CLK,
            OUTPUT => sel_anode
        );

    -- U8 : Transcodeur Anodes 
    U8 : Transcodeur_anodes
        port map (
            sel_anode  => sel_anode,
            vect_anode => ANODES
        );

    -- U6 : Multiplexeur 
    U6 : Mux_4x1x4b
        port map (
            A   => OUT_UNIT_SEC,
            B   => OUT_DIZ_SEC,
            C   => OUT_UNIT_MIN,
            D   => OUT_DIZ_MIN,
            sel => sel_anode,
            O   => mux_out
        );

    -- U7 : Transcodeur 7 segments (Sortie vers AFF)
    U7 : Transcodeur_7seg
        port map (
            entree => mux_out,
            sortie => AFF
        );

end Behavioral;
