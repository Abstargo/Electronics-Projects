
-- D flip flop

library ieee;
use ieee.std_logic_1164.all;

entity BD is
    port (
        CLOCK : in std_logic;
        D   : in std_logic;
        S   : in std_logic;
        Q   : out std_logic;
        P   : out std_logic
    );
end entity BD;

architecture behavioral of BD is

    signal TMP : std_logic := '0';

begin
    process (CLOCK, S) is
        begin
            if S = '1' then
                TMP <= '1';
            elsif rising_edge(CLOCK) then
                TMP <= D;
            end if;
    end process;
    
    Q <= TMP;
    P <= not TMP;

end architecture behavioral;