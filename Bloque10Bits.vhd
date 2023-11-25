library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Bloque10Bits is
    Port ( Entrada : in STD_LOGIC_VECTOR(9 downto 0);
           Salida_0 : out STD_LOGIC;
           Salida_1 : out STD_LOGIC;
           Salida_2 : out STD_LOGIC;
           Salida_3 : out STD_LOGIC;
           Salida_4 : out STD_LOGIC;
           Salida_5 : out STD_LOGIC;
           Salida_6 : out STD_LOGIC;
           Salida_7 : out STD_LOGIC;
           Salida_8 : out STD_LOGIC;
           Salida_9 : out STD_LOGIC);
end Bloque10Bits;

architecture Behavioral of Bloque10Bits is
begin
    Salida_0 <= Entrada(0);
    Salida_1 <= Entrada(1);
    Salida_2 <= Entrada(2);
    Salida_3 <= Entrada(3);
    Salida_4 <= Entrada(4);
    Salida_5 <= Entrada(5);
    Salida_6 <= Entrada(6);
    Salida_7 <= Entrada(7);
    Salida_8 <= Entrada(8);
    Salida_9 <= Entrada(9);
end Behavioral;