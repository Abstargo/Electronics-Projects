library ieee;
use ieee.std_logic_1164.all;

entity full_adder_tb is
end entity full_adder_tb;

architecture sim of full_adder_tb is        -- ✅ Fix 1: adder not ladder

    component full_adder is
        port (
            a    : in  std_logic;
            b    : in  std_logic;
            cin  : in  std_logic;
            sum  : out std_logic;
            cout : out std_logic            -- ✅ Fix 2: no semicolon here
        );
    end component;

    signal a_tb   : std_logic := '0';
    signal b_tb   : std_logic := '0';
    signal cin_tb : std_logic := '0';
    signal sum_tb : std_logic;
    signal cout_tb: std_logic;

begin

    UUT : component full_adder
        port map (
            a    => a_tb,
            b    => b_tb,
            cin  => cin_tb,
            sum  => sum_tb,
            cout => cout_tb
        );

    stimulus : process is
    begin
        a_tb <= '0'; b_tb <= '0'; cin_tb <= '0'; wait for 20 ns;
        a_tb <= '0'; b_tb <= '0'; cin_tb <= '1'; wait for 20 ns;
        a_tb <= '0'; b_tb <= '1'; cin_tb <= '0'; wait for 20 ns;
        a_tb <= '0'; b_tb <= '1'; cin_tb <= '1'; wait for 20 ns;
        a_tb <= '1'; b_tb <= '0'; cin_tb <= '0'; wait for 20 ns;
        a_tb <= '1'; b_tb <= '0'; cin_tb <= '1'; wait for 20 ns;
        a_tb <= '1'; b_tb <= '1'; cin_tb <= '0'; wait for 20 ns;
        a_tb <= '1'; b_tb <= '1'; cin_tb <= '1'; wait for 20 ns;
        wait;
    end process stimulus;

end architecture sim;