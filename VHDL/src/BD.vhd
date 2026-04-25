

--- VHDL BASCULE D EXERCICE 2 Serie 2 ---

entity BD is
    port (
        CLOCK : in bit;
        D   : in bit;
        S   : in bit;
        Q   : in bit;
        P   : in bit
    );
end entity BD;

architecture behavioral of BD is
    signal Q_int : bit := '0';

    begin
        process (CLOCK, S) is
            begin
                if S = '1' then
                    Q_int <= '1';
                elsif rising_edge(CLOCK) then
                    Q_int <= D;
                end if;
        end process;

        Q <= Q_int;
        P <= not Q_int;
end architecture behavioral;

                