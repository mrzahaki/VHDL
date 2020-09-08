--in the name of allah



library ieee;
use ieee.std_logic_1164.all;

--config package 
package config is 


--you can change the i/o(input and output) width and number of adder inputs in here (selectable n bit sign magnitude adder with n inputs)
constant sm_adder_io_width 	:	integer := 64;--default value 8bit adder
constant sm_adder_io_numbers 	:	integer := 16;--default an adder with 2 inputs
------------------------------------------------------------------------------------inner definitions


--define general vector type in sign magnitude adder 
subtype sm_adder_io_type	is std_logic_vector(sm_adder_io_width downto 1);

--defining main vector used in sm_adder package(input and out and other)
type sm_adder_vector is array(sm_adder_io_numbers downto 1)	of sm_adder_io_type;


--defining sub_adder vector
type sub_adder_vector is array(2 downto 1)	of sm_adder_io_type;


-------------------------------------------------------------------------------------main functions definition
component sub_sm_adder  
port(
	inp0,inp1	:in sm_adder_io_type;--defined in config.vhd
	outp	:out sm_adder_io_type--defined in config.vhd

);
end component;


--brief: an full n bit adder
--note: you can chane the input line width (n) with access to  sub_adder_vector
--param inp: input of adder
--param carry_in: carry input
--param carry_out: carry output
--param outp: is result of summation

component sub_adder --see tools.vhdl
	port(
		inp :in sub_adder_vector; --input
		carry_in: in std_logic;
		carry_out: out std_logic; 
		outp :out sm_adder_io_type --output;
	);
end component ;


-------------------------------------------------------------------------------------other functions definition
--special or function used in sm_adder lib
--FUNCTION "++"  ( l, r : sm_adder_io_type  ) RETURN sm_adder_io_type;

FUNCTION "or"  ( l, r : sub_adder_vector  ) RETURN sub_adder_vector;

--special and function used in sm_adder lib
FUNCTION "and"  ( l, r : sub_adder_vector  ) RETURN sub_adder_vector;

--special xnor function used in sm_adder lib
FUNCTION "xnor"  ( l, r : sub_adder_vector  ) RETURN sub_adder_vector;

--special std_logic to  sub_adder_vector converter
FUNCTION To_sub_adder_vector  ( inp : std_logic  ) RETURN sub_adder_vector;
FUNCTION To_sub_adder_vector  ( inp0,inp1 : sm_adder_io_type  ) RETURN sub_adder_vector;


--special not function used in sm_adder_controller and other funcctions
FUNCTION signed_not  ( l : sub_adder_vector  ) RETURN sub_adder_vector;
FUNCTION signed_not  ( l : sm_adder_io_type  ) RETURN sm_adder_io_type;


--------------------------------------------------------------------------------------other
procedure sm_adder_controller (
		inp 														:in sub_adder_vector;
		signal adder_out_to_controller 					:in sm_adder_io_type;
		signal carry_fromadder 								:in std_logic;
		signal carry_toadder 								:out std_logic;
		signal out_to_adder_io								:out sub_adder_vector;
		signal main_sub_sm_adder_out 						:out sm_adder_io_type
	);


end config;


package body config is
---------------------------------------------------------------------------------------
FUNCTION "or"  ( l, r : sub_adder_vector  ) RETURN sub_adder_vector is
	
	variable result: sub_adder_vector;

begin
	result(1) := l(1) or r(1);
	result(2) := l(2) or r(2);
	return result;
	
end function;
---------------------------------------------------------------------------------------
FUNCTION "and"  ( l, r : sub_adder_vector  ) RETURN sub_adder_vector is
	
	variable result: sub_adder_vector;

begin
	result(1) := l(1) and r(1);
	result(2) := l(2) and r(2);
	return result;
	
end function;
---------------------------------------------------------------------------------------
FUNCTION "xnor"  ( l, r : sub_adder_vector  ) RETURN sub_adder_vector is
	
	variable result: sub_adder_vector;

begin
	result(1) := l(1) xnor r(1);
	result(2) := l(2) xnor r(2);
	return result;
	
end function;
---------------------------------------------------------------------------------------
FUNCTION To_sub_adder_vector  ( inp : std_logic  ) RETURN sub_adder_vector is
	
	variable result: sub_adder_vector;

begin
	result(1) := (sm_adder_io_type'range => inp);
	result(2) := (sm_adder_io_type'range => inp);
	return result;
	
end function;
---------------------------------------------------------------------------------------
FUNCTION To_sub_adder_vector  ( inp0,inp1 : sm_adder_io_type  ) RETURN sub_adder_vector is
	
	variable result: sub_adder_vector;

begin
	result(1) := inp0;
	result(2) := inp1;
	return result;
	
end function;

---------------------------------------------------------------------------------------
FUNCTION signed_not  ( l : sub_adder_vector  ) RETURN sub_adder_vector is
	
	alias l1_sign	:std_logic is l(1)(sm_adder_io_width);
	alias l2_sign	:std_logic is l(2)(sm_adder_io_width);
	
	variable result: sub_adder_vector;

begin
	
	if (l1_sign = '1') then
		result(1) := '1' & not(l(1)(sm_adder_io_width-1 downto 1));
	else 
		result(1) := l(1);
	end if;
	
	
	if (l2_sign = '1') then
		result(2) := '1' & not(l(2)(sm_adder_io_width-1 downto 1));
	else 
		result(2) := l(2);
	end if;
	
	
	
	return result;
end function;
---------------------------------------------------------------------------------------
FUNCTION signed_not  ( l : sm_adder_io_type  ) RETURN sm_adder_io_type is
	
	alias l_sign	:std_logic is l(sm_adder_io_width);
	
	variable  result: sm_adder_io_type;

begin
	
	if (l_sign = '1') then
		result := '1' & not(l(sm_adder_io_width-1 downto 1));
	else 
		result := l;
	end if;
	
	return result;
	
end function;
--------------------------------------------------------------------------------------
procedure sm_adder_controller (
		inp 												:in sub_adder_vector;
		signal adder_out_to_controller 					:in sm_adder_io_type;
		signal carry_fromadder 								:in std_logic;
		signal carry_toadder 									:out std_logic;
		signal out_to_adder_io								:out sub_adder_vector;
		signal main_sub_sm_adder_out 						:out sm_adder_io_type
	)is

	alias inp1_sign	:std_logic is inp(1)(sm_adder_io_width);
	alias inp2_sign	:std_logic is inp(2)(sm_adder_io_width);
	
begin

	if ( (inp1_sign xor inp2_sign) = '1') then --different signs
			--if carry = 1 overflow occured and the result is posetive (we must add the number with carry) otherwise it must be complemented
			carry_toadder <= carry_fromadder;
			out_to_adder_io <= signed_not(inp);
			
			if ( carry_fromadder = '1') then	--positive result
			
				main_sub_sm_adder_out <= '0' & adder_out_to_controller((sm_adder_io_width-1)downto 1);
			else
				main_sub_sm_adder_out <=  signed_not( adder_out_to_controller );
			
			end if;
		
		else --same sign
			carry_toadder <= '0';
			out_to_adder_io <= inp;
			main_sub_sm_adder_out <= (inp1_sign) & adder_out_to_controller((sm_adder_io_width-1)downto 1);
		
		end if;

end sm_adder_controller;


---------------------------------------------------------------------------------------
end package body;