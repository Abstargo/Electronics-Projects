-- Codeur


entity priority_encoder is
    port (
        A: in bit_vector(7 downto 0);
        B: out bit_vector(3 downto 0) -- B(3)=V, B(2..0)=Y
    );
end entity;

architecture behavioral of priority_encoder is 
    signal V : bit;
    signal Y : bit_vector(2 downto 0);
begin
    process (A)
    begin
        V <= '0';
        Y <= "000";

        -- Parcours des bits du plus fort au plus faible (A7 à A0)

        if A(7) = '1' then
            V <= '1';
            Y <= "111"; -- indice 7
			end if ;
        if A(6) = '1' then
            V <= '1';
            Y <= "110";
		  end if ;
        if A(5) = '1' then
            V <= '1';
            Y <= "101";
		  end if ;
        if A(4) = '1' then
            V <= '1';
            Y <= "100";
		  end if ;
        if A(3) = '1' then
            V <= '1';
            Y <= "011";
		  end if ;
        if A(2) = '1' then
            V <= '1';
            Y <= "010";
		  end if ;
        if A(1) = '1' then
            V <= '1';
            Y <= "001";
		  end if ;
        if A(0) = '1' then
            V <= '1';
            Y <= "000";
        else 				
            V <= '0';
            Y <= "000";
        end if;
    end process;

    -- Assemblage de la sortie B (V en bit de poids fort, Y en bits faibles)
    B <= V & Y;
end architecture behavioral;