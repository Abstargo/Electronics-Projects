

-- JK BASCULE POUR TD --

library ieee;
use ieee.std_logic_1164.all;

entity jk_ff is 
    port (
        j, k : in std_logic;
        clk : in std_logic;
        r : in std_logic;
        s : in std_logic;
        q : out std_logic;
        p : out std_logic; -- inverse output p = not q
    );
end entity jk_ff;

architecture behavioral of jk_ff is
    signal q_int : std_logic := '0'; -- in VHDL you cannot read the output port so we put a signal that assigned to it to q and p

    begin 
        process (clk, r, s) is
            begin
                -- r has the priority first
                if r = '1' then
                    q_int <= '0';
                elsif s = '1' then
                    q_int <= '1';
                elsif rising_edge(clk) then
                    if j = '0' and k = '0' then
                        null; -- q stays the same : do nothing
                
                    elsif j = '0' and k = '1' then
                        q_int <= '0';   -- q = 0
                    elsif j = '1' and k = '0' then
                        q_int <= '1';   -- q = 1
                    else
                        q_int <= not q_int; -- toggle q flips (j=1 k=1)
                    end if;
                end if;
        end process;

        q <= q_int;
        p <= not q_int;

end architecture behavioral;