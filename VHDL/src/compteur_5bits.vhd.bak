

---- COMPTEUR A 5 bits ----

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_numeric_std.all;

entity compteur_5bits is
    port (
        H       : in std_logic;     -- clock
        V       : in std_logic;     -- enable (count when V = 1)
        RESET   : in std_logic;     -- async reset to 0
        Y       : out std_logic_vector(4 downto 0); -- 5 bit count output
        M       : out std_logic
    );
end entity compteur_5bits;


architecture behavioral of compteur_5bits is 

    signal count : unsigned(4 downto 0) := (others => '0');  -- unsigned allows arithmetic like count + 1

    begin
        process (H, RESET) is
            begin
                -- Async reset: priority 1
                if RESET = '1' then
                    count <= (others => '0');

                elsif rising_edge(H) then
                    if V = '1' then

                        if count = 7 then
                            count <= to_unsigned(12, 5);  -- jump to 12 (count = 12) convert 12 to 5 bits
                        
                        elsif count = 19 then
                            count <= to_unsigned(0, 5);   -- jumps to 0 by converting it to 5 bits

                        else
                            count <= count + 1;
                        end if;
                    end if;
                end if;
        end process;
    
        M <= '1' when (count = 7 or count = 19) else M <= '0';

        Y <= std_logic_vector(count);

end architecture behavioral;
