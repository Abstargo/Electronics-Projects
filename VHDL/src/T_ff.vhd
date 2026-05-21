
---- T flip flop ----

library ieee;
use ieee.std_logic_1164.all;

entity T_ff is 
	port(
			T : in std_logic;
			Clk : in std_logic;
			r   : in std_logic;
			s   : in std_logic;
			q	: out std_logic;
			qb : out std_logic
	
	);
end entity T_ff;

architecture behavioral of T_ff is

		signal tmp : std_logic := '0';
		
		begin
			process(clk, r, s) is
				begin 
				
					if r = '1' then
						tmp <= '0';
					elsif s = '1' then
					    tmp <= '1';
						 
					elsif rising_edge(clk) then
							if T = '1' then
								tmp <= not tmp;
							end if;
					end if;
			end process;
		
			q <= tmp;
			qb <= not tmp;
			
end architecture behavioral;