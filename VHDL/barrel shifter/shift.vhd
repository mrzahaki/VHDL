--------------------------------------------------------------------------------
--					in the name of allah
--
--
--
--
--		designer: hussein zahaki
--   	FileName:         shift.vhd
--   	Dependencies:     work.std_mux and std_logic_1164 and std_logic_unsigned 
--		version: vhdl 2008(important)
--
--
--   	brief: the shift package contains functions and components that they perform sifting operations, such as bi-directional synthesizable  barrel shifters(left to right and vice versa) and bi-directional normal shiters just same as barrel shifters.
--		important note: left and right directions are valid for (n downto m) descending type operations note that for ascending type range the shift directions are reversed
--		
--		note: All functions and components are designed so that the number of bits in the input lines is flexible.
--  	note: as described above you can change the number of input line's bits with generic ports in defined components. 
--		
--		components:	
--					- std_brshift	standard barrel right shifter		(note shift number can be a variable argument)(synthesizable)
--					- std_blshift	standard barrel left shifter		(note shift number can be a variable argument)(synthesizable)
--		 
--		functions:
--					-brshift		barrel right shifter	(note shift number must be a constant argument)(synthesizable)
--					-blshift		barrel left shifter	(note shift number must be a constant argument)(synthesizable)
--   				-lshift		normal right shift	(note shift number must be a constant argument)(synthesizable)
--					-rshift		normal right shift	(note shift number must be a constant argument)(synthesizable)
--
-- 
-- 
--
-- 
-- 	useful functions:				
--					-gen_range				The gen_range function returns a sequence of numbers, starting from lower parameter, and increments by 1 , and stops before a specified number called higher.			
-- 				-gen_blshift_array	This function produces an array in which each element shifts(with blshift) relative to the previous index.	
--					-gen_brshift_array	This function produces an array in which each element shifts(with brshift) relative to the previous index.	
-- 
-- 
--
-- 
--
-- 
--
-- 
--
-- 
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--config package 
package shift is 



--type integer_vector is  array (NATURAL range <>) of integer ; --vhdl 2008
type integer_vector_array is  array (NATURAL range <>) of integer_vector ;
----------------------------------------------------function definition

--brief: barrel right shifter
--
--param inp:  that takes input vector
--param shift_num:  determines number of shifts and must be a constant value
--
--ex: (inp)"10100011"(std_logic_vector 7 downto 0) >>> 3(shift_num) : result= "01110100"
--
--dsigned by hussein zahaki


FUNCTION brshift  ( inp : std_logic_vector;	 shift_num :integer range 0 to 32 ) RETURN std_logic_vector;
FUNCTION brshift  ( inp : integer_vector; 	 shift_num :integer range 0 to 32 ) RETURN integer_vector ;

--brief: simple right shifter
--
--param inp:  that takes input vector
--param shift_num:  determines number of shifts and must be a constant value
--
--ex: "10100011"(std_logic_vector) >>> 3 : result= "00010100"


FUNCTION rshift  ( inp : std_logic_vector;	 shift_num :integer range 0 to 32 ) RETURN std_logic_vector;

--brief: barrel left shifter
--param inp:  that takes input vector
--param shift_num:  determines number of shifts and must be a constant value


FUNCTION blshift  ( inp : std_logic_vector; 	 shift_num :integer range 0 to 32 ) RETURN std_logic_vector;
FUNCTION blshift  ( 	inp : integer_vector; 	shift_num :integer range 0 to 32 ) RETURN integer_vector;

--brief: simple left shifter
--param inp:  that takes input vector
--param shift_num:  determines number of shifts and must be a constant value


FUNCTION lshift  ( inp : std_logic_vector; 	 shift_num :integer range 0 to 32 ) RETURN std_logic_vector;


--The gen_range function returns a sequence of numbers, starting from lower parameter, and increments by 1 , and stops before a specified number called higher.
--
--param lower	:  An integer number specifying at which position to start. 
--param higher :	An integer number specifying at which position to stop.
--retval			:	is an integer_vector: (array of integers) 
--note			: 	output lowest number put on index 0 and high number put on higher index 
--ex: gen_range(10,15) retval is (integer_vector 4 downto 0)(14, 13, 12, 11, 10)

FUNCTION gen_range  ( lower: integer; higher:integer) RETURN integer_vector;

--brief					:	This function produces an array in which each element shifts relative to the previous index.
--param inp				:	input reference vector.
--param array_length	:	length of output array.
--param shift_number	:	number of shift that the gen_blshift_array, shifts the inp parameter in final result acording to this number.
--
--ex: inp : (1,2,3,4,5,6,7,8,9)<integer_vector>, array_length: 5(integer), shift_number: 2(integer)
-- retval: ( (1,2,3,4,5,6,7,8,9), (3,4,5,6,7,8,9,1,2), (5,6,7,8,9,1,2,3,4), (7,8,9,1,2,3,4,5,6), (9,1,2,3,4,5,6,7,8) )<integer_vector_array 4 downto 0>
--                      index0					index1					index2					index3					index4 
--
FUNCTION gen_blshift_array  ( inp : integer_vector; array_length : integer; shift_number : integer) RETURN integer_vector_array ;


--brief					:	This function produces an array in which each element shifts relative to the previous index.
--param inp				:	input reference vector.
--param array_length	:	length of output array.
--param shift_number	:	number of shift that the gen_blshift_array, shifts the inp parameter in final result acording to this number.
--
--ex: inp : (1,2,3,4,5,6,7,8,9)<integer_vector>, array_length: 5(integer), shift_number: 2(integer)
-- return value: ( (1,2,3,4,5,6,7,8,9), (8,9,1,2,3,4,5,6,7), (6,7,8,9,1,2,3,4,5), (4,5,6,7,8,9,1,2,3), (2,3,4,5,6,7,8,9,1) )<integer_vector_array>
--                      index0					index1					index2					index3					index4
-- 
--
FUNCTION gen_brshift_array  ( inp : integer_vector; array_length : integer; shift_number : integer) RETURN integer_vector_array ;

-----------------------------------------------------------------------------------------------------------------------------------------component
--brief: barrel left shifter
--
--param inp:  that takes input vector
--param shift_num:  determines number of shifts and you can freely change its value(variable parameter)(non constant)
--
component std_blshift 

generic(
	shifter_size 	:integer := 8 --8bit shifter default 

);
Port( 	
			inp 			:in  std_logic_vector( (shifter_size-1) downto 0); 		
			shift_num 	:in  integer range 0 to inp'high;
			outp 			:out std_logic_vector( (shifter_size-1) downto 0)
);
                        
end component;

----------------------------------------------------------------------
--brief: barrel right shifter
--
--param inp:  that takes input vector
--param shift_num:  determines number of shifts and you can freely change its value(variable parameter)(non constant)
--
component std_brshift 

generic(
	shifter_size 	:integer := 8 --8bit shifter default 

);
Port( 	
			inp 			:in  std_logic_vector( (shifter_size-1) downto 0); 		
			shift_num 	:in  integer range 0 to inp'high;
			outp 			:out std_logic_vector( (shifter_size-1) downto 0)
);
                        
end component;

-------------------------------------------------------------------------------------------------

end package shift;

package body shift is 
------------------------------------------------------------------------------------------------
--barrel right shifter
FUNCTION brshift  ( 
	inp : std_logic_vector; 		--low
	shift_num :integer range 0 to 32 	--high
	
) RETURN std_logic_vector is
  
	variable outp: std_logic_vector(inp'range);
	variable tmp: integer range inp'range := inp'low + shift_num;
	
begin

	
FO0:FOR i IN inp'high downto (inp'high - shift_num + 1)  LOOP
		tmp := tmp -1;
		outp(tmp) := inp(i);		
END LOOP;

tmp :=	inp'high;

FO1:FOR i IN (inp'high - shift_num) downto inp'low  LOOP

		outp(tmp) := inp(i);
		tmp := tmp -1;
		
END LOOP;
	
	assert ( (shift_num < inp'length) and (shift_num > 0) ) report "please take care about number of shifts!" severity error;	
--	END IF;
	
	return outp;
end function;
------------------------------------------------------------------------------------------------

--barrel right shifter
FUNCTION brshift  ( 
	inp : integer_vector; 		--low
	shift_num :integer range 0 to 32 	--high
	
) RETURN integer_vector is
  
	variable outp: integer_vector(inp'range);
	variable tmp: integer range inp'range := inp'low + shift_num;
	
begin

	
FO0:FOR i IN inp'high downto (inp'high - shift_num + 1)  LOOP
		tmp := tmp -1;
		outp(tmp) := inp(i);		
END LOOP;

tmp :=	inp'high;

FO1:FOR i IN (inp'high - shift_num) downto inp'low  LOOP

		outp(tmp) := inp(i);
		tmp := tmp -1;
		
END LOOP;
	
	assert ( (shift_num < inp'length) and (shift_num > 0) ) report "please take care about number of shifts!" severity error;	
--	END IF;
	
	return outp;
end function;
------------------------------------------------------------------------------------------------
--simple right shifter
FUNCTION lshift  ( 
	inp : std_logic_vector; 		--low
	shift_num :integer range 0 to 32 	--high
	
) RETURN std_logic_vector is
  
	variable outp: std_logic_vector(inp'range) := (others => '0'); 
	variable tmp: integer range inp'range := inp'low + shift_num;
	
begin

tmp :=	inp'high;

FO1:FOR i IN (inp'high - shift_num) downto inp'low  LOOP

		outp(tmp) := inp(i);
		tmp := tmp -1;
		
END LOOP;
	
	assert ( (shift_num < inp'length) and (shift_num > 0) ) report "please take care about number of shifts!" severity error;	
--	END IF;
	
	return outp;
end function;
------------------------------------------------------------------------------------------------
--barrel left shifter
FUNCTION blshift  ( 
	inp : std_logic_vector; 		--low
	shift_num :integer range 0 to 32 	--high
	
) RETURN std_logic_vector is
  
	variable outp: std_logic_vector(inp'range);
	variable tmp: integer range inp'range := inp'high - shift_num ;
	
begin

FO0:FOR i IN inp'low to (inp'low + shift_num - 1)  LOOP
		tmp := tmp +1;
		outp(tmp) := inp(i);		
END LOOP;

tmp :=	inp'low;

FO1:FOR i IN (inp'low + shift_num) to inp'high  LOOP

		outp(tmp) := inp(i);
		tmp := tmp +1;
		
END LOOP;
	
	assert ( (shift_num < inp'length) and (shift_num > 0) ) report "please take care about number of shifts!" severity error;	
	
return outp;
	
end function;
------------------------------------------------------------------------------------------------
--barrel left shifter
FUNCTION blshift  ( 
	inp : integer_vector; 		--low
	shift_num :integer range 0 to 32 	--high
	
) RETURN integer_vector is
  
	variable outp: integer_vector(inp'range);
	variable tmp: integer range inp'range := inp'high - shift_num ;
	
begin

FO0:FOR i IN inp'low to (inp'low + shift_num - 1)  LOOP
		tmp := tmp +1;
		outp(tmp) := inp(i);		
END LOOP;

tmp :=	inp'low;

FO1:FOR i IN (inp'low + shift_num) to inp'high  LOOP

		outp(tmp) := inp(i);
		tmp := tmp +1;
		
END LOOP;
	
	assert ( (shift_num < inp'length) and (shift_num > 0) ) report "please take care about number of shifts!" severity error;	
	
return outp;
	
end function;
------------------------------------------------------------------------------------------------
--left shifter
FUNCTION rshift  ( 
	inp : std_logic_vector; 		--low
	shift_num :integer range 0 to 32 	--high
	
) RETURN std_logic_vector is
  
	variable outp: std_logic_vector(inp'range) := ( others=>'0');
	variable tmp: integer range inp'range ;
	
begin

tmp :=	inp'low;

FO1:FOR i IN (inp'low + shift_num) to inp'high  LOOP

		outp(tmp) := inp(i);
		tmp := tmp +1;
		
END LOOP;
	
	assert ( (shift_num < inp'length) and (shift_num > 0) ) report "please take care about number of shifts!" severity error;	
	
return outp;
	
end function;

------------------------------------------------------------------------------------------------other usefull functions
--create range of numbers 
--output format:	integer_vector: is array of integers 
--output lowest number put on index 0 and high number put on higher index 
--output range:   (higher - lower -1) downto 0
FUNCTION gen_range  ( lower: integer; higher:integer) RETURN integer_vector is
  
	variable outp: integer_vector(( higher - lower -1) downto 0) ;
	variable cntr: integer:= lower;
	
begin

FO1:FOR i IN 0 to ( higher - lower -1)  LOOP

		outp(i) := cntr;
		cntr := cntr + 1;
		
END LOOP;
	
	assert ( (lower> -1 ) and (higher > lower) ) report "please take care about number of parameters!" severity error;	
	
return outp;
	
end function;
------------------------------------------------------------------------------------------------other usefull functions
--This function produces an array in which each element shifts relative to the previous index.
--
--
--ex: inp : (1,2,3,4,5,6,7,8,9)<integer_vector>, array_length: 5(integer), shift_number: 2(integer)
--
-- return value: ( (1,2,3,4,5,6,7,8,9), (3,4,5,6,7,8,9,1,2), (5,6,7,8,9,1,2,3,4), (7,8,9,1,2,3,4,5,6), (9,1,2,3,4,5,6,7,8) )<integer_vector_array>
--                      index0					index1					index2					index3					index4
--output format:	integer_vector_array: is array of integer_vector 
--
FUNCTION gen_blshift_array  ( inp : integer_vector; array_length : integer; shift_number : integer) RETURN integer_vector_array is
	
	--type integer_vector_array_type is array((array_length-1) downto 0) of integer_vector(inp'range);
	

	variable result: integer_vector_array( (array_length-1) downto 0)( inp'range );
	--variable tmp : integer_vector(inp'range);
begin

	result(0) := inp;--all of the row 0

	for i in 1 to (result'high)   loop --widthout considering index zero

		result(i) := blshift( result(i-1), shift_number); --barrel shifter
		
	end loop;
	
	assert ( array_length < (inp'length + 1) ) report "please take care about number of parameters!" severity error;	
	
return result;
	
end function;
------------------------------------------------------------------------------------------------other usefull functions
--This function produces an array in which each element shifts relative to the previous index.
--
--
--ex: inp : (1,2,3,4,5,6,7,8,9)<integer_vector>, array_length: 5(integer), shift_number: 2(integer)
--
-- return value: ( (1,2,3,4,5,6,7,8,9), (8,9,1,2,3,4,5,6,7), (6,7,8,9,1,2,3,4,5), (4,5,6,7,8,9,1,2,3), (2,3,4,5,6,7,8,9,1) )<integer_vector_array>
--                      index0					index1					index2					index3					index4
--output format:	integer_vector_array: is array of integer_vector 
--
FUNCTION gen_brshift_array  ( inp : integer_vector; array_length : integer; shift_number : integer) RETURN integer_vector_array is
	
	--type integer_vector_array_type is array((array_length-1) downto 0) of integer_vector(inp'range);
	

	variable result: integer_vector_array( (array_length-1) downto 0)( inp'range );
	--variable tmp : integer_vector(inp'range);
begin

	result(0) := inp;--all of the row 0

	for i in 1 to (result'high)   loop --widthout considering index zero

		result(i) := brshift( result(i-1), shift_number); --barrel shifter
		
	end loop;
	
	assert ( array_length < (inp'length + 1) ) report "please take care about number of parameters!" severity error;	
	
return result;
	
end function;


------------------------------------------------------------------------------------------------

end package body shift;

------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.MATH_REAL.all;
use IEEE.numeric_std.to_unsigned;
use work.std_mux.ALL;
use work.shift.all;


entity std_brshift is

generic(
	shifter_size 	:integer := 8 --8bit shifter default 

);
Port( 	
			inp 			:in  std_logic_vector( (shifter_size-1) downto 0); 		
			shift_num 	:in  integer range 0 to inp'high;
			outp 			:out std_logic_vector( (shifter_size-1) downto 0)
);
                        
end std_brshift;

architecture Behavioral of std_brshift is
	
	------------------------------------------------------------------------------------
	type input_signal_type is  array( inp'range ) of std_logic_vector( inp'range );
	--type integer_vector_array is array( inp'range ) of integer_vector( inp'range );

	signal select_sig : std_logic_vector( integer( floor( sqrt( real(inp'high) ) ) ) downto 0);
	signal input_sig : input_signal_type;
	
	------------------------------------------------------------------------------------
	constant mask_value : integer_vector( inp'range ) := gen_range(inp'low, (inp'high+1)); --we putting this on output	
 	constant mask_array : integer_vector_array(inp'range)(inp'range) := gen_blshift_array( mask_value, inp'length, 1 ); --writed for vhdl 2008
	
	
	
begin
	
	
	GE0 : for i in inp'range generate
	
		FA0 : mux generic map(	
							inp'high, 
							select_sig'high)
			 	port map(
							input_sig(i), 
							select_sig, 
							outp(i)	);
	
	end generate;
								
		
	GE1 :for i in 0 to inp'high generate

		
		GE2 :for j in 0 to inp'high generate
		
			input_sig(j)(i) <= inp( mask_array(i)(j) );
		
		
		end generate;
		
	--blshift
	
	
	end generate;
	
	select_sig <= std_logic_vector( to_unsigned(shift_num, select_sig'length) );
	
end Behavioral;
-------------------------------------------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.MATH_REAL.all;
use IEEE.numeric_std.to_unsigned;
use work.std_mux.ALL;
use work.shift.all;


entity std_blshift is

generic(
	shifter_size 	:integer := 8 --8bit shifter default 

);
Port( 	
			inp 			:in  std_logic_vector( (shifter_size-1) downto 0); 		
			shift_num 	:in  integer range 0 to inp'high;
			outp 			:out std_logic_vector( (shifter_size-1) downto 0)
);
                        
end std_blshift;

architecture Behavioral of std_blshift is
	
	------------------------------------------------------------------------------------
	type input_signal_type is  array( inp'range ) of std_logic_vector( inp'range );
	--type integer_vector_array is array( inp'range ) of integer_vector( inp'range );

	signal select_sig : std_logic_vector( integer( floor( sqrt( real(inp'high) ) ) ) downto 0);
	signal input_sig : input_signal_type;
	
	------------------------------------------------------------------------------------
	constant mask_value : integer_vector( inp'range ) := gen_range(inp'low, (inp'high+1)); --we putting this on output	
 	constant mask_array : integer_vector_array(inp'range)(inp'range) := gen_brshift_array( mask_value, inp'length, 1 ); --writed for vhdl 2008
	
	
	
begin
	
	
	GE0 : for i in inp'range generate
	
		FA0 : mux generic map(	
							inp'high, 
							select_sig'high)
			 	port map(
							input_sig(i), 
							select_sig, 
							outp(i)	);
	
	end generate;
								
		
	GE1 :for i in 0 to inp'high generate

		
		GE2 :for j in 0 to inp'high generate
		
			input_sig(j)(i) <= inp( mask_array(i)(j) );
		
		
		end generate;
		
	--blshift
	
	
	end generate;
	
	select_sig <= std_logic_vector( to_unsigned(shift_num, select_sig'length) );
	
end Behavioral;



--end with the name of allah