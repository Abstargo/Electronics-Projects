Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
-- Définition d'entité
ENTITY add1 IS
PORT(A,B,Cin: IN std_logic;
    Cout,S:OUT std_logic);
END ENTITY;

-- Description structurelle
ARCHITECTURE structurEL OF add1 IS
BEGIN
    Cout<= (A and B) or (Cin and (A xor B));
    S <= Cin xor (A xor B);
END structurEL;