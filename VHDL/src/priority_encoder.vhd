library ieee;
use ieee.std_logic_1164.all;

entity priority_encoder is
    port (
        A : in  std_logic_vector(7 downto 0);
        B : out std_logic_vector(3 downto 0)  -- B(3)=V, B(2..0)=Y
    );
end entity;

architecture behavioral of priority_encoder is
    signal V : std_logic;
    signal Y : std_logic_vector(2 downto 0);
begin
    process (A)
    begin
        -- Default values (no input active)
        V <= '0';
        Y <= "000";

        -- elsif highest bit WINS and lower bits are ignored
        if A(7) = '1' then
            V <= '1'; Y <= "111";
        elsif A(6) = '1' then
            V <= '1'; Y <= "110";
        elsif A(5) = '1' then
            V <= '1'; Y <= "101";
        elsif A(4) = '1' then
            V <= '1'; Y <= "100";
        elsif A(3) = '1' then
            V <= '1'; Y <= "011";
        elsif A(2) = '1' then
            V <= '1'; Y <= "010";
        elsif A(1) = '1' then
            V <= '1'; Y <= "001";
        elsif A(0) = '1' then
            V <= '1'; Y <= "000";
        -- if nothing: V and Y stay at default 0
        end if;
    end process;

    B <= V & Y;
end architecture behavioral;