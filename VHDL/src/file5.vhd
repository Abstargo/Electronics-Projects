-- Demultiplexeur with gen

...

architecture generated of demux_1to8 is
    begin
        gen: for i in 0 to 7 generate
            Y(i) <= E when (S = to_bitvector(i, 3)) else '0';
        end generate;
end architecture;