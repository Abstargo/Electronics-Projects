

entity full_adder is
    port (
        A, B, CIN : in bit;
        SUM, COUT : out bit;
    );
end entity full_adder;


architecture behavioral of full_adder is
    begin
        SUM <= A xor B xor CIN;
        COUT <= (A and B) or (CIN and (A xor B));

end architecture behavioral;