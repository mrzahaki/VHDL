-----------------------------------------------------------------------------------------------
--	in the name of ALLAH
--
--
--
--brief			: 	sign magnitude adder
--version 		:	vhdl 1993
--dependencies	:	work.config and work.tools
--
--param inp	: is the input parameter and it is an array containing the numbers to be added.
--note		: this adder is an selectable m bit, sign magnitude adder with n inputs.
--note		: you can change m and n parameters (described above) in config.vhd with sm_adder_io_width and sm_adder_io_numbers constants.
-- 
--note	: sm_adder_io_width is an user define constant that it's placed on config.vhd file, with control this value you can change the length of the input vectors(sm_adder_io_type)
--note	: sm_adder_io_numbers is an user define constant that it's placed on config.vhd file, with control this value you can You can change the number of input vectors.(sm_adder_io_numbers)
--  
--param outp	: is the output, and it is an number of type sm_adder_io_type(defined in config.vhd).
--
--
-- designed by hussein zahaki
-----------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.config.all;


entity sm_adder is 
port(
	inp	:in sm_adder_vector;--defined in config.vhd
	outp	:out sm_adder_io_type--defined in config.vhd

);
end sm_adder;

architecture structural of sm_adder is

signal sig :sm_adder_vector;

begin

	FA0: sub_sm_adder port map(inp(1),inp(2),sig(1));
	LOOP11: for i in 1  to ( sm_adder_io_numbers - 2 ) generate
		FA1: sub_sm_adder port map(sig(i),inp(i + 2),sig(i + 1));		
	end generate;

	assert sm_adder_io_numbers > 1 report "the number of input lines must be greater than 1" severity error;
	assert sm_adder_io_width > 0 report "the width of each line must be greater than 0" severity error;
	
	outp <= sig(sm_adder_io_numbers -1);

end structural;
----------------------------------------------------------------------------------------------------------------

