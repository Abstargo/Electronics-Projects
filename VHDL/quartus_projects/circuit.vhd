
library ieee;
use ieee.std_logic_1164.all;


entity circuit is
    port (
        A, B : in std_logic;
        H    : in std_logic;
        SET  : in std_logic;
        E    : out std_logic;
        W    : out std_logic
    );
end entity circuit;

architecture behavioral of circuit is

    component BD is
        port (
            CLOCK : in std_logic;
            D     : in std_logic;
            S     : in std_logic;
            Q     : out std_logic;
            P     : out std_logic
        );
    end component;

    component Or2 is
        port (
            I1, I2 : in std_logic;
            Y   : out std_logic
        );
    end component;


    signal Q1  : std_logic; -- To the Or gate
    signal P1  : std_logic; -- unused but must be declared
    signal D2  : std_logic; -- D2 is the wire that is from Or gate to the second D
    signal Q2  : std_logic; -- Q2 output of FF2
    signal P2  : std_logic; -- unused 

    FF1 : component BD
        port map (
            CLOCK => H,
            D => A,
            S => SET,
            Q => Q1,
            P => P1
        );
    
    GATE : component or2
        port map (
            I1 => Q1,
            I2 => B,
            Y =>  D2
        );
    
    FF2 : component BD
        port map
        (
            CLOCK => H,
            D     => D2,
            S     => SET,
            Q     => Q2,
            P     => P2
        );

    E <= Q2;
    W <= Q2;

end architecture behavioral;