
-- OR GATE --

library ieee;
use ieee.std_logic_1164.all;

entity Or2 is
    port (
        I1 : in std_logic;
        I2 : in std_logic;
        Y : out std_logic
    );

end entity Or2;

architecture behavioral of Or2 is
    begin
        Y <= I1 and I2;

end architecture behavioral;