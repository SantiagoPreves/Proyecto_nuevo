library ieee;
use ieee.std_logic_1164.all;

entity Clock1Hz is
    Port (
        reloj : in std_logic;
        clock : out std_logic );
end Clock1Hz;

architecture behavioral of Clock1Hz is
    constant target_frequency : real := 2.0; -- Frecuencia objetivo en Hz
    constant divisor : integer := integer(50.0e6 / target_frequency); -- Divisor para reducir la frecuencia
    
    signal counter : integer range 0 to divisor - 1 := 0;
    signal x : std_logic := '0';   
begin
    process (reloj)
    begin
        if rising_edge(reloj) then
            if counter = divisor - 1 then
                x <= not x;
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    clock <= x;
end architecture behavioral;