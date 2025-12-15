----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2025 08:47:31
-- Design Name: 
-- Module Name: comb_seq - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comb_seq is
    Port ( input1 : in STD_LOGIC;
           input2 : in STD_LOGIC;
           out_and : out STD_LOGIC;
           out_latch : out STD_LOGIC);
end comb_seq;

architecture Behavioral of comb_seq is

begin

and_process : process(input1,input2)
begin
    if input1 = '1' then 
        out_and <= input2; 
    else
        out_and <= '0'; 
    end if;
end process and_process;

latch_process : process(input1,input2)
begin 

    --out_latch <= '0'; 
    if input1 = '1' then 
        out_latch <= input2; 
    end if; 

end process latch_process; 

end Behavioral;
