-- CODE VHDL TD 1 EX 2

entity adder_4bits is
    port(
        A, B: in bit_vector(3 downto 0);
        CIN: in bit;
        SUM: out bit_vector(3 downto 0);
        COUT : out bit
    );
end entity;

architecture structural of adder_4bits is
    component full_adder
        port (A, B, CIN : in bit; SUM, COUT : out bit);
    end component;
    signal carry : bit_vector(4 downto 0); -- carry(0)=CIN, carry(4)=COUT

    begin
        carry(0) <= CIN;
        gen: for i in 0 to 3 generate
        fa: full_adder port map (
            A => A(i),
            B => B(i),
            CIN => carry(i),
            SUM => SUM(i),
            COUT => carry(i+1)
        );
        end generate;
        COUT <= carry(4);
end architecture;
