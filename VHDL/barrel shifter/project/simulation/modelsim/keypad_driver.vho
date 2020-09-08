-- Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 15.1.0 Build 185 10/21/2015 SJ Lite Edition"

-- DATE "06/13/2020 17:24:32"

-- 
-- Device: Altera 5CGXFC7C7F23C8 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	keypad_driver IS
    PORT (
	inp_br : IN std_logic_vector(7 DOWNTO 0);
	inp_bl : IN std_logic_vector(7 DOWNTO 0);
	inp_r : IN std_logic_vector(7 DOWNTO 0);
	inp_l : IN std_logic_vector(7 DOWNTO 0);
	out_br : BUFFER std_logic_vector(7 DOWNTO 0);
	out_bl : BUFFER std_logic_vector(7 DOWNTO 0);
	out_r : BUFFER std_logic_vector(7 DOWNTO 0);
	out_l : BUFFER std_logic_vector(7 DOWNTO 0)
	);
END keypad_driver;

-- Design Ports Information
-- out_br[0]	=>  Location: PIN_H14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[1]	=>  Location: PIN_D7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[2]	=>  Location: PIN_B5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[3]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[4]	=>  Location: PIN_G6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[5]	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[6]	=>  Location: PIN_K9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[7]	=>  Location: PIN_J9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[0]	=>  Location: PIN_D6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[1]	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[2]	=>  Location: PIN_K7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[3]	=>  Location: PIN_C15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[4]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[5]	=>  Location: PIN_E7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[6]	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[7]	=>  Location: PIN_G13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[0]	=>  Location: PIN_D17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[1]	=>  Location: PIN_F9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[2]	=>  Location: PIN_H8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[3]	=>  Location: PIN_J11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[4]	=>  Location: PIN_F12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[5]	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[6]	=>  Location: PIN_A14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[7]	=>  Location: PIN_G12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[0]	=>  Location: PIN_F14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[1]	=>  Location: PIN_B13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[2]	=>  Location: PIN_A7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[3]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[4]	=>  Location: PIN_B12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[5]	=>  Location: PIN_K16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[6]	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[7]	=>  Location: PIN_B16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[4]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[5]	=>  Location: PIN_D9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[6]	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[7]	=>  Location: PIN_E9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[0]	=>  Location: PIN_F7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[1]	=>  Location: PIN_F13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[2]	=>  Location: PIN_L8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[3]	=>  Location: PIN_H9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[1]	=>  Location: PIN_C6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[2]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[3]	=>  Location: PIN_F10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[4]	=>  Location: PIN_B15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[5]	=>  Location: PIN_E12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[6]	=>  Location: PIN_H6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[7]	=>  Location: PIN_G10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[0]	=>  Location: PIN_G11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[3]	=>  Location: PIN_E16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[4]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[5]	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[6]	=>  Location: PIN_E14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[7]	=>  Location: PIN_H13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[0]	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[1]	=>  Location: PIN_F15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[2]	=>  Location: PIN_H11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[3]	=>  Location: PIN_G15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[4]	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[5]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[6]	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[7]	=>  Location: PIN_A12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[0]	=>  Location: PIN_J17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[1]	=>  Location: PIN_C9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[2]	=>  Location: PIN_K20,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF keypad_driver IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_inp_br : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_inp_bl : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_inp_r : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_inp_l : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_out_br : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_out_bl : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_out_r : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_out_l : std_logic_vector(7 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \inp_br[4]~input_o\ : std_logic;
SIGNAL \inp_br[5]~input_o\ : std_logic;
SIGNAL \inp_br[6]~input_o\ : std_logic;
SIGNAL \inp_br[7]~input_o\ : std_logic;
SIGNAL \inp_br[0]~input_o\ : std_logic;
SIGNAL \inp_br[1]~input_o\ : std_logic;
SIGNAL \inp_br[2]~input_o\ : std_logic;
SIGNAL \inp_br[3]~input_o\ : std_logic;
SIGNAL \inp_bl[1]~input_o\ : std_logic;
SIGNAL \inp_bl[2]~input_o\ : std_logic;
SIGNAL \inp_bl[3]~input_o\ : std_logic;
SIGNAL \inp_bl[4]~input_o\ : std_logic;
SIGNAL \inp_bl[5]~input_o\ : std_logic;
SIGNAL \inp_bl[6]~input_o\ : std_logic;
SIGNAL \inp_bl[7]~input_o\ : std_logic;
SIGNAL \inp_bl[0]~input_o\ : std_logic;
SIGNAL \inp_r[3]~input_o\ : std_logic;
SIGNAL \inp_r[4]~input_o\ : std_logic;
SIGNAL \inp_r[5]~input_o\ : std_logic;
SIGNAL \inp_r[6]~input_o\ : std_logic;
SIGNAL \inp_r[7]~input_o\ : std_logic;
SIGNAL \inp_r[0]~input_o\ : std_logic;
SIGNAL \inp_r[1]~input_o\ : std_logic;
SIGNAL \inp_r[2]~input_o\ : std_logic;
SIGNAL \inp_l[3]~input_o\ : std_logic;
SIGNAL \inp_l[4]~input_o\ : std_logic;
SIGNAL \inp_l[5]~input_o\ : std_logic;
SIGNAL \inp_l[6]~input_o\ : std_logic;
SIGNAL \inp_l[7]~input_o\ : std_logic;
SIGNAL \inp_l[0]~input_o\ : std_logic;
SIGNAL \inp_l[1]~input_o\ : std_logic;
SIGNAL \inp_l[2]~input_o\ : std_logic;

BEGIN

ww_inp_br <= inp_br;
ww_inp_bl <= inp_bl;
ww_inp_r <= inp_r;
ww_inp_l <= inp_l;
out_br <= ww_out_br;
out_bl <= ww_out_bl;
out_r <= ww_out_r;
out_l <= ww_out_l;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X60_Y81_N2
\out_br[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_br[4]~input_o\,
	devoe => ww_devoe,
	o => ww_out_br(0));

-- Location: IOOBUF_X28_Y81_N36
\out_br[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_br[5]~input_o\,
	devoe => ww_devoe,
	o => ww_out_br(1));

-- Location: IOOBUF_X34_Y81_N93
\out_br[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_br[6]~input_o\,
	devoe => ww_devoe,
	o => ww_out_br(2));

-- Location: IOOBUF_X28_Y81_N53
\out_br[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_br[7]~input_o\,
	devoe => ww_devoe,
	o => ww_out_br(3));

-- Location: IOOBUF_X26_Y81_N42
\out_br[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_br[0]~input_o\,
	devoe => ww_devoe,
	o => ww_out_br(4));

-- Location: IOOBUF_X58_Y81_N93
\out_br[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_br[1]~input_o\,
	devoe => ww_devoe,
	o => ww_out_br(5));

-- Location: IOOBUF_X52_Y81_N53
\out_br[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_br[2]~input_o\,
	devoe => ww_devoe,
	o => ww_out_br(6));

-- Location: IOOBUF_X36_Y81_N2
\out_br[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_br[3]~input_o\,
	devoe => ww_devoe,
	o => ww_out_br(7));

-- Location: IOOBUF_X30_Y81_N53
\out_bl[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_bl[1]~input_o\,
	devoe => ww_devoe,
	o => ww_out_bl(0));

-- Location: IOOBUF_X54_Y81_N2
\out_bl[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_bl[2]~input_o\,
	devoe => ww_devoe,
	o => ww_out_bl(1));

-- Location: IOOBUF_X40_Y81_N53
\out_bl[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_bl[3]~input_o\,
	devoe => ww_devoe,
	o => ww_out_bl(2));

-- Location: IOOBUF_X62_Y81_N2
\out_bl[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_bl[4]~input_o\,
	devoe => ww_devoe,
	o => ww_out_bl(3));

-- Location: IOOBUF_X50_Y81_N93
\out_bl[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_bl[5]~input_o\,
	devoe => ww_devoe,
	o => ww_out_bl(4));

-- Location: IOOBUF_X26_Y81_N93
\out_bl[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_bl[6]~input_o\,
	devoe => ww_devoe,
	o => ww_out_bl(5));

-- Location: IOOBUF_X40_Y81_N36
\out_bl[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_bl[7]~input_o\,
	devoe => ww_devoe,
	o => ww_out_bl(6));

-- Location: IOOBUF_X56_Y81_N19
\out_bl[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_bl[0]~input_o\,
	devoe => ww_devoe,
	o => ww_out_bl(7));

-- Location: IOOBUF_X70_Y81_N2
\out_r[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[3]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(0));

-- Location: IOOBUF_X32_Y81_N19
\out_r[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[4]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(1));

-- Location: IOOBUF_X38_Y81_N36
\out_r[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[5]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(2));

-- Location: IOOBUF_X58_Y81_N76
\out_r[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[6]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(3));

-- Location: IOOBUF_X56_Y81_N53
\out_r[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[7]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(4));

-- Location: IOOBUF_X50_Y81_N76
\out_r[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[0]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(5));

-- Location: IOOBUF_X66_Y81_N93
\out_r[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[1]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(6));

-- Location: IOOBUF_X52_Y81_N19
\out_r[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[2]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(7));

-- Location: IOOBUF_X62_Y81_N53
\out_l[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[3]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(0));

-- Location: IOOBUF_X60_Y81_N36
\out_l[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[4]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(1));

-- Location: IOOBUF_X30_Y81_N19
\out_l[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[5]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(2));

-- Location: IOOBUF_X36_Y81_N36
\out_l[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[6]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(3));

-- Location: IOOBUF_X54_Y81_N36
\out_l[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[7]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(4));

-- Location: IOOBUF_X64_Y81_N53
\out_l[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[0]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(5));

-- Location: IOOBUF_X34_Y81_N42
\out_l[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[1]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(6));

-- Location: IOOBUF_X72_Y81_N36
\out_l[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[2]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(7));

-- Location: IOIBUF_X60_Y81_N52
\inp_br[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(4),
	o => \inp_br[4]~input_o\);

-- Location: IOIBUF_X28_Y81_N18
\inp_br[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(5),
	o => \inp_br[5]~input_o\);

-- Location: IOIBUF_X34_Y81_N75
\inp_br[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(6),
	o => \inp_br[6]~input_o\);

-- Location: IOIBUF_X28_Y81_N1
\inp_br[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(7),
	o => \inp_br[7]~input_o\);

-- Location: IOIBUF_X26_Y81_N75
\inp_br[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(0),
	o => \inp_br[0]~input_o\);

-- Location: IOIBUF_X58_Y81_N58
\inp_br[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(1),
	o => \inp_br[1]~input_o\);

-- Location: IOIBUF_X52_Y81_N35
\inp_br[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(2),
	o => \inp_br[2]~input_o\);

-- Location: IOIBUF_X36_Y81_N18
\inp_br[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(3),
	o => \inp_br[3]~input_o\);

-- Location: IOIBUF_X30_Y81_N35
\inp_bl[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(1),
	o => \inp_bl[1]~input_o\);

-- Location: IOIBUF_X54_Y81_N18
\inp_bl[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(2),
	o => \inp_bl[2]~input_o\);

-- Location: IOIBUF_X40_Y81_N18
\inp_bl[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(3),
	o => \inp_bl[3]~input_o\);

-- Location: IOIBUF_X62_Y81_N18
\inp_bl[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(4),
	o => \inp_bl[4]~input_o\);

-- Location: IOIBUF_X50_Y81_N58
\inp_bl[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(5),
	o => \inp_bl[5]~input_o\);

-- Location: IOIBUF_X26_Y81_N58
\inp_bl[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(6),
	o => \inp_bl[6]~input_o\);

-- Location: IOIBUF_X40_Y81_N1
\inp_bl[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(7),
	o => \inp_bl[7]~input_o\);

-- Location: IOIBUF_X56_Y81_N35
\inp_bl[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(0),
	o => \inp_bl[0]~input_o\);

-- Location: IOIBUF_X70_Y81_N18
\inp_r[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(3),
	o => \inp_r[3]~input_o\);

-- Location: IOIBUF_X32_Y81_N1
\inp_r[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(4),
	o => \inp_r[4]~input_o\);

-- Location: IOIBUF_X38_Y81_N1
\inp_r[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(5),
	o => \inp_r[5]~input_o\);

-- Location: IOIBUF_X58_Y81_N41
\inp_r[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(6),
	o => \inp_r[6]~input_o\);

-- Location: IOIBUF_X56_Y81_N1
\inp_r[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(7),
	o => \inp_r[7]~input_o\);

-- Location: IOIBUF_X50_Y81_N41
\inp_r[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(0),
	o => \inp_r[0]~input_o\);

-- Location: IOIBUF_X66_Y81_N58
\inp_r[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(1),
	o => \inp_r[1]~input_o\);

-- Location: IOIBUF_X52_Y81_N1
\inp_r[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(2),
	o => \inp_r[2]~input_o\);

-- Location: IOIBUF_X62_Y81_N35
\inp_l[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(3),
	o => \inp_l[3]~input_o\);

-- Location: IOIBUF_X60_Y81_N18
\inp_l[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(4),
	o => \inp_l[4]~input_o\);

-- Location: IOIBUF_X30_Y81_N1
\inp_l[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(5),
	o => \inp_l[5]~input_o\);

-- Location: IOIBUF_X36_Y81_N52
\inp_l[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(6),
	o => \inp_l[6]~input_o\);

-- Location: IOIBUF_X54_Y81_N52
\inp_l[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(7),
	o => \inp_l[7]~input_o\);

-- Location: IOIBUF_X64_Y81_N35
\inp_l[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(0),
	o => \inp_l[0]~input_o\);

-- Location: IOIBUF_X34_Y81_N58
\inp_l[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(1),
	o => \inp_l[1]~input_o\);

-- Location: IOIBUF_X72_Y81_N1
\inp_l[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(2),
	o => \inp_l[2]~input_o\);

-- Location: LABCELL_X22_Y51_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


