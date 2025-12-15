----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2025 11:41:14
-- Design Name: 
-- Module Name: Counter_dixieme_min_sec - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter_dixieme_min_sec is
  Port ( CE : in std_logic;
         CLK : in std_logic;
         RESET : in std_logic;
         TC : out std_logic;
         LED_OUT : out std_logic_vector (9 downto 0);
         OUT_DIZ_MIN : out std_logic_vector (3 downto 0);
         OUT_DIZ_SEC : out std_logic_vector (3 downto 0);
         OUT_UNIT_MIN : out std_logic_vector (3 downto 0);
         OUT_UNIT_SEC : out std_logic_vector (3 downto 0)
         );
end Counter_dixieme_min_sec;

architecture Behavioral of Counter_dixieme_min_sec is

Component Counter_dixieme_RE is
    port ( CE : in std_logic;
         CLK : in std_logic;
         RESET : in std_logic;
         LED_OUT : out std_logic_vector (9 downto 0); 
         TC : out std_logic);
end component;

Component Counter_Unit_4b_RE is
    port ( CLK : in std_logic;
           RESET : in std_logic;
           OUTPUT : out std_logic_vector (3 downto 0); 
           TC : out std_logic );
end component;

Component Counter_Diz_4b_RE is
    port ( CLK : in std_logic;
           RESET : in std_logic;
           OUTPUT : out std_logic_vector (3 downto 0); 
           TC : out std_logic );
end component;

signal TC1, TC2, TC3, TC4 : std_logic;

begin

U4 : Counter_dixieme_RE port map ( CE => CE, CLK => CLK, RESET => RESET, LED_OUT => LED_OUT, TC => TC1 );
U0 : Counter_Unit_4b_RE port map ( CLK => TC1, RESET => RESET, OUTPUT => OUT_UNIT_SEC, TC => TC2 );
U1 : Counter_Diz_4b_RE port map ( CLK => TC2, RESET => RESET, OUTPUT => OUT_DIZ_SEC, TC => TC3 );
U2 : Counter_Unit_4b_RE port map ( CLK => TC3, RESET => RESET, OUTPUT => OUT_UNIT_MIN, TC => TC4 );
U3 : Counter_Diz_4b_RE port map ( CLK => TC4, RESET => RESET, OUTPUT => OUT_DIZ_MIN, TC => TC );

end Behavioral;
