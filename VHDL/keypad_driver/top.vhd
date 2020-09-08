--	in the name of ALLAH
--
-- brief: keypad driver
--	param inp_rows: is the input parameter 
-- param out_cols: is the output to keypad columns.
--
-- please see std_keypad.vhd and shift.vhd files
--
--
-- designed by hussein zahaki


library ieee;
use ieee.std_logic_1164.all;
use work.std_keypad.all;


entity keypad_driver is 
port(
	inp_row	:in keypad_row_vector;--defined in config.vhd
	clk		:in std_logic;
	inp_col	:out keypad_col_vector;--defined in config.vhd
	outp		:out character		--just used in simulation

);
end keypad_driver;

architecture structural of keypad_driver is

begin

--start to handle keypad
--note: you can convert the out put caracter into std logic or integers(search for 'vhdl character to std_logic_vector')
FA0: keypad port map(inp_row, clk, inp_col, outp);--see std_keypad.vhd

end structural;
----------------------------------------------------------------------------------------------------------------

