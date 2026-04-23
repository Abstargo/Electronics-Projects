
-- Multiplexeur Projet --

library ieee;
use ieee.std_logic_1164.all;

entity mux4to1 is
    port (
        I0, I1, I2, I3 : in  std_logic;   -- 4 data inputs
        S               : in  std_logic_vector(1 downto 0);  -- 2-bit selector
        Y               : out std_logic    -- 1 output
    );
end entity mux4to1;


architecture behavioral of mux4to1 is
begin

    process (I0, I1, I2, I3, S) is
        begin

        case S is
            when "00" =>
                Y <= I0;        -- S=00: output follows I0
            when "01" =>
                Y <= I1;        -- S=01: output follows I1

            when "10" =>
                Y <= I2;        -- S=10: output follows I2

            when "11" =>
                Y <= I3;        -- S=11: output follows I3
            when others =>
                Y <= '0';       -- safety default (handles X, Z, etc.)
        end case;

    end process;

end architecture behavioral;