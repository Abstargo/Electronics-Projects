Library ieee ;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY add4 IS
PORT (a,b: IN unsigned(3 downto 0);
    s: OUT unsigned(3 downto 0);
    r: OUT std_logic );
END ENTITY;

ARCHITECTURE arch_add4 OF add4 IS
-- declaration du composant add1
COMPONENT add1 IS
PORT (A,B,Cin: IN std_logic;
    COUT,S: OUT std_logic);
END COMPONENT add1;

signal c : unsigned (2 downto 0) ;

BEGIN
inst_add10 : add1 PORT MAP (
    a(0),b(0),'0',c(0),s(0));
inst_add11 : add1 PORT MAP (
    a(1),b(1),c(0),c(1),s(1));
inst_add12 : add1 PORT MAP (
    a(2),b(2),c(1),c(2),s(2));
inst_add13 : add1 PORT MAP (
    a(3),b(3),c(2),r,s(3));
end arch_add4;