-- Demultiplexeur

entity demux_1to8 is
    port (
        E : in bit;                    -- entree de donnée
        S : in bit_vector(2 downto 0); -- sélection (S2 S1 S0)
        Y : out bit_vector(7 downto 0);-- 8 sorties
    );
end entity;

architecture behavioral of demux_1to8 is
    begin
        process (E, S)
        begin
            -- initialisation a 0 (valeur par defaut)
            Y <= (others => '0');
            -- affectation conditionelle
            case S is
                when "000" => Y(0) <= E;
                when "001" => Y(1) <= E;
                when "010" => Y(2) <= E;
                when "011" => Y(3) <= E;
                when "100" => Y(4) <= E;
                when "101" => Y(5) <= E;
                when "110" => Y(6) <= E;
                when "111" => Y(7) <= E;
                when others => null;
            end case;
        end process;
end architecture;
