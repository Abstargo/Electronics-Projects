library ieee ;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
entity MUX is
    port (A0, A1 : in unsigned(3 downto 0);
    B: in unsigned(7 downto 0);
    S: in std_logic;
    Y: out unsigned(7 downto 0)
    );
end entity;

architecture arc of MUX is
    signal X0 : unsigned(7 downto 0);
begin
    X0 <= A1 & A0;
    Y <= X0 when S="0" else B;
end arc;