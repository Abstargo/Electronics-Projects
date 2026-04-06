entity CC is port (
    X : in bit_vector(1 downto 0);
    Y : out bit_vector(1 downto 0)
);
end entity;

architecture A_CC of CC is
    begin
    process(X)
        begin
        if X(1)='0' then
            Y <="01";
        elsif X(0)='0' then
            Y <= "00";
        else Y <= "11";
        end if;
    end process;
end A_CC;