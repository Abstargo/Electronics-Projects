

-- Structural description of the circuit from the diagram

entity circuit is
    port (
        A : in bit;
        B : in bit;
        H : in bit;
        SET : in bit;
        E : out bit;
        W : out bit
    );
end entity circuit;

architecture struct of circuit is
    
    component BD is
        port (
            CLOCK : in bit;
            D : in bit;
            S : in bit;
            Q : out bit;
            P : out bit
        );
    end component;

    component or2 is
        port (
            I1 : in bit;
            I2 : in bit;
            Y : out bit
        );
    end component;

-- Internal Signals (the wires connecting components inside the circuit)

        signal Q1   : bit;  -- Q outout of FF1
        signal P1   : bit;  -- P output of FF2
        signal D2   : bit;  -- OR gate output
        signal P2   : bit;  -- P output of FF2
        signal Q2   : bit;  -- Q output of FF2

    begin
        -- First D flip flop

        FF1 : component BD
            port map (
                CLOCK => H,
                D     => A,
                S     => SET,
                Q     => Q1,
                P     => P1
            );
