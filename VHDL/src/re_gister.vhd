----- REGISTER -----
library ieee;
use ieee.std_logic_1164.all;

entity re_gister is
    generic (            -- generic is like a paramater lets you reuse the same code for any bit width.
        N : integer := 4 -- default 4 bits, can be changed
    );
    port (
        CLK   : in std_logic;
        R     : in std_logic;     -- async reset (priority 1)
        S     : in std_logic;     -- async set (priority 2)
        LOAD  : in std_logic;     -- sync load (priority 3)
        D     : in std_logic_vector(N-1 downto 0); -- data input
        Y     : out std_logic_vector(N-1 downto 0));  -- register output
end entity re_gister;
architecture behavioral of re_gister is
        signal Y_int : std_logic_vector(N-1 downto 0) := (others => '0');
        begin
            process (CLK, R, S) is
                begin
                    -- Priority 1: Reset async
                    if R = '1' then
                        Y_int <= (others => '0'); -- all bits become 0
                    
                        -- Priority 2 : Set async
                        elsif S = '1' then
                        Y_int <= (others => '1'); -- all bits become 1
                        
                        -- Priority 3 : Sync LOAD
                        elsif rising_edge(CLK) then
                            if LOAD = '1' then
                                Y_int <= D; -- LOAD D into register
                            end if;
                            -- LOAD = 0 register holds its value; nothing happens
                    end if;
            end process;
            Y <= Y_int;
end architecture behavioral;