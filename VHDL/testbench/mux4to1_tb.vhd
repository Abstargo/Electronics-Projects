

-- TESTBENCH MUX --


library ieee;
use ieee.std_logic_1164.all;

entity mux4to1_tb is
    -- empty: testbenches never have ports
end entity mux4to1_tb;

architecture sim of mux4to1_tb is

    -- Declare the component to test
    component mux4to1 is
        port (
            I0, I1, I2, I3 : in  std_logic;
            S               : in  std_logic_vector(1 downto 0);
            Y               : out std_logic
        );
    end component;

    -- Internal signals (wires to plug into the MUX)
    signal I0_tb, I1_tb, I2_tb, I3_tb : std_logic := '0';
    signal S_tb                         : std_logic_vector(1 downto 0) := "00";
    signal Y_tb                         : std_logic;

    begin

    -- Connect testbench signals to the MUX ports
    UUT : component mux4to1
        port map (
            I0 => I0_tb,
            I1 => I1_tb,
            I2 => I2_tb,
            I3 => I3_tb,
            S  => S_tb,
            Y  => Y_tb
        );
    stimulus : process is
    begin

        -- Set fixed data values on all inputs
        -- I0=0, I1=1, I2=0, I3=1  (different so we can tell which is selected)
        I0_tb <= '0';
        I1_tb <= '1';
        I2_tb <= '0';
        I3_tb <= '1';
        -- Test S="00" → Y should follow I0 = 0
        S_tb <= "00";
        wait for 20 ns;

        -- Test S="01" → Y should follow I1 = 1
        S_tb <= "01";
        wait for 20 ns;

        -- Test S="10" → Y should follow I2 = 0
        S_tb <= "10";
        wait for 20 ns;

        -- Test S="11" → Y should follow I3 = 1
        S_tb <= "11";
        wait for 20 ns;

        -- Now change input values to double-check
        I0_tb <= '1';
        I1_tb <= '0';
        I2_tb <= '1';
        I3_tb <= '0';

        -- Repeat selector tests with new input values
        S_tb <= "00"; wait for 20 ns;   -- Y should = 1 (I0)
        S_tb <= "01"; wait for 20 ns;   -- Y should = 0 (I1)
        S_tb <= "10"; wait for 20 ns;   -- Y should = 1 (I2)
        S_tb <= "11"; wait for 20 ns;   -- Y should = 0 (I3)

        wait;   -- end simulation
    end process stimulus;

end architecture sim;