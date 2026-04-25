library ieee;
use ieee.std_logic_1164.all;

entity EXSA_s1 is
port(
    i : in std_logic;
    s : in std_logic_vector(2 downto 0);
    d : out std_logic_vector(7 downto 0));
end EXSA_s1;

architecture arch_demux10 of EXSA_s1 is
begin

process(i, s)
begin
    d <= x"00"; -- initialization du vecteur de sortie

case s is
    when o"0" => d(0) <= i;
    when o"1" => d(1) <= i;
    when o"2" => d(2) <= i;
    when o"3" => d(3) <= i;
    when o"4" => d(4) <= i;
    when o"5" => d(5) <= i;
    when o"6" => d(6) <= i;
    when o"7" => d(7) <= i;
    when others => d <= x"00";
end case;
end process;
end architecture arch_demux10;