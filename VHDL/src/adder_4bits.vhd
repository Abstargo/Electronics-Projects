

library ieee;
use ieee.std_logic_1164.all;

entity adder_4bits is
    port(
        A, B : in  std_logic_vector(3 downto 0);
        CIN  : in  std_logic;
        SUM  : out std_logic_vector(3 downto 0);
        COUT : out std_logic
    );
end entity adder_4bits;

architecture structural of adder_4bits is

    component full_adder is
        port (A, B, CIN : in std_logic; SUM, COUT : out std_logic);
    end component;

    signal carry : std_logic_vector(4 downto 0);

begin
    carry(0) <= CIN;

    gen: for i in 0 to 3 generate
        fa: full_adder port map (
            A    => A(i),
            B    => B(i),
            CIN  => carry(i),
            SUM  => SUM(i),
            COUT => carry(i+1)
        );
    end generate gen;

    COUT <= carry(4);

end architecture structural;