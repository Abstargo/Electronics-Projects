library ieee;
use ieee.std_logic_1164.all;

entity adder_4bits_tb is
end entity adder_4bits_tb;

architecture sim of adder_4bits_tb is

    component adder_4bits is
        port(
            A, B : in  std_logic_vector(3 downto 0);
            CIN  : in  std_logic;
            SUM  : out std_logic_vector(3 downto 0);
            COUT : out std_logic
        );
    end component;

    signal A_tb    : std_logic_vector(3 downto 0) := "0000";
    signal B_tb    : std_logic_vector(3 downto 0) := "0000";
    signal CIN_tb  : std_logic := '0';
    signal SUM_tb  : std_logic_vector(3 downto 0);
    signal COUT_tb : std_logic;

begin

    UUT : component adder_4bits
        port map (
            A    => A_tb,
            B    => B_tb,
            CIN  => CIN_tb,
            SUM  => SUM_tb,
            COUT => COUT_tb
        );

    stimulus : process is
    begin
        -- Test 1: 0+0+0=0
        A_tb <= "0000"; B_tb <= "0000"; CIN_tb <= '0'; wait for 20 ns;
        -- Test 2: 1+1+0=2
        A_tb <= "0001"; B_tb <= "0001"; CIN_tb <= '0'; wait for 20 ns;
        -- Test 3: 5+3+0=8
        A_tb <= "0101"; B_tb <= "0011"; CIN_tb <= '0'; wait for 20 ns;
        -- Test 4: 9+6+1=16 → COUT=1
        A_tb <= "1001"; B_tb <= "0110"; CIN_tb <= '1'; wait for 20 ns;
        -- Test 5: 15+1+0=16 → COUT=1
        A_tb <= "1111"; B_tb <= "0001"; CIN_tb <= '0'; wait for 20 ns;
        -- Test 6: 7+8+0=15
        A_tb <= "0111"; B_tb <= "1000"; CIN_tb <= '0'; wait for 20 ns;
        -- Test 7: 15+15+1=31 → COUT=1
        A_tb <= "1111"; B_tb <= "1111"; CIN_tb <= '1'; wait for 20 ns;
        -- Test 8: 10+5+0=15
        A_tb <= "1010"; B_tb <= "0101"; CIN_tb <= '0'; wait for 20 ns;

        wait;
    end process stimulus;

end architecture sim;