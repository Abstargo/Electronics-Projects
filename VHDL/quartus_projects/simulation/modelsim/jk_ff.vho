-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"

-- DATE "04/28/2026 15:44:06"

-- 
-- Device: Altera EP4CGX15BF14C6 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	jk_ff IS
    PORT (
	j : IN std_logic;
	k : IN std_logic;
	clk : IN std_logic;
	r : IN std_logic;
	s : IN std_logic;
	q : OUT std_logic;
	p : OUT std_logic
	);
END jk_ff;

-- Design Ports Information
-- q	=>  Location: PIN_M4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- p	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- s	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- r	=>  Location: PIN_L5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- k	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- j	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF jk_ff IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_j : std_logic;
SIGNAL ww_k : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_r : std_logic;
SIGNAL ww_s : std_logic;
SIGNAL ww_q : std_logic;
SIGNAL ww_p : std_logic;
SIGNAL \q~output_o\ : std_logic;
SIGNAL \p~output_o\ : std_logic;
SIGNAL \s~input_o\ : std_logic;
SIGNAL \r~input_o\ : std_logic;
SIGNAL \TMP~1_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \k~input_o\ : std_logic;
SIGNAL \j~input_o\ : std_logic;
SIGNAL \TMP~3_combout\ : std_logic;
SIGNAL \TMP~0_combout\ : std_logic;
SIGNAL \TMP~_emulated_q\ : std_logic;
SIGNAL \TMP~2_combout\ : std_logic;
SIGNAL \ALT_INV_TMP~0_combout\ : std_logic;
SIGNAL \ALT_INV_TMP~2_combout\ : std_logic;

BEGIN

ww_j <= j;
ww_k <= k;
ww_clk <= clk;
ww_r <= r;
ww_s <= s;
q <= ww_q;
p <= ww_p;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_TMP~0_combout\ <= NOT \TMP~0_combout\;
\ALT_INV_TMP~2_combout\ <= NOT \TMP~2_combout\;

-- Location: IOOBUF_X8_Y0_N2
\q~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \TMP~2_combout\,
	devoe => ww_devoe,
	o => \q~output_o\);

-- Location: IOOBUF_X8_Y0_N9
\p~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_TMP~2_combout\,
	devoe => ww_devoe,
	o => \p~output_o\);

-- Location: IOIBUF_X12_Y0_N8
\s~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_s,
	o => \s~input_o\);

-- Location: IOIBUF_X14_Y0_N8
\r~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_r,
	o => \r~input_o\);

-- Location: LCCOMB_X13_Y1_N2
\TMP~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \TMP~1_combout\ = (!\r~input_o\ & ((\s~input_o\) # (\TMP~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \r~input_o\,
	datac => \s~input_o\,
	datad => \TMP~1_combout\,
	combout => \TMP~1_combout\);

-- Location: IOIBUF_X12_Y0_N1
\clk~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: IOIBUF_X14_Y0_N1
\k~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_k,
	o => \k~input_o\);

-- Location: IOIBUF_X10_Y0_N8
\j~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_j,
	o => \j~input_o\);

-- Location: LCCOMB_X13_Y1_N28
\TMP~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \TMP~3_combout\ = \TMP~1_combout\ $ (((\TMP~2_combout\ & (!\k~input_o\)) # (!\TMP~2_combout\ & ((\j~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100100111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \k~input_o\,
	datab => \TMP~1_combout\,
	datac => \j~input_o\,
	datad => \TMP~2_combout\,
	combout => \TMP~3_combout\);

-- Location: LCCOMB_X13_Y1_N12
\TMP~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \TMP~0_combout\ = (\r~input_o\) # (\s~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \r~input_o\,
	datac => \s~input_o\,
	combout => \TMP~0_combout\);

-- Location: FF_X13_Y1_N29
\TMP~_emulated\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TMP~3_combout\,
	clrn => \ALT_INV_TMP~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TMP~_emulated_q\);

-- Location: LCCOMB_X13_Y1_N10
\TMP~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \TMP~2_combout\ = (!\r~input_o\ & ((\s~input_o\) # (\TMP~1_combout\ $ (\TMP~_emulated_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101100001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \s~input_o\,
	datab => \TMP~1_combout\,
	datac => \r~input_o\,
	datad => \TMP~_emulated_q\,
	combout => \TMP~2_combout\);

ww_q <= \q~output_o\;

ww_p <= \p~output_o\;
END structure;


