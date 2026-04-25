Library leee;
Use leee.std_logic_1164.all;
Use leee.numeric_std.all;

ENTITY MUX IS
PORT (AO, AI: IN unsigned(3 downto 0);
    B : IN unsigned(7 downto 0);
    s : IN std_logic;
    Y : OUT unsigned(7 downto 0));

END ENTITY;

ARCHITECTURE arc OF MUX IS
SIGNAL X0 : unsigned(7 downto 0);

BEGIN

X0 <= AI&AO;

Y <= X0 WHEN s='0' ELSE B WHEN s='1' ELSE "XXXXXXX";

END arc;