

---- PWM GENERATEUR  ----


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pwm_generator is
    port
       (
        CLK : in std_logic;
        N   : in std_logic_vector(3 downto 0);
        PWM : out std_logic
       );
end entity pwm_generator;

architecture behavioral of pwm_generator is

    signal counter : unsigned(3 downto 0) := (others => '0');

    begin

        process (CLK) is
        begin
            if rising_edge(CLK) then
                if counter = 15 then
                    counter <= (others => '0');
                else
                    counter <= counter + 1;

                end if;
            end if;
        end process;
    
    PWM <= '1' when counter < unsigned(N) else '0';

end architecture behavioral;