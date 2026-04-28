

library ieee;
use ieee.std_logic_1164.all;

entity jk_ff is

	port (
			j, k : in std_logic;
			clk  : in std_logic;
			r , s : in std_logic;
			q, p : out std_logic
	);
end entity jk_ff;
	
architecture behavioral of jk_ff is

		signal TMP : std_logic := '0';
		
begin

			process (clk, r, s) is

				begin

					if r = '1' then
						TMP <= '0';
					elsif s = '1' then
						TMP <= '1';
						
					elsif rising_edge(clk) then
						if j = '0' and k = '0' then
							null; -- HOLD NO CHANGE
						elsif j = '0' and k = '1' then
							TMP <= '0';  -- RESET
						elsif j = '1' and k = '1' then
							TMP <= not TMP;
						else
							TMP <= '1';
						end if;
					end if;
			end process;
			
			q <= TMP;
			p <= not TMP;
			
end architecture behavioral;
						