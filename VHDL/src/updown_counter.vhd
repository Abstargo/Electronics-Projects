

---- COMPTEUR/DECOMPTEUR ----

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity updown_compteur is
    generic (
        N1 : integer := 3;   -- default 3
        N2 : integer := 10;  -- default 10
    );

    port (
        CLK : in std_logic;
        Y   : out std_logic_vector(5 downto 0)
    );
end entity updown_compteur;

architecture behavioral of updown_counter is
    signal count : unsigned(5 downto 0) := to_unsigned(N1, 6);

    signal going_up : std_logic := '1'; -- '1' means counting up

    begin
    process (CLK) is
    begin
        if rising_edge(CLK) then

            if going_up = '1' then
                -- Counting UP
                if count = N2 then
                    going_up <= '0';         -- reached top, now go down
                    count    <= count - 1;
                else
                    count <= count + 1;
                end if;

            else
                -- Counting DOWN
                if count = N1 then
                    going_up <= '1';         -- reached bottom, now go up
                    count    <= count + 1;
                else
                    count <= count - 1;
                end if;
            end if;

        end if;
    end process;

    Y <= std_logic_vector(count);

end architecture behavioral;