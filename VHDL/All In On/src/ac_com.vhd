----------------------------------------------------------------------------------
--the name of allah
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2020 11:04:17 AM
-- Design Name: 
-- Module Name: ac_com - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

USE work.std_keypad.ALL;
USE work.std_ac.ALL;

entity ac_com is
  generic(
		clock_frequency	: INTEGER := 10e6
); Port (
	clk,nrst :IN STD_LOGiC;
	--main nodes
	--KEYPAD
	inp_row	:IN keypad_row_vector;
	out_col	:OUT keypad_col_vector;
	
	-- uart com
	-- i_RX_Serial : IN 	STD_LOGIC;
	-- o_TX_Serial : OUT	STD_LOGIC;
	 
	C_READY		:OUT STD_LOGIC ;
	C_VALID		:IN STD_LOGIC ;
	C_DATA_IN	:IN COM_BUS_TYPEDEF;
	C_DATA_OUT	:OUT COM_BUS_TYPEDEF
  );
end ac_com;

architecture Behavioral of ac_com is
	
	SIGNAL keypad_ready : STD_LOGIC ;
	SIGNAL keypad_res	: CHARACTER ;

begin
		FA0: keypad generic map( clock_frequency )port map(
		 inp_rows	=>	inp_row,
		 clk 		=> 	clk,
		 nrst		=>  nrst,
		 out_cols	=>  out_col,
		 ready		=>  keypad_ready,
		 res		=>  keypad_res
	);




end Behavioral;
