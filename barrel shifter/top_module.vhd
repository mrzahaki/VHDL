--	W T A
--
-- brief: top module used shifter package (see work.shift.vhd)
--
-- designed by hussein zahaki


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.shift.all;

entity barrelshifter is 
generic(
	shift_val : integer :=5
);
port(
	inp_br	:in std_logic_vector(7 downto 0);
	inp_bl	:in std_logic_vector(7 downto 0);
	inp_r	:in std_logic_vector(15 downto 0);
	inp_l	:in std_logic_vector(15 downto 0);
	shift_num :in std_logic_vector(3 downto 0 );
	
	out_br	:out std_logic_vector(7 downto 0);
	out_bl	:out std_logic_vector(7 downto 0);
	out_r	:out std_logic_vector(15 downto 0);
	out_l	:out std_logic_vector(15 downto 0)
);
end barrelshifter;

architecture structural of barrelshifter is

begin

FA0: std_blshift Port map( 	
			inp_bl, 		
			to_integer(unsigned(shift_num)),
			out_bl
);

                      
FA1: std_brshift Port map( 	
			inp_br, 		
			to_integer(unsigned(shift_num)),
			out_br
);


	out_r <= rshift(inp_r, shift_val);
	out_l <= lshift(inp_l, shift_val);


end structural;
----------------------------------------------------------------------------------------------------------------
