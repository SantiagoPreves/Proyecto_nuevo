library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity denom is
    Port ( x : in STD_LOGIC;
           output_vector : out STD_LOGIC_VECTOR(2 downto 0));
end denom;

architecture Behavioral of denom is
begin
    process(x)
    begin
        if x = '0' then
            output_vector <= "100";
        elsif x = '1' then
            output_vector <= "001";
        else
            output_vector <= "000"; -- Manejo del caso cuando x no es ni '0' ni '1'
        end if;
    end process;
end Behavioral;