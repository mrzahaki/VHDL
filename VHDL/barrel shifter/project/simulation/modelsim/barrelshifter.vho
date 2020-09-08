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

-- DATE "06/15/2020 11:08:36"

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

ENTITY 	barrelshifter IS
    PORT (
	inp_br : IN std_logic_vector(7 DOWNTO 0);
	inp_bl : IN std_logic_vector(7 DOWNTO 0);
	inp_r : IN std_logic_vector(15 DOWNTO 0);
	inp_l : IN std_logic_vector(15 DOWNTO 0);
	shift_num : IN std_logic_vector(3 DOWNTO 0);
	out_br : OUT std_logic_vector(7 DOWNTO 0);
	out_bl : OUT std_logic_vector(7 DOWNTO 0);
	out_r : OUT std_logic_vector(15 DOWNTO 0);
	out_l : OUT std_logic_vector(15 DOWNTO 0)
	);
END barrelshifter;

-- Design Ports Information
-- inp_r[0]	=>  Location: PIN_A12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[1]	=>  Location: PIN_G15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[2]	=>  Location: PIN_U12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[3]	=>  Location: PIN_U22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[4]	=>  Location: PIN_F9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[11]	=>  Location: PIN_AA19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[12]	=>  Location: PIN_T8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[13]	=>  Location: PIN_T10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[14]	=>  Location: PIN_W16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[15]	=>  Location: PIN_B13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- shift_num[3]	=>  Location: PIN_K17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[0]	=>  Location: PIN_H20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[1]	=>  Location: PIN_A20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[2]	=>  Location: PIN_B16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[3]	=>  Location: PIN_C19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[4]	=>  Location: PIN_E22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[5]	=>  Location: PIN_E16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[6]	=>  Location: PIN_A17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_br[7]	=>  Location: PIN_A14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[0]	=>  Location: PIN_H15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[1]	=>  Location: PIN_C16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[2]	=>  Location: PIN_K16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[3]	=>  Location: PIN_G18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[4]	=>  Location: PIN_C18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[5]	=>  Location: PIN_J18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[6]	=>  Location: PIN_B21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_bl[7]	=>  Location: PIN_K20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[0]	=>  Location: PIN_H16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[1]	=>  Location: PIN_E14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[2]	=>  Location: PIN_C15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[3]	=>  Location: PIN_K9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[4]	=>  Location: PIN_B17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[5]	=>  Location: PIN_C21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[6]	=>  Location: PIN_H14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[7]	=>  Location: PIN_A7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[8]	=>  Location: PIN_L8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[9]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[10]	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[11]	=>  Location: PIN_AB15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[12]	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[13]	=>  Location: PIN_AB7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[14]	=>  Location: PIN_J9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_r[15]	=>  Location: PIN_N21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[0]	=>  Location: PIN_U16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[1]	=>  Location: PIN_AA22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[2]	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[3]	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[4]	=>  Location: PIN_B18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[5]	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[6]	=>  Location: PIN_D7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[7]	=>  Location: PIN_B6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[8]	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[9]	=>  Location: PIN_H13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[10]	=>  Location: PIN_C6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[11]	=>  Location: PIN_E19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[12]	=>  Location: PIN_F13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[13]	=>  Location: PIN_D21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[14]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_l[15]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- shift_num[2]	=>  Location: PIN_A18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[4]	=>  Location: PIN_E20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[5]	=>  Location: PIN_F20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[6]	=>  Location: PIN_G22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[7]	=>  Location: PIN_D22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- shift_num[0]	=>  Location: PIN_K19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- shift_num[1]	=>  Location: PIN_D17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[0]	=>  Location: PIN_A22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[1]	=>  Location: PIN_F19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[2]	=>  Location: PIN_F18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_br[3]	=>  Location: PIN_B22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[4]	=>  Location: PIN_E15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[3]	=>  Location: PIN_F15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[2]	=>  Location: PIN_G16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[1]	=>  Location: PIN_G17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[0]	=>  Location: PIN_A15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[7]	=>  Location: PIN_J17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[6]	=>  Location: PIN_A19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_bl[5]	=>  Location: PIN_H18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[5]	=>  Location: PIN_J19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[6]	=>  Location: PIN_J11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[7]	=>  Location: PIN_B15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[8]	=>  Location: PIN_G12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[9]	=>  Location: PIN_D19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[10]	=>  Location: PIN_F22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[11]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[12]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[13]	=>  Location: PIN_H11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[14]	=>  Location: PIN_H9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_r[15]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[0]	=>  Location: PIN_J8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[1]	=>  Location: PIN_E7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[2]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[3]	=>  Location: PIN_K7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[4]	=>  Location: PIN_F12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[5]	=>  Location: PIN_D6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[6]	=>  Location: PIN_C20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[7]	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[8]	=>  Location: PIN_H21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[9]	=>  Location: PIN_D9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inp_l[10]	=>  Location: PIN_B12,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF barrelshifter IS
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
SIGNAL ww_inp_r : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_inp_l : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_shift_num : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_out_br : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_out_bl : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_out_r : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_out_l : std_logic_vector(15 DOWNTO 0);
SIGNAL \inp_r[0]~input_o\ : std_logic;
SIGNAL \inp_r[1]~input_o\ : std_logic;
SIGNAL \inp_r[2]~input_o\ : std_logic;
SIGNAL \inp_r[3]~input_o\ : std_logic;
SIGNAL \inp_r[4]~input_o\ : std_logic;
SIGNAL \inp_l[11]~input_o\ : std_logic;
SIGNAL \inp_l[12]~input_o\ : std_logic;
SIGNAL \inp_l[13]~input_o\ : std_logic;
SIGNAL \inp_l[14]~input_o\ : std_logic;
SIGNAL \inp_l[15]~input_o\ : std_logic;
SIGNAL \shift_num[3]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \shift_num[2]~input_o\ : std_logic;
SIGNAL \inp_br[7]~input_o\ : std_logic;
SIGNAL \shift_num[1]~input_o\ : std_logic;
SIGNAL \inp_br[4]~input_o\ : std_logic;
SIGNAL \inp_br[5]~input_o\ : std_logic;
SIGNAL \shift_num[0]~input_o\ : std_logic;
SIGNAL \inp_br[6]~input_o\ : std_logic;
SIGNAL \FA1|GE0:0:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \inp_br[0]~input_o\ : std_logic;
SIGNAL \inp_br[2]~input_o\ : std_logic;
SIGNAL \inp_br[1]~input_o\ : std_logic;
SIGNAL \inp_br[3]~input_o\ : std_logic;
SIGNAL \FA1|GE0:0:FA0|Mux0~1_combout\ : std_logic;
SIGNAL \FA1|GE0:0:FA0|Mux0~2_combout\ : std_logic;
SIGNAL \FA1|GE0:7:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA1|GE0:7:FA0|Mux0~1_combout\ : std_logic;
SIGNAL \FA1|GE0:1:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA1|GE0:0:FA0|Mux0~4_combout\ : std_logic;
SIGNAL \FA1|GE0:0:FA0|Mux0~3_combout\ : std_logic;
SIGNAL \FA1|GE0:2:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA1|GE0:7:FA0|Mux0~2_combout\ : std_logic;
SIGNAL \FA1|GE0:7:FA0|Mux0~3_combout\ : std_logic;
SIGNAL \FA1|GE0:3:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA1|GE0:4:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA1|GE0:5:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA1|GE0:6:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA1|GE0:7:FA0|Mux0~4_combout\ : std_logic;
SIGNAL \inp_bl[1]~input_o\ : std_logic;
SIGNAL \inp_bl[4]~input_o\ : std_logic;
SIGNAL \inp_bl[3]~input_o\ : std_logic;
SIGNAL \inp_bl[2]~input_o\ : std_logic;
SIGNAL \FA0|GE0:0:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \inp_bl[6]~input_o\ : std_logic;
SIGNAL \inp_bl[7]~input_o\ : std_logic;
SIGNAL \inp_bl[5]~input_o\ : std_logic;
SIGNAL \inp_bl[0]~input_o\ : std_logic;
SIGNAL \FA0|GE0:0:FA0|Mux0~1_combout\ : std_logic;
SIGNAL \FA0|GE0:0:FA0|Mux0~2_combout\ : std_logic;
SIGNAL \FA0|GE0:7:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA0|GE0:7:FA0|Mux0~1_combout\ : std_logic;
SIGNAL \FA0|GE0:1:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA0|GE0:0:FA0|Mux0~4_combout\ : std_logic;
SIGNAL \FA0|GE0:0:FA0|Mux0~3_combout\ : std_logic;
SIGNAL \FA0|GE0:2:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA0|GE0:7:FA0|Mux0~2_combout\ : std_logic;
SIGNAL \FA0|GE0:7:FA0|Mux0~3_combout\ : std_logic;
SIGNAL \FA0|GE0:3:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA0|GE0:4:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA0|GE0:5:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA0|GE0:6:FA0|Mux0~0_combout\ : std_logic;
SIGNAL \FA0|GE0:7:FA0|Mux0~4_combout\ : std_logic;
SIGNAL \inp_r[5]~input_o\ : std_logic;
SIGNAL \inp_r[6]~input_o\ : std_logic;
SIGNAL \inp_r[7]~input_o\ : std_logic;
SIGNAL \inp_r[8]~input_o\ : std_logic;
SIGNAL \inp_r[9]~input_o\ : std_logic;
SIGNAL \inp_r[10]~input_o\ : std_logic;
SIGNAL \inp_r[11]~input_o\ : std_logic;
SIGNAL \inp_r[12]~input_o\ : std_logic;
SIGNAL \inp_r[13]~input_o\ : std_logic;
SIGNAL \inp_r[14]~input_o\ : std_logic;
SIGNAL \inp_r[15]~input_o\ : std_logic;
SIGNAL \inp_l[0]~input_o\ : std_logic;
SIGNAL \inp_l[1]~input_o\ : std_logic;
SIGNAL \inp_l[2]~input_o\ : std_logic;
SIGNAL \inp_l[3]~input_o\ : std_logic;
SIGNAL \inp_l[4]~input_o\ : std_logic;
SIGNAL \inp_l[5]~input_o\ : std_logic;
SIGNAL \inp_l[6]~input_o\ : std_logic;
SIGNAL \inp_l[7]~input_o\ : std_logic;
SIGNAL \inp_l[8]~input_o\ : std_logic;
SIGNAL \inp_l[9]~input_o\ : std_logic;
SIGNAL \inp_l[10]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_bl[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_bl[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_bl[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_bl[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_bl[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_bl[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_bl[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_bl[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_br[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_br[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_br[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_br[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_shift_num[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_shift_num[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_br[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_br[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_br[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_inp_br[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_shift_num[2]~input_o\ : std_logic;
SIGNAL \FA0|GE0:7:FA0|ALT_INV_Mux0~3_combout\ : std_logic;
SIGNAL \FA0|GE0:7:FA0|ALT_INV_Mux0~2_combout\ : std_logic;
SIGNAL \FA0|GE0:0:FA0|ALT_INV_Mux0~4_combout\ : std_logic;
SIGNAL \FA0|GE0:0:FA0|ALT_INV_Mux0~3_combout\ : std_logic;
SIGNAL \FA0|GE0:7:FA0|ALT_INV_Mux0~1_combout\ : std_logic;
SIGNAL \FA0|GE0:7:FA0|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \FA0|GE0:0:FA0|ALT_INV_Mux0~1_combout\ : std_logic;
SIGNAL \FA0|GE0:0:FA0|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \FA1|GE0:7:FA0|ALT_INV_Mux0~3_combout\ : std_logic;
SIGNAL \FA1|GE0:7:FA0|ALT_INV_Mux0~2_combout\ : std_logic;
SIGNAL \FA1|GE0:0:FA0|ALT_INV_Mux0~4_combout\ : std_logic;
SIGNAL \FA1|GE0:0:FA0|ALT_INV_Mux0~3_combout\ : std_logic;
SIGNAL \FA1|GE0:7:FA0|ALT_INV_Mux0~1_combout\ : std_logic;
SIGNAL \FA1|GE0:7:FA0|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \FA1|GE0:0:FA0|ALT_INV_Mux0~1_combout\ : std_logic;
SIGNAL \FA1|GE0:0:FA0|ALT_INV_Mux0~0_combout\ : std_logic;

BEGIN

ww_inp_br <= inp_br;
ww_inp_bl <= inp_bl;
ww_inp_r <= inp_r;
ww_inp_l <= inp_l;
ww_shift_num <= shift_num;
out_br <= ww_out_br;
out_bl <= ww_out_bl;
out_r <= ww_out_r;
out_l <= ww_out_l;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_inp_bl[5]~input_o\ <= NOT \inp_bl[5]~input_o\;
\ALT_INV_inp_bl[6]~input_o\ <= NOT \inp_bl[6]~input_o\;
\ALT_INV_inp_bl[7]~input_o\ <= NOT \inp_bl[7]~input_o\;
\ALT_INV_inp_bl[0]~input_o\ <= NOT \inp_bl[0]~input_o\;
\ALT_INV_inp_bl[1]~input_o\ <= NOT \inp_bl[1]~input_o\;
\ALT_INV_inp_bl[2]~input_o\ <= NOT \inp_bl[2]~input_o\;
\ALT_INV_inp_bl[3]~input_o\ <= NOT \inp_bl[3]~input_o\;
\ALT_INV_inp_bl[4]~input_o\ <= NOT \inp_bl[4]~input_o\;
\ALT_INV_inp_br[3]~input_o\ <= NOT \inp_br[3]~input_o\;
\ALT_INV_inp_br[2]~input_o\ <= NOT \inp_br[2]~input_o\;
\ALT_INV_inp_br[1]~input_o\ <= NOT \inp_br[1]~input_o\;
\ALT_INV_inp_br[0]~input_o\ <= NOT \inp_br[0]~input_o\;
\ALT_INV_shift_num[1]~input_o\ <= NOT \shift_num[1]~input_o\;
\ALT_INV_shift_num[0]~input_o\ <= NOT \shift_num[0]~input_o\;
\ALT_INV_inp_br[7]~input_o\ <= NOT \inp_br[7]~input_o\;
\ALT_INV_inp_br[6]~input_o\ <= NOT \inp_br[6]~input_o\;
\ALT_INV_inp_br[5]~input_o\ <= NOT \inp_br[5]~input_o\;
\ALT_INV_inp_br[4]~input_o\ <= NOT \inp_br[4]~input_o\;
\ALT_INV_shift_num[2]~input_o\ <= NOT \shift_num[2]~input_o\;
\FA0|GE0:7:FA0|ALT_INV_Mux0~3_combout\ <= NOT \FA0|GE0:7:FA0|Mux0~3_combout\;
\FA0|GE0:7:FA0|ALT_INV_Mux0~2_combout\ <= NOT \FA0|GE0:7:FA0|Mux0~2_combout\;
\FA0|GE0:0:FA0|ALT_INV_Mux0~4_combout\ <= NOT \FA0|GE0:0:FA0|Mux0~4_combout\;
\FA0|GE0:0:FA0|ALT_INV_Mux0~3_combout\ <= NOT \FA0|GE0:0:FA0|Mux0~3_combout\;
\FA0|GE0:7:FA0|ALT_INV_Mux0~1_combout\ <= NOT \FA0|GE0:7:FA0|Mux0~1_combout\;
\FA0|GE0:7:FA0|ALT_INV_Mux0~0_combout\ <= NOT \FA0|GE0:7:FA0|Mux0~0_combout\;
\FA0|GE0:0:FA0|ALT_INV_Mux0~1_combout\ <= NOT \FA0|GE0:0:FA0|Mux0~1_combout\;
\FA0|GE0:0:FA0|ALT_INV_Mux0~0_combout\ <= NOT \FA0|GE0:0:FA0|Mux0~0_combout\;
\FA1|GE0:7:FA0|ALT_INV_Mux0~3_combout\ <= NOT \FA1|GE0:7:FA0|Mux0~3_combout\;
\FA1|GE0:7:FA0|ALT_INV_Mux0~2_combout\ <= NOT \FA1|GE0:7:FA0|Mux0~2_combout\;
\FA1|GE0:0:FA0|ALT_INV_Mux0~4_combout\ <= NOT \FA1|GE0:0:FA0|Mux0~4_combout\;
\FA1|GE0:0:FA0|ALT_INV_Mux0~3_combout\ <= NOT \FA1|GE0:0:FA0|Mux0~3_combout\;
\FA1|GE0:7:FA0|ALT_INV_Mux0~1_combout\ <= NOT \FA1|GE0:7:FA0|Mux0~1_combout\;
\FA1|GE0:7:FA0|ALT_INV_Mux0~0_combout\ <= NOT \FA1|GE0:7:FA0|Mux0~0_combout\;
\FA1|GE0:0:FA0|ALT_INV_Mux0~1_combout\ <= NOT \FA1|GE0:0:FA0|Mux0~1_combout\;
\FA1|GE0:0:FA0|ALT_INV_Mux0~0_combout\ <= NOT \FA1|GE0:0:FA0|Mux0~0_combout\;

-- Location: IOOBUF_X80_Y81_N19
\out_br[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA1|GE0:0:FA0|Mux0~2_combout\,
	devoe => ww_devoe,
	o => ww_out_br(0));

-- Location: IOOBUF_X74_Y81_N76
\out_br[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA1|GE0:1:FA0|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_out_br(1));

-- Location: IOOBUF_X72_Y81_N36
\out_br[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA1|GE0:2:FA0|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_out_br(2));

-- Location: IOOBUF_X78_Y81_N2
\out_br[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA1|GE0:3:FA0|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_out_br(3));

-- Location: IOOBUF_X80_Y81_N36
\out_br[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA1|GE0:4:FA0|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_out_br(4));

-- Location: IOOBUF_X70_Y81_N19
\out_br[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA1|GE0:5:FA0|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_out_br(5));

-- Location: IOOBUF_X74_Y81_N59
\out_br[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA1|GE0:6:FA0|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_out_br(6));

-- Location: IOOBUF_X66_Y81_N93
\out_br[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA1|GE0:7:FA0|Mux0~4_combout\,
	devoe => ww_devoe,
	o => ww_out_br(7));

-- Location: IOOBUF_X64_Y81_N19
\out_bl[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA0|GE0:0:FA0|Mux0~2_combout\,
	devoe => ww_devoe,
	o => ww_out_bl(0));

-- Location: IOOBUF_X72_Y81_N53
\out_bl[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA0|GE0:1:FA0|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_out_bl(1));

-- Location: IOOBUF_X64_Y81_N53
\out_bl[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA0|GE0:2:FA0|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_out_bl(2));

-- Location: IOOBUF_X68_Y81_N2
\out_bl[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA0|GE0:3:FA0|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_out_bl(3));

-- Location: IOOBUF_X78_Y81_N19
\out_bl[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA0|GE0:4:FA0|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_out_bl(4));

-- Location: IOOBUF_X68_Y81_N53
\out_bl[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA0|GE0:5:FA0|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_out_bl(5));

-- Location: IOOBUF_X82_Y81_N59
\out_bl[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA0|GE0:6:FA0|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_out_bl(6));

-- Location: IOOBUF_X72_Y81_N2
\out_bl[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA0|GE0:7:FA0|Mux0~4_combout\,
	devoe => ww_devoe,
	o => ww_out_bl(7));

-- Location: IOOBUF_X64_Y81_N2
\out_r[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[5]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(0));

-- Location: IOOBUF_X58_Y81_N42
\out_r[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[6]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(1));

-- Location: IOOBUF_X62_Y81_N2
\out_r[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[7]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(2));

-- Location: IOOBUF_X52_Y81_N53
\out_r[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[8]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(3));

-- Location: IOOBUF_X84_Y81_N53
\out_r[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[9]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(4));

-- Location: IOOBUF_X82_Y81_N42
\out_r[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[10]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(5));

-- Location: IOOBUF_X60_Y81_N2
\out_r[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[11]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(6));

-- Location: IOOBUF_X30_Y81_N19
\out_r[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[12]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(7));

-- Location: IOOBUF_X52_Y81_N36
\out_r[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[13]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(8));

-- Location: IOOBUF_X36_Y81_N36
\out_r[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[14]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(9));

-- Location: IOOBUF_X50_Y81_N76
\out_r[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_r[15]~input_o\,
	devoe => ww_devoe,
	o => ww_out_r(10));

-- Location: IOOBUF_X54_Y0_N53
\out_r[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_out_r(11));

-- Location: IOOBUF_X28_Y0_N2
\out_r[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_out_r(12));

-- Location: IOOBUF_X28_Y0_N36
\out_r[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_out_r(13));

-- Location: IOOBUF_X36_Y81_N2
\out_r[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_out_r(14));

-- Location: IOOBUF_X89_Y35_N96
\out_r[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_out_r(15));

-- Location: IOOBUF_X72_Y0_N19
\out_l[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_out_l(0));

-- Location: IOOBUF_X64_Y0_N36
\out_l[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_out_l(1));

-- Location: IOOBUF_X8_Y0_N19
\out_l[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_out_l(2));

-- Location: IOOBUF_X32_Y0_N19
\out_l[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_out_l(3));

-- Location: IOOBUF_X84_Y81_N36
\out_l[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_out_l(4));

-- Location: IOOBUF_X38_Y81_N2
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

-- Location: IOOBUF_X28_Y81_N36
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

-- Location: IOOBUF_X32_Y81_N36
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

-- Location: IOOBUF_X40_Y81_N36
\out_l[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[3]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(8));

-- Location: IOOBUF_X56_Y81_N2
\out_l[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[4]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(9));

-- Location: IOOBUF_X30_Y81_N36
\out_l[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[5]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(10));

-- Location: IOOBUF_X86_Y81_N2
\out_l[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[6]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(11));

-- Location: IOOBUF_X58_Y81_N59
\out_l[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[7]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(12));

-- Location: IOOBUF_X88_Y81_N54
\out_l[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[8]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(13));

-- Location: IOOBUF_X28_Y81_N53
\out_l[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[9]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(14));

-- Location: IOOBUF_X54_Y81_N19
\out_l[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inp_l[10]~input_o\,
	devoe => ww_devoe,
	o => ww_out_l(15));

-- Location: IOIBUF_X74_Y81_N41
\shift_num[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_shift_num(2),
	o => \shift_num[2]~input_o\);

-- Location: IOIBUF_X80_Y81_N52
\inp_br[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(7),
	o => \inp_br[7]~input_o\);

-- Location: IOIBUF_X70_Y81_N1
\shift_num[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_shift_num(1),
	o => \shift_num[1]~input_o\);

-- Location: IOIBUF_X76_Y81_N35
\inp_br[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(4),
	o => \inp_br[4]~input_o\);

-- Location: IOIBUF_X76_Y81_N52
\inp_br[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(5),
	o => \inp_br[5]~input_o\);

-- Location: IOIBUF_X72_Y81_N18
\shift_num[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_shift_num(0),
	o => \shift_num[0]~input_o\);

-- Location: IOIBUF_X82_Y81_N75
\inp_br[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(6),
	o => \inp_br[6]~input_o\);

-- Location: LABCELL_X73_Y80_N30
\FA1|GE0:0:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:0:FA0|Mux0~0_combout\ = ( \shift_num[0]~input_o\ & ( \inp_br[6]~input_o\ & ( (!\shift_num[1]~input_o\ & ((\inp_br[5]~input_o\))) # (\shift_num[1]~input_o\ & (\inp_br[7]~input_o\)) ) ) ) # ( !\shift_num[0]~input_o\ & ( \inp_br[6]~input_o\ & ( 
-- (\inp_br[4]~input_o\) # (\shift_num[1]~input_o\) ) ) ) # ( \shift_num[0]~input_o\ & ( !\inp_br[6]~input_o\ & ( (!\shift_num[1]~input_o\ & ((\inp_br[5]~input_o\))) # (\shift_num[1]~input_o\ & (\inp_br[7]~input_o\)) ) ) ) # ( !\shift_num[0]~input_o\ & ( 
-- !\inp_br[6]~input_o\ & ( (!\shift_num[1]~input_o\ & \inp_br[4]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000001100000100011101110100111111001111110001000111011101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_inp_br[7]~input_o\,
	datab => \ALT_INV_shift_num[1]~input_o\,
	datac => \ALT_INV_inp_br[4]~input_o\,
	datad => \ALT_INV_inp_br[5]~input_o\,
	datae => \ALT_INV_shift_num[0]~input_o\,
	dataf => \ALT_INV_inp_br[6]~input_o\,
	combout => \FA1|GE0:0:FA0|Mux0~0_combout\);

-- Location: IOIBUF_X78_Y81_N52
\inp_br[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(0),
	o => \inp_br[0]~input_o\);

-- Location: IOIBUF_X76_Y81_N18
\inp_br[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(2),
	o => \inp_br[2]~input_o\);

-- Location: IOIBUF_X76_Y81_N1
\inp_br[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(1),
	o => \inp_br[1]~input_o\);

-- Location: IOIBUF_X78_Y81_N35
\inp_br[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_br(3),
	o => \inp_br[3]~input_o\);

-- Location: LABCELL_X73_Y80_N36
\FA1|GE0:0:FA0|Mux0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:0:FA0|Mux0~1_combout\ = ( \shift_num[0]~input_o\ & ( \inp_br[3]~input_o\ & ( (\inp_br[1]~input_o\) # (\shift_num[1]~input_o\) ) ) ) # ( !\shift_num[0]~input_o\ & ( \inp_br[3]~input_o\ & ( (!\shift_num[1]~input_o\ & (\inp_br[0]~input_o\)) # 
-- (\shift_num[1]~input_o\ & ((\inp_br[2]~input_o\))) ) ) ) # ( \shift_num[0]~input_o\ & ( !\inp_br[3]~input_o\ & ( (!\shift_num[1]~input_o\ & \inp_br[1]~input_o\) ) ) ) # ( !\shift_num[0]~input_o\ & ( !\inp_br[3]~input_o\ & ( (!\shift_num[1]~input_o\ & 
-- (\inp_br[0]~input_o\)) # (\shift_num[1]~input_o\ & ((\inp_br[2]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100011101000111000000001100110001000111010001110011001111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_inp_br[0]~input_o\,
	datab => \ALT_INV_shift_num[1]~input_o\,
	datac => \ALT_INV_inp_br[2]~input_o\,
	datad => \ALT_INV_inp_br[1]~input_o\,
	datae => \ALT_INV_shift_num[0]~input_o\,
	dataf => \ALT_INV_inp_br[3]~input_o\,
	combout => \FA1|GE0:0:FA0|Mux0~1_combout\);

-- Location: LABCELL_X73_Y80_N42
\FA1|GE0:0:FA0|Mux0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:0:FA0|Mux0~2_combout\ = (!\shift_num[2]~input_o\ & ((\FA1|GE0:0:FA0|Mux0~1_combout\))) # (\shift_num[2]~input_o\ & (\FA1|GE0:0:FA0|Mux0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001101100011011000110110001101100011011000110110001101100011011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_shift_num[2]~input_o\,
	datab => \FA1|GE0:0:FA0|ALT_INV_Mux0~0_combout\,
	datac => \FA1|GE0:0:FA0|ALT_INV_Mux0~1_combout\,
	combout => \FA1|GE0:0:FA0|Mux0~2_combout\);

-- Location: LABCELL_X73_Y80_N48
\FA1|GE0:7:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:7:FA0|Mux0~0_combout\ = ( \shift_num[0]~input_o\ & ( \inp_br[6]~input_o\ & ( (!\shift_num[1]~input_o\) # (\inp_br[0]~input_o\) ) ) ) # ( !\shift_num[0]~input_o\ & ( \inp_br[6]~input_o\ & ( (!\shift_num[1]~input_o\ & ((\inp_br[5]~input_o\))) # 
-- (\shift_num[1]~input_o\ & (\inp_br[7]~input_o\)) ) ) ) # ( \shift_num[0]~input_o\ & ( !\inp_br[6]~input_o\ & ( (\shift_num[1]~input_o\ & \inp_br[0]~input_o\) ) ) ) # ( !\shift_num[0]~input_o\ & ( !\inp_br[6]~input_o\ & ( (!\shift_num[1]~input_o\ & 
-- ((\inp_br[5]~input_o\))) # (\shift_num[1]~input_o\ & (\inp_br[7]~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000111011101000000110000001100010001110111011100111111001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_inp_br[7]~input_o\,
	datab => \ALT_INV_shift_num[1]~input_o\,
	datac => \ALT_INV_inp_br[0]~input_o\,
	datad => \ALT_INV_inp_br[5]~input_o\,
	datae => \ALT_INV_shift_num[0]~input_o\,
	dataf => \ALT_INV_inp_br[6]~input_o\,
	combout => \FA1|GE0:7:FA0|Mux0~0_combout\);

-- Location: LABCELL_X73_Y80_N54
\FA1|GE0:7:FA0|Mux0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:7:FA0|Mux0~1_combout\ = ( \shift_num[0]~input_o\ & ( \inp_br[3]~input_o\ & ( (!\shift_num[1]~input_o\ & ((\inp_br[2]~input_o\))) # (\shift_num[1]~input_o\ & (\inp_br[4]~input_o\)) ) ) ) # ( !\shift_num[0]~input_o\ & ( \inp_br[3]~input_o\ & ( 
-- (\inp_br[1]~input_o\) # (\shift_num[1]~input_o\) ) ) ) # ( \shift_num[0]~input_o\ & ( !\inp_br[3]~input_o\ & ( (!\shift_num[1]~input_o\ & ((\inp_br[2]~input_o\))) # (\shift_num[1]~input_o\ & (\inp_br[4]~input_o\)) ) ) ) # ( !\shift_num[0]~input_o\ & ( 
-- !\inp_br[3]~input_o\ & ( (!\shift_num[1]~input_o\ & \inp_br[1]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011001100000111010001110100110011111111110001110100011101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_inp_br[4]~input_o\,
	datab => \ALT_INV_shift_num[1]~input_o\,
	datac => \ALT_INV_inp_br[2]~input_o\,
	datad => \ALT_INV_inp_br[1]~input_o\,
	datae => \ALT_INV_shift_num[0]~input_o\,
	dataf => \ALT_INV_inp_br[3]~input_o\,
	combout => \FA1|GE0:7:FA0|Mux0~1_combout\);

-- Location: LABCELL_X73_Y80_N0
\FA1|GE0:1:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:1:FA0|Mux0~0_combout\ = (!\shift_num[2]~input_o\ & ((\FA1|GE0:7:FA0|Mux0~1_combout\))) # (\shift_num[2]~input_o\ & (\FA1|GE0:7:FA0|Mux0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011010100110101001101010011010100110101001101010011010100110101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA1|GE0:7:FA0|ALT_INV_Mux0~0_combout\,
	datab => \FA1|GE0:7:FA0|ALT_INV_Mux0~1_combout\,
	datac => \ALT_INV_shift_num[2]~input_o\,
	combout => \FA1|GE0:1:FA0|Mux0~0_combout\);

-- Location: LABCELL_X73_Y80_N12
\FA1|GE0:0:FA0|Mux0~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:0:FA0|Mux0~4_combout\ = ( \shift_num[0]~input_o\ & ( \inp_br[3]~input_o\ & ( (!\shift_num[1]~input_o\) # (\inp_br[5]~input_o\) ) ) ) # ( !\shift_num[0]~input_o\ & ( \inp_br[3]~input_o\ & ( (!\shift_num[1]~input_o\ & ((\inp_br[2]~input_o\))) # 
-- (\shift_num[1]~input_o\ & (\inp_br[4]~input_o\)) ) ) ) # ( \shift_num[0]~input_o\ & ( !\inp_br[3]~input_o\ & ( (\shift_num[1]~input_o\ & \inp_br[5]~input_o\) ) ) ) # ( !\shift_num[0]~input_o\ & ( !\inp_br[3]~input_o\ & ( (!\shift_num[1]~input_o\ & 
-- ((\inp_br[2]~input_o\))) # (\shift_num[1]~input_o\ & (\inp_br[4]~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001110100011101000000000011001100011101000111011100110011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_inp_br[4]~input_o\,
	datab => \ALT_INV_shift_num[1]~input_o\,
	datac => \ALT_INV_inp_br[2]~input_o\,
	datad => \ALT_INV_inp_br[5]~input_o\,
	datae => \ALT_INV_shift_num[0]~input_o\,
	dataf => \ALT_INV_inp_br[3]~input_o\,
	combout => \FA1|GE0:0:FA0|Mux0~4_combout\);

-- Location: LABCELL_X73_Y80_N6
\FA1|GE0:0:FA0|Mux0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:0:FA0|Mux0~3_combout\ = ( \shift_num[0]~input_o\ & ( \inp_br[6]~input_o\ & ( (!\shift_num[1]~input_o\ & (\inp_br[7]~input_o\)) # (\shift_num[1]~input_o\ & ((\inp_br[1]~input_o\))) ) ) ) # ( !\shift_num[0]~input_o\ & ( \inp_br[6]~input_o\ & ( 
-- (!\shift_num[1]~input_o\) # (\inp_br[0]~input_o\) ) ) ) # ( \shift_num[0]~input_o\ & ( !\inp_br[6]~input_o\ & ( (!\shift_num[1]~input_o\ & (\inp_br[7]~input_o\)) # (\shift_num[1]~input_o\ & ((\inp_br[1]~input_o\))) ) ) ) # ( !\shift_num[0]~input_o\ & ( 
-- !\inp_br[6]~input_o\ & ( (\shift_num[1]~input_o\ & \inp_br[0]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001100000011010001000111011111001111110011110100010001110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_inp_br[7]~input_o\,
	datab => \ALT_INV_shift_num[1]~input_o\,
	datac => \ALT_INV_inp_br[0]~input_o\,
	datad => \ALT_INV_inp_br[1]~input_o\,
	datae => \ALT_INV_shift_num[0]~input_o\,
	dataf => \ALT_INV_inp_br[6]~input_o\,
	combout => \FA1|GE0:0:FA0|Mux0~3_combout\);

-- Location: MLABCELL_X72_Y80_N0
\FA1|GE0:2:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:2:FA0|Mux0~0_combout\ = ( \FA1|GE0:0:FA0|Mux0~3_combout\ & ( \shift_num[2]~input_o\ ) ) # ( \FA1|GE0:0:FA0|Mux0~3_combout\ & ( !\shift_num[2]~input_o\ & ( \FA1|GE0:0:FA0|Mux0~4_combout\ ) ) ) # ( !\FA1|GE0:0:FA0|Mux0~3_combout\ & ( 
-- !\shift_num[2]~input_o\ & ( \FA1|GE0:0:FA0|Mux0~4_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011001100110011001100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \FA1|GE0:0:FA0|ALT_INV_Mux0~4_combout\,
	datae => \FA1|GE0:0:FA0|ALT_INV_Mux0~3_combout\,
	dataf => \ALT_INV_shift_num[2]~input_o\,
	combout => \FA1|GE0:2:FA0|Mux0~0_combout\);

-- Location: LABCELL_X73_Y80_N18
\FA1|GE0:7:FA0|Mux0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:7:FA0|Mux0~2_combout\ = ( \shift_num[0]~input_o\ & ( \inp_br[7]~input_o\ & ( (!\shift_num[1]~input_o\ & (\inp_br[0]~input_o\)) # (\shift_num[1]~input_o\ & ((\inp_br[2]~input_o\))) ) ) ) # ( !\shift_num[0]~input_o\ & ( \inp_br[7]~input_o\ & ( 
-- (!\shift_num[1]~input_o\) # (\inp_br[1]~input_o\) ) ) ) # ( \shift_num[0]~input_o\ & ( !\inp_br[7]~input_o\ & ( (!\shift_num[1]~input_o\ & (\inp_br[0]~input_o\)) # (\shift_num[1]~input_o\ & ((\inp_br[2]~input_o\))) ) ) ) # ( !\shift_num[0]~input_o\ & ( 
-- !\inp_br[7]~input_o\ & ( (\shift_num[1]~input_o\ & \inp_br[1]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110011010001110100011111001100111111110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_inp_br[0]~input_o\,
	datab => \ALT_INV_shift_num[1]~input_o\,
	datac => \ALT_INV_inp_br[2]~input_o\,
	datad => \ALT_INV_inp_br[1]~input_o\,
	datae => \ALT_INV_shift_num[0]~input_o\,
	dataf => \ALT_INV_inp_br[7]~input_o\,
	combout => \FA1|GE0:7:FA0|Mux0~2_combout\);

-- Location: LABCELL_X73_Y80_N24
\FA1|GE0:7:FA0|Mux0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:7:FA0|Mux0~3_combout\ = ( \shift_num[0]~input_o\ & ( \inp_br[6]~input_o\ & ( (\inp_br[4]~input_o\) # (\shift_num[1]~input_o\) ) ) ) # ( !\shift_num[0]~input_o\ & ( \inp_br[6]~input_o\ & ( (!\shift_num[1]~input_o\ & (\inp_br[3]~input_o\)) # 
-- (\shift_num[1]~input_o\ & ((\inp_br[5]~input_o\))) ) ) ) # ( \shift_num[0]~input_o\ & ( !\inp_br[6]~input_o\ & ( (!\shift_num[1]~input_o\ & \inp_br[4]~input_o\) ) ) ) # ( !\shift_num[0]~input_o\ & ( !\inp_br[6]~input_o\ & ( (!\shift_num[1]~input_o\ & 
-- (\inp_br[3]~input_o\)) # (\shift_num[1]~input_o\ & ((\inp_br[5]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001001110111000010100000101000100010011101110101111101011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_shift_num[1]~input_o\,
	datab => \ALT_INV_inp_br[3]~input_o\,
	datac => \ALT_INV_inp_br[4]~input_o\,
	datad => \ALT_INV_inp_br[5]~input_o\,
	datae => \ALT_INV_shift_num[0]~input_o\,
	dataf => \ALT_INV_inp_br[6]~input_o\,
	combout => \FA1|GE0:7:FA0|Mux0~3_combout\);

-- Location: MLABCELL_X72_Y80_N9
\FA1|GE0:3:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:3:FA0|Mux0~0_combout\ = ( \shift_num[2]~input_o\ & ( \FA1|GE0:7:FA0|Mux0~2_combout\ ) ) # ( !\shift_num[2]~input_o\ & ( \FA1|GE0:7:FA0|Mux0~3_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100110011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \FA1|GE0:7:FA0|ALT_INV_Mux0~2_combout\,
	datac => \FA1|GE0:7:FA0|ALT_INV_Mux0~3_combout\,
	dataf => \ALT_INV_shift_num[2]~input_o\,
	combout => \FA1|GE0:3:FA0|Mux0~0_combout\);

-- Location: LABCELL_X73_Y80_N45
\FA1|GE0:4:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:4:FA0|Mux0~0_combout\ = (!\shift_num[2]~input_o\ & (\FA1|GE0:0:FA0|Mux0~0_combout\)) # (\shift_num[2]~input_o\ & ((\FA1|GE0:0:FA0|Mux0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001001110111001000100111011100100010011101110010001001110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_shift_num[2]~input_o\,
	datab => \FA1|GE0:0:FA0|ALT_INV_Mux0~0_combout\,
	datad => \FA1|GE0:0:FA0|ALT_INV_Mux0~1_combout\,
	combout => \FA1|GE0:4:FA0|Mux0~0_combout\);

-- Location: LABCELL_X73_Y80_N3
\FA1|GE0:5:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:5:FA0|Mux0~0_combout\ = (!\shift_num[2]~input_o\ & (\FA1|GE0:7:FA0|Mux0~0_combout\)) # (\shift_num[2]~input_o\ & ((\FA1|GE0:7:FA0|Mux0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010100110011010101010011001101010101001100110101010100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA1|GE0:7:FA0|ALT_INV_Mux0~0_combout\,
	datab => \FA1|GE0:7:FA0|ALT_INV_Mux0~1_combout\,
	datad => \ALT_INV_shift_num[2]~input_o\,
	combout => \FA1|GE0:5:FA0|Mux0~0_combout\);

-- Location: MLABCELL_X72_Y80_N45
\FA1|GE0:6:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:6:FA0|Mux0~0_combout\ = ( \FA1|GE0:0:FA0|Mux0~3_combout\ & ( \shift_num[2]~input_o\ & ( \FA1|GE0:0:FA0|Mux0~4_combout\ ) ) ) # ( !\FA1|GE0:0:FA0|Mux0~3_combout\ & ( \shift_num[2]~input_o\ & ( \FA1|GE0:0:FA0|Mux0~4_combout\ ) ) ) # ( 
-- \FA1|GE0:0:FA0|Mux0~3_combout\ & ( !\shift_num[2]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \FA1|GE0:0:FA0|ALT_INV_Mux0~4_combout\,
	datae => \FA1|GE0:0:FA0|ALT_INV_Mux0~3_combout\,
	dataf => \ALT_INV_shift_num[2]~input_o\,
	combout => \FA1|GE0:6:FA0|Mux0~0_combout\);

-- Location: MLABCELL_X72_Y80_N48
\FA1|GE0:7:FA0|Mux0~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|GE0:7:FA0|Mux0~4_combout\ = ( \shift_num[2]~input_o\ & ( \FA1|GE0:7:FA0|Mux0~3_combout\ ) ) # ( !\shift_num[2]~input_o\ & ( \FA1|GE0:7:FA0|Mux0~2_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100110011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \FA1|GE0:7:FA0|ALT_INV_Mux0~3_combout\,
	datad => \FA1|GE0:7:FA0|ALT_INV_Mux0~2_combout\,
	dataf => \ALT_INV_shift_num[2]~input_o\,
	combout => \FA1|GE0:7:FA0|Mux0~4_combout\);

-- Location: IOIBUF_X70_Y81_N35
\inp_bl[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(1),
	o => \inp_bl[1]~input_o\);

-- Location: IOIBUF_X66_Y81_N41
\inp_bl[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(4),
	o => \inp_bl[4]~input_o\);

-- Location: IOIBUF_X66_Y81_N58
\inp_bl[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(3),
	o => \inp_bl[3]~input_o\);

-- Location: IOIBUF_X70_Y81_N52
\inp_bl[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(2),
	o => \inp_bl[2]~input_o\);

-- Location: LABCELL_X71_Y80_N30
\FA0|GE0:0:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:0:FA0|Mux0~0_combout\ = ( \inp_bl[3]~input_o\ & ( \inp_bl[2]~input_o\ & ( (!\shift_num[1]~input_o\ & (((\shift_num[0]~input_o\) # (\inp_bl[4]~input_o\)))) # (\shift_num[1]~input_o\ & (((!\shift_num[0]~input_o\)) # (\inp_bl[1]~input_o\))) ) ) ) # 
-- ( !\inp_bl[3]~input_o\ & ( \inp_bl[2]~input_o\ & ( (!\shift_num[1]~input_o\ & (((\inp_bl[4]~input_o\ & !\shift_num[0]~input_o\)))) # (\shift_num[1]~input_o\ & (((!\shift_num[0]~input_o\)) # (\inp_bl[1]~input_o\))) ) ) ) # ( \inp_bl[3]~input_o\ & ( 
-- !\inp_bl[2]~input_o\ & ( (!\shift_num[1]~input_o\ & (((\shift_num[0]~input_o\) # (\inp_bl[4]~input_o\)))) # (\shift_num[1]~input_o\ & (\inp_bl[1]~input_o\ & ((\shift_num[0]~input_o\)))) ) ) ) # ( !\inp_bl[3]~input_o\ & ( !\inp_bl[2]~input_o\ & ( 
-- (!\shift_num[1]~input_o\ & (((\inp_bl[4]~input_o\ & !\shift_num[0]~input_o\)))) # (\shift_num[1]~input_o\ & (\inp_bl[1]~input_o\ & ((\shift_num[0]~input_o\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011000000000101001100001111010100111111000001010011111111110101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_inp_bl[1]~input_o\,
	datab => \ALT_INV_inp_bl[4]~input_o\,
	datac => \ALT_INV_shift_num[1]~input_o\,
	datad => \ALT_INV_shift_num[0]~input_o\,
	datae => \ALT_INV_inp_bl[3]~input_o\,
	dataf => \ALT_INV_inp_bl[2]~input_o\,
	combout => \FA0|GE0:0:FA0|Mux0~0_combout\);

-- Location: IOIBUF_X74_Y81_N92
\inp_bl[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(6),
	o => \inp_bl[6]~input_o\);

-- Location: IOIBUF_X64_Y81_N35
\inp_bl[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(7),
	o => \inp_bl[7]~input_o\);

-- Location: IOIBUF_X68_Y81_N18
\inp_bl[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(5),
	o => \inp_bl[5]~input_o\);

-- Location: IOIBUF_X66_Y81_N75
\inp_bl[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_bl(0),
	o => \inp_bl[0]~input_o\);

-- Location: LABCELL_X71_Y80_N36
\FA0|GE0:0:FA0|Mux0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:0:FA0|Mux0~1_combout\ = ( \shift_num[1]~input_o\ & ( \shift_num[0]~input_o\ & ( \inp_bl[5]~input_o\ ) ) ) # ( !\shift_num[1]~input_o\ & ( \shift_num[0]~input_o\ & ( \inp_bl[7]~input_o\ ) ) ) # ( \shift_num[1]~input_o\ & ( !\shift_num[0]~input_o\ 
-- & ( \inp_bl[6]~input_o\ ) ) ) # ( !\shift_num[1]~input_o\ & ( !\shift_num[0]~input_o\ & ( \inp_bl[0]~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111010101010101010100110011001100110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_inp_bl[6]~input_o\,
	datab => \ALT_INV_inp_bl[7]~input_o\,
	datac => \ALT_INV_inp_bl[5]~input_o\,
	datad => \ALT_INV_inp_bl[0]~input_o\,
	datae => \ALT_INV_shift_num[1]~input_o\,
	dataf => \ALT_INV_shift_num[0]~input_o\,
	combout => \FA0|GE0:0:FA0|Mux0~1_combout\);

-- Location: MLABCELL_X72_Y80_N54
\FA0|GE0:0:FA0|Mux0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:0:FA0|Mux0~2_combout\ = ( \shift_num[2]~input_o\ & ( \FA0|GE0:0:FA0|Mux0~0_combout\ ) ) # ( !\shift_num[2]~input_o\ & ( \FA0|GE0:0:FA0|Mux0~1_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111101010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA0|GE0:0:FA0|ALT_INV_Mux0~0_combout\,
	datac => \FA0|GE0:0:FA0|ALT_INV_Mux0~1_combout\,
	dataf => \ALT_INV_shift_num[2]~input_o\,
	combout => \FA0|GE0:0:FA0|Mux0~2_combout\);

-- Location: LABCELL_X71_Y80_N42
\FA0|GE0:7:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:7:FA0|Mux0~0_combout\ = ( \inp_bl[3]~input_o\ & ( \inp_bl[2]~input_o\ & ( ((!\shift_num[0]~input_o\ & ((\inp_bl[5]~input_o\))) # (\shift_num[0]~input_o\ & (\inp_bl[4]~input_o\))) # (\shift_num[1]~input_o\) ) ) ) # ( !\inp_bl[3]~input_o\ & ( 
-- \inp_bl[2]~input_o\ & ( (!\shift_num[1]~input_o\ & ((!\shift_num[0]~input_o\ & ((\inp_bl[5]~input_o\))) # (\shift_num[0]~input_o\ & (\inp_bl[4]~input_o\)))) # (\shift_num[1]~input_o\ & (((\shift_num[0]~input_o\)))) ) ) ) # ( \inp_bl[3]~input_o\ & ( 
-- !\inp_bl[2]~input_o\ & ( (!\shift_num[1]~input_o\ & ((!\shift_num[0]~input_o\ & ((\inp_bl[5]~input_o\))) # (\shift_num[0]~input_o\ & (\inp_bl[4]~input_o\)))) # (\shift_num[1]~input_o\ & (((!\shift_num[0]~input_o\)))) ) ) ) # ( !\inp_bl[3]~input_o\ & ( 
-- !\inp_bl[2]~input_o\ & ( (!\shift_num[1]~input_o\ & ((!\shift_num[0]~input_o\ & ((\inp_bl[5]~input_o\))) # (\shift_num[0]~input_o\ & (\inp_bl[4]~input_o\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000101000100010010111110010001000001010011101110101111101110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_shift_num[1]~input_o\,
	datab => \ALT_INV_inp_bl[4]~input_o\,
	datac => \ALT_INV_inp_bl[5]~input_o\,
	datad => \ALT_INV_shift_num[0]~input_o\,
	datae => \ALT_INV_inp_bl[3]~input_o\,
	dataf => \ALT_INV_inp_bl[2]~input_o\,
	combout => \FA0|GE0:7:FA0|Mux0~0_combout\);

-- Location: LABCELL_X71_Y80_N48
\FA0|GE0:7:FA0|Mux0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:7:FA0|Mux0~1_combout\ = ( \shift_num[1]~input_o\ & ( \shift_num[0]~input_o\ & ( \inp_bl[6]~input_o\ ) ) ) # ( !\shift_num[1]~input_o\ & ( \shift_num[0]~input_o\ & ( \inp_bl[0]~input_o\ ) ) ) # ( \shift_num[1]~input_o\ & ( !\shift_num[0]~input_o\ 
-- & ( \inp_bl[7]~input_o\ ) ) ) # ( !\shift_num[1]~input_o\ & ( !\shift_num[0]~input_o\ & ( \inp_bl[1]~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111001100110011001100000000111111110101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_inp_bl[6]~input_o\,
	datab => \ALT_INV_inp_bl[7]~input_o\,
	datac => \ALT_INV_inp_bl[1]~input_o\,
	datad => \ALT_INV_inp_bl[0]~input_o\,
	datae => \ALT_INV_shift_num[1]~input_o\,
	dataf => \ALT_INV_shift_num[0]~input_o\,
	combout => \FA0|GE0:7:FA0|Mux0~1_combout\);

-- Location: LABCELL_X71_Y80_N54
\FA0|GE0:1:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:1:FA0|Mux0~0_combout\ = ( \FA0|GE0:7:FA0|Mux0~1_combout\ & ( (!\shift_num[2]~input_o\) # (\FA0|GE0:7:FA0|Mux0~0_combout\) ) ) # ( !\FA0|GE0:7:FA0|Mux0~1_combout\ & ( (\shift_num[2]~input_o\ & \FA0|GE0:7:FA0|Mux0~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000100010001000100010001000110111011101110111011101110111011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_shift_num[2]~input_o\,
	datab => \FA0|GE0:7:FA0|ALT_INV_Mux0~0_combout\,
	dataf => \FA0|GE0:7:FA0|ALT_INV_Mux0~1_combout\,
	combout => \FA0|GE0:1:FA0|Mux0~0_combout\);

-- Location: LABCELL_X71_Y80_N6
\FA0|GE0:0:FA0|Mux0~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:0:FA0|Mux0~4_combout\ = ( \shift_num[1]~input_o\ & ( \shift_num[0]~input_o\ & ( \inp_bl[7]~input_o\ ) ) ) # ( !\shift_num[1]~input_o\ & ( \shift_num[0]~input_o\ & ( \inp_bl[1]~input_o\ ) ) ) # ( \shift_num[1]~input_o\ & ( !\shift_num[0]~input_o\ 
-- & ( \inp_bl[0]~input_o\ ) ) ) # ( !\shift_num[1]~input_o\ & ( !\shift_num[0]~input_o\ & ( \inp_bl[2]~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101000000001111111100001111000011110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_inp_bl[2]~input_o\,
	datab => \ALT_INV_inp_bl[7]~input_o\,
	datac => \ALT_INV_inp_bl[1]~input_o\,
	datad => \ALT_INV_inp_bl[0]~input_o\,
	datae => \ALT_INV_shift_num[1]~input_o\,
	dataf => \ALT_INV_shift_num[0]~input_o\,
	combout => \FA0|GE0:0:FA0|Mux0~4_combout\);

-- Location: LABCELL_X71_Y80_N0
\FA0|GE0:0:FA0|Mux0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:0:FA0|Mux0~3_combout\ = ( \inp_bl[3]~input_o\ & ( \inp_bl[6]~input_o\ & ( (!\shift_num[1]~input_o\ & (((!\shift_num[0]~input_o\) # (\inp_bl[5]~input_o\)))) # (\shift_num[1]~input_o\ & (((\shift_num[0]~input_o\)) # (\inp_bl[4]~input_o\))) ) ) ) # 
-- ( !\inp_bl[3]~input_o\ & ( \inp_bl[6]~input_o\ & ( (!\shift_num[1]~input_o\ & (((!\shift_num[0]~input_o\) # (\inp_bl[5]~input_o\)))) # (\shift_num[1]~input_o\ & (\inp_bl[4]~input_o\ & ((!\shift_num[0]~input_o\)))) ) ) ) # ( \inp_bl[3]~input_o\ & ( 
-- !\inp_bl[6]~input_o\ & ( (!\shift_num[1]~input_o\ & (((\inp_bl[5]~input_o\ & \shift_num[0]~input_o\)))) # (\shift_num[1]~input_o\ & (((\shift_num[0]~input_o\)) # (\inp_bl[4]~input_o\))) ) ) ) # ( !\inp_bl[3]~input_o\ & ( !\inp_bl[6]~input_o\ & ( 
-- (!\shift_num[1]~input_o\ & (((\inp_bl[5]~input_o\ & \shift_num[0]~input_o\)))) # (\shift_num[1]~input_o\ & (\inp_bl[4]~input_o\ & ((!\shift_num[0]~input_o\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000100001010000100010101111110111011000010101011101101011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_shift_num[1]~input_o\,
	datab => \ALT_INV_inp_bl[4]~input_o\,
	datac => \ALT_INV_inp_bl[5]~input_o\,
	datad => \ALT_INV_shift_num[0]~input_o\,
	datae => \ALT_INV_inp_bl[3]~input_o\,
	dataf => \ALT_INV_inp_bl[6]~input_o\,
	combout => \FA0|GE0:0:FA0|Mux0~3_combout\);

-- Location: LABCELL_X71_Y80_N12
\FA0|GE0:2:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:2:FA0|Mux0~0_combout\ = (!\shift_num[2]~input_o\ & (\FA0|GE0:0:FA0|Mux0~4_combout\)) # (\shift_num[2]~input_o\ & ((\FA0|GE0:0:FA0|Mux0~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011000000111111001100000011111100110000001111110011000000111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \FA0|GE0:0:FA0|ALT_INV_Mux0~4_combout\,
	datac => \ALT_INV_shift_num[2]~input_o\,
	datad => \FA0|GE0:0:FA0|ALT_INV_Mux0~3_combout\,
	combout => \FA0|GE0:2:FA0|Mux0~0_combout\);

-- Location: LABCELL_X71_Y80_N18
\FA0|GE0:7:FA0|Mux0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:7:FA0|Mux0~2_combout\ = ( \shift_num[1]~input_o\ & ( \shift_num[0]~input_o\ & ( \inp_bl[4]~input_o\ ) ) ) # ( !\shift_num[1]~input_o\ & ( \shift_num[0]~input_o\ & ( \inp_bl[6]~input_o\ ) ) ) # ( \shift_num[1]~input_o\ & ( !\shift_num[0]~input_o\ 
-- & ( \inp_bl[5]~input_o\ ) ) ) # ( !\shift_num[1]~input_o\ & ( !\shift_num[0]~input_o\ & ( \inp_bl[7]~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011000011110000111101010101010101010000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_inp_bl[6]~input_o\,
	datab => \ALT_INV_inp_bl[7]~input_o\,
	datac => \ALT_INV_inp_bl[5]~input_o\,
	datad => \ALT_INV_inp_bl[4]~input_o\,
	datae => \ALT_INV_shift_num[1]~input_o\,
	dataf => \ALT_INV_shift_num[0]~input_o\,
	combout => \FA0|GE0:7:FA0|Mux0~2_combout\);

-- Location: LABCELL_X71_Y80_N24
\FA0|GE0:7:FA0|Mux0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:7:FA0|Mux0~3_combout\ = ( \inp_bl[3]~input_o\ & ( \inp_bl[2]~input_o\ & ( (!\shift_num[1]~input_o\) # ((!\shift_num[0]~input_o\ & (\inp_bl[1]~input_o\)) # (\shift_num[0]~input_o\ & ((\inp_bl[0]~input_o\)))) ) ) ) # ( !\inp_bl[3]~input_o\ & ( 
-- \inp_bl[2]~input_o\ & ( (!\shift_num[1]~input_o\ & (((\shift_num[0]~input_o\)))) # (\shift_num[1]~input_o\ & ((!\shift_num[0]~input_o\ & (\inp_bl[1]~input_o\)) # (\shift_num[0]~input_o\ & ((\inp_bl[0]~input_o\))))) ) ) ) # ( \inp_bl[3]~input_o\ & ( 
-- !\inp_bl[2]~input_o\ & ( (!\shift_num[1]~input_o\ & (((!\shift_num[0]~input_o\)))) # (\shift_num[1]~input_o\ & ((!\shift_num[0]~input_o\ & (\inp_bl[1]~input_o\)) # (\shift_num[0]~input_o\ & ((\inp_bl[0]~input_o\))))) ) ) ) # ( !\inp_bl[3]~input_o\ & ( 
-- !\inp_bl[2]~input_o\ & ( (\shift_num[1]~input_o\ & ((!\shift_num[0]~input_o\ & (\inp_bl[1]~input_o\)) # (\shift_num[0]~input_o\ & ((\inp_bl[0]~input_o\))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010100000011111101010000001100000101111100111111010111110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_inp_bl[1]~input_o\,
	datab => \ALT_INV_inp_bl[0]~input_o\,
	datac => \ALT_INV_shift_num[1]~input_o\,
	datad => \ALT_INV_shift_num[0]~input_o\,
	datae => \ALT_INV_inp_bl[3]~input_o\,
	dataf => \ALT_INV_inp_bl[2]~input_o\,
	combout => \FA0|GE0:7:FA0|Mux0~3_combout\);

-- Location: MLABCELL_X72_Y80_N30
\FA0|GE0:3:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:3:FA0|Mux0~0_combout\ = ( \shift_num[2]~input_o\ & ( \FA0|GE0:7:FA0|Mux0~2_combout\ ) ) # ( !\shift_num[2]~input_o\ & ( \FA0|GE0:7:FA0|Mux0~3_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100110011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \FA0|GE0:7:FA0|ALT_INV_Mux0~2_combout\,
	datad => \FA0|GE0:7:FA0|ALT_INV_Mux0~3_combout\,
	dataf => \ALT_INV_shift_num[2]~input_o\,
	combout => \FA0|GE0:3:FA0|Mux0~0_combout\);

-- Location: MLABCELL_X72_Y80_N39
\FA0|GE0:4:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:4:FA0|Mux0~0_combout\ = ( \shift_num[2]~input_o\ & ( \FA0|GE0:0:FA0|Mux0~1_combout\ ) ) # ( !\shift_num[2]~input_o\ & ( \FA0|GE0:0:FA0|Mux0~0_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111101010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA0|GE0:0:FA0|ALT_INV_Mux0~1_combout\,
	datad => \FA0|GE0:0:FA0|ALT_INV_Mux0~0_combout\,
	dataf => \ALT_INV_shift_num[2]~input_o\,
	combout => \FA0|GE0:4:FA0|Mux0~0_combout\);

-- Location: LABCELL_X71_Y80_N57
\FA0|GE0:5:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:5:FA0|Mux0~0_combout\ = ( \FA0|GE0:7:FA0|Mux0~1_combout\ & ( (\FA0|GE0:7:FA0|Mux0~0_combout\) # (\shift_num[2]~input_o\) ) ) # ( !\FA0|GE0:7:FA0|Mux0~1_combout\ & ( (!\shift_num[2]~input_o\ & \FA0|GE0:7:FA0|Mux0~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001000100010001000100010001001110111011101110111011101110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_shift_num[2]~input_o\,
	datab => \FA0|GE0:7:FA0|ALT_INV_Mux0~0_combout\,
	dataf => \FA0|GE0:7:FA0|ALT_INV_Mux0~1_combout\,
	combout => \FA0|GE0:5:FA0|Mux0~0_combout\);

-- Location: LABCELL_X71_Y80_N15
\FA0|GE0:6:FA0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:6:FA0|Mux0~0_combout\ = (!\shift_num[2]~input_o\ & ((\FA0|GE0:0:FA0|Mux0~3_combout\))) # (\shift_num[2]~input_o\ & (\FA0|GE0:0:FA0|Mux0~4_combout\))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000110111011000100011011101100010001101110110001000110111011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_shift_num[2]~input_o\,
	datab => \FA0|GE0:0:FA0|ALT_INV_Mux0~4_combout\,
	datad => \FA0|GE0:0:FA0|ALT_INV_Mux0~3_combout\,
	combout => \FA0|GE0:6:FA0|Mux0~0_combout\);

-- Location: MLABCELL_X72_Y80_N15
\FA0|GE0:7:FA0|Mux0~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|GE0:7:FA0|Mux0~4_combout\ = ( \shift_num[2]~input_o\ & ( \FA0|GE0:7:FA0|Mux0~3_combout\ ) ) # ( !\shift_num[2]~input_o\ & ( \FA0|GE0:7:FA0|Mux0~2_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100110011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \FA0|GE0:7:FA0|ALT_INV_Mux0~3_combout\,
	datac => \FA0|GE0:7:FA0|ALT_INV_Mux0~2_combout\,
	dataf => \ALT_INV_shift_num[2]~input_o\,
	combout => \FA0|GE0:7:FA0|Mux0~4_combout\);

-- Location: IOIBUF_X68_Y81_N35
\inp_r[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(5),
	o => \inp_r[5]~input_o\);

-- Location: IOIBUF_X58_Y81_N75
\inp_r[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(6),
	o => \inp_r[6]~input_o\);

-- Location: IOIBUF_X62_Y81_N18
\inp_r[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(7),
	o => \inp_r[7]~input_o\);

-- Location: IOIBUF_X52_Y81_N18
\inp_r[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(8),
	o => \inp_r[8]~input_o\);

-- Location: IOIBUF_X86_Y81_N18
\inp_r[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(9),
	o => \inp_r[9]~input_o\);

-- Location: IOIBUF_X82_Y81_N92
\inp_r[10]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(10),
	o => \inp_r[10]~input_o\);

-- Location: IOIBUF_X60_Y81_N52
\inp_r[11]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(11),
	o => \inp_r[11]~input_o\);

-- Location: IOIBUF_X30_Y81_N1
\inp_r[12]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(12),
	o => \inp_r[12]~input_o\);

-- Location: IOIBUF_X52_Y81_N1
\inp_r[13]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(13),
	o => \inp_r[13]~input_o\);

-- Location: IOIBUF_X36_Y81_N18
\inp_r[14]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(14),
	o => \inp_r[14]~input_o\);

-- Location: IOIBUF_X50_Y81_N92
\inp_r[15]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(15),
	o => \inp_r[15]~input_o\);

-- Location: IOIBUF_X38_Y81_N18
\inp_l[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(0),
	o => \inp_l[0]~input_o\);

-- Location: IOIBUF_X26_Y81_N92
\inp_l[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(1),
	o => \inp_l[1]~input_o\);

-- Location: IOIBUF_X32_Y81_N1
\inp_l[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(2),
	o => \inp_l[2]~input_o\);

-- Location: IOIBUF_X40_Y81_N52
\inp_l[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(3),
	o => \inp_l[3]~input_o\);

-- Location: IOIBUF_X56_Y81_N52
\inp_l[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(4),
	o => \inp_l[4]~input_o\);

-- Location: IOIBUF_X30_Y81_N52
\inp_l[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(5),
	o => \inp_l[5]~input_o\);

-- Location: IOIBUF_X86_Y81_N35
\inp_l[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(6),
	o => \inp_l[6]~input_o\);

-- Location: IOIBUF_X58_Y81_N92
\inp_l[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(7),
	o => \inp_l[7]~input_o\);

-- Location: IOIBUF_X88_Y81_N2
\inp_l[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(8),
	o => \inp_l[8]~input_o\);

-- Location: IOIBUF_X28_Y81_N18
\inp_l[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(9),
	o => \inp_l[9]~input_o\);

-- Location: IOIBUF_X54_Y81_N35
\inp_l[10]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(10),
	o => \inp_l[10]~input_o\);

-- Location: IOIBUF_X54_Y81_N52
\inp_r[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(0),
	o => \inp_r[0]~input_o\);

-- Location: IOIBUF_X62_Y81_N35
\inp_r[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(1),
	o => \inp_r[1]~input_o\);

-- Location: IOIBUF_X36_Y0_N1
\inp_r[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(2),
	o => \inp_r[2]~input_o\);

-- Location: IOIBUF_X70_Y0_N52
\inp_r[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(3),
	o => \inp_r[3]~input_o\);

-- Location: IOIBUF_X32_Y81_N18
\inp_r[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_r(4),
	o => \inp_r[4]~input_o\);

-- Location: IOIBUF_X62_Y0_N52
\inp_l[11]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(11),
	o => \inp_l[11]~input_o\);

-- Location: IOIBUF_X6_Y0_N1
\inp_l[12]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(12),
	o => \inp_l[12]~input_o\);

-- Location: IOIBUF_X34_Y0_N58
\inp_l[13]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(13),
	o => \inp_l[13]~input_o\);

-- Location: IOIBUF_X64_Y0_N1
\inp_l[14]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(14),
	o => \inp_l[14]~input_o\);

-- Location: IOIBUF_X60_Y81_N35
\inp_l[15]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inp_l(15),
	o => \inp_l[15]~input_o\);

-- Location: IOIBUF_X89_Y37_N4
\shift_num[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_shift_num(3),
	o => \shift_num[3]~input_o\);

-- Location: LABCELL_X71_Y67_N0
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


