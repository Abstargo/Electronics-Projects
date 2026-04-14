entity d_ff is
    port (d, clk : in bit; q : out bit);
end d_ff;

---------------------------------------------

architecture basic of d_ff is
    begin
        ff_behavior : process is
            begin 
                ff_behavior : process is
                    begin
                        wait until clk = '1';
                        q <= d after 2 ns;
                    end process ff_behavior;
end architecture basic;

-------------------------------------------------------

entity and2 is
    port (a, b : in bit, y : out bit);
end and2;

architecture basic of and2 is
    begin
        and2_behavior : process is
            begin
                y <= a and b after 2 ns;
                wait on a, b;
            end process and2_behavior;
end architecture basic;