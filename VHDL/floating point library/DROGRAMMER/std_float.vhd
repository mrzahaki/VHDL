--in the name of allah

-- vhdl 2008
-- compiled in intel quartus and simulated with ISIM from XILINX ISE
--------------------------------------------------------------------------------
--					in the name of allah
--
--
--
--
--		designer: 			hussein zahaki
--		library name : 		DROGRAMMER	
--   	FileName:         	std_float.vhd
--   	Dependencies:     	work.std_arith and std_logic_1164 and numeric_std and math_real
--		version: vhdl 2008(important)
--
--
--   	brief: the floatig point package contains functions and components that they perform flooating point operations, such as synthesizable  adddition and multipliction and etc.
--		important note: all of the components are synthesizable 
--		
--		note: All functions and components are designed so that the Precision of operations is variable and depends on user choice.
--  	note: as described above you can change the Precision of input line's with generic ports in defined components or constants in functions.
--		note: We have already defined the standard types of ieee 754 floating point as follows:
--			float_single_precision		(32 bit)
--			float_double_precision		(64 bit)
--			float_quadruple_precision	(129 bit)
--			float_octuple_precision     (257 bit)
--		
--		components:	
--					- fadder	standard variable length floating point adder		(synthesizable)
--					- fmul		standard variable length floating point multiplier	(synthesizable)
--		 
--		functions:
--					fnormalization		floating point normalizer 	(used for convert Non-standard floating-point numbers to it's standard representation ) (important)
--					frounding			floating point rounder		(used for convert Non-standard floating-point numbers to it's standard representation )	(important)
--					to_vector			it's convert real number to vector TYPE
--					to_float			it's convert real vector  to real number 
---					dec2vect			it's convert decimal part of floating-point number to vector TYPE
--					norm_dec2vect		it's convert decimal part of floating-point number to vector TYPE(normalized output)
--					dec_size            it's calculate size of represented vector for  decimal part of floating-point number 
-- 					reverse				with this function you can reverse a floating point number
-- 					absolute			used to calculate absolute value of real number(specified for this lib)
--					vect_bias			calculate bias value of exponent in floating point numbers(output TYPE is STD_LOGIC_VECTOR) 
-- 					int_bias			calculate bias value of exponent in floating point numbers(output TYPE is INTEGER) 
--					slog2				special log2
-- 					x_shift_cntrl		(inner functions, The description is not mentioned)
-- 					y_shift_cntrl		(inner functions, The description is not mentioned)
--					unaryor				(inner functions, The description is not mentioned)
-- 					"and"				(inner functions, The description is not mentioned)
--					"="					(inner functions, The description is not mentioned)
-- 					"+"					(inner functions, The description is not mentioned)
-- 					"-"					(inner functions, The description is not mentioned)
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
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all; 
use ieee.MATH_REAL.all; 
use work.std_arith.all;
--use ieee.fixed_float_types.all;
--use ieee.std_logic_unsigned.all;
 
package std_float is


-- value, exponent:
-- example:
--		.025 		= 25e-3		=> 25,-3
--		250.334 	= 250334e3 	=>	250334,3


-------------------------------------------------
TYPE float_type is array(2 downto 1) of INTEGER;

constant singlePrecision_SignificandWidth: INTEGER := 23;
constant singlePrecision_ExponentWidth: INTEGER := 8;
subtype singlePrecision_type is STD_LOGIC_VECTOR(singlePrecision_SignificandWidth + singlePrecision_ExponentWidth+1 downto 1 );

constant doublePrecision_SignificandWidth: INTEGER := 52;
constant doublePrecision_ExponentWidth: INTEGER := 11;
subtype doublePrecision_type is STD_LOGIC_VECTOR(doublePrecision_SignificandWidth + doublePrecision_ExponentWidth+1 downto 1 );

constant quadruplePrecision_SignificandWidth: INTEGER := 113;
constant quadruplePrecision_ExponentWidth: INTEGER := 15;
subtype quadruplePrecision_type is STD_LOGIC_VECTOR(quadruplePrecision_SignificandWidth + quadruplePrecision_ExponentWidth+1 downto 1 );

constant octuplePrecision_SignificandWidth: INTEGER := 237;
constant octuplePrecision_ExponentWidth: INTEGER := 19;
subtype octuplePrecision_type is STD_LOGIC_VECTOR(octuplePrecision_SignificandWidth + octuplePrecision_ExponentWidth+1 downto 1 );
-------------------------------------------------
--IEEE 754-2008 standard single-precision float TYPE
constant float_single_precision :float_type :=( singlePrecision_SignificandWidth,  singlePrecision_ExponentWidth  );

--IEEE 754-2008 standard double-precision float TYPE
constant float_double_precision :float_type :=( doublePrecision_SignificandWidth,  doublePrecision_ExponentWidth  );

--IEEE 754 quadruple-precision binary floating-point format
constant float_quadruple_precision :float_type :=( quadruplePrecision_SignificandWidth,  quadruplePrecision_ExponentWidth  );

--IEEE 754 octuple-precision binary floating-point format:
constant float_octuple_precision :float_type :=( octuplePrecision_SignificandWidth,  octuplePrecision_ExponentWidth  );

-------------------------------------------------
component fmul 
generic (
float_typedef :float_type := float_single_precision
);
port(
	X,Y		:in STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1);--defined in std_arith.vhd
	outp	:out STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1) := (others=>'0') --defined in std_arith.vhd
);
end component;
------------------------------------------
component fadder
generic (
float_typedef :float_type := float_single_precision
);
port(
	X,Y	:in STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1);--defined in std_arith.vhd
	outp			:out STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1)--defined in std_arith.vhd
);
end component;
--------------------------------------------------------------------------------------inner components
function frounding (
	input						: STD_LOGIC_VECTOR;
	constant desired_length :INTEGER := 23 --float_typedef determine output length
) return 					STD_LOGIC_VECTOR ;
------------------------------------------------------------------
function fnormalization ( 
	inp		: STD_LOGIC_VECTOR;--(float_typedef(2)+2 downto 1);  
	exponent 		: STD_LOGIC_VECTOR;--(float_typedef(1) downto 1);  
	constant float_typedef :float_type := float_single_precision
	--normalized_out 	:out STD_LOGIC_VECTOR(float_typedef(2) + float_typedef(1) downto 1)
) return STD_LOGIC_VECTOR;
--convert to STD_LOGIC_VECTOR

FUNCTION reverse( l : real ) RETURN real; 
FUNCTION "and"( l : STD_LOGIC; r : STD_LOGIC_VECTOR  ) RETURN STD_LOGIC_VECTOR;
FUNCTION "=" (L: STD_LOGIC_VECTOR; R: STD_LOGIC) return BOOLEAN;
FUNCTION "+" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
FUNCTION "-" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR ;
FUNCTION slog2( inp : INTEGER  ) RETURN INTEGER;
FUNCTION absolute(L: real) return real ;
FUNCTION absolute(L: INTEGER) return INTEGER;
-------------------------------------------------------------------------inner control functions
FUNCTION x_shift_cntrl( l : STD_LOGIC_VECTOR  ) RETURN INTEGER;
FUNCTION y_shift_cntrl( l : STD_LOGIC_VECTOR  ) RETURN INTEGER;
FUNCTION unaryor( inp : STD_LOGIC_VECTOR  ) RETURN STD_LOGIC;
FUNCTION vect_bias( float_typedef :float_type  ) RETURN STD_LOGIC_VECTOR;
FUNCTION int_bias( float_typedef :float_type  ) RETURN INTEGER;

FUNCTION to_vector( inp : real; float_typedef : float_type ) RETURN STD_LOGIC_VECTOR;
FUNCTION to_float( inp : STD_LOGIC_VECTOR; constant float_typedef : float_type  ) RETURN real;

FUNCTION dec2vect( dec : real   ) RETURN STD_LOGIC_VECTOR;
FUNCTION norm_dec2vect( dec : real; constant float_typedef : float_type )  RETURN STD_LOGIC_VECTOR;
-- FUNCTION norm_dec_size( dec : real;  constant float_typedef : float_type  ) RETURN INTEGER ;
FUNCTION dec_size( dec : real   ) RETURN INTEGER ;
--FUNCTION index( inp : STD_LOGIC_VECTOR; search: STD_LOGIC   ) RETURN INTEGER ;

end std_float;

package body std_float is

------------------------------------------------------------------------------
FUNCTION reverse( l : real ) RETURN real is
begin
	return (1.0/l);
end function;
------------------------------------------------------------------------------
--sign magnitude abs
FUNCTION "and"( l : STD_LOGIC; r : STD_LOGIC_VECTOR  ) RETURN STD_LOGIC_VECTOR is
begin
	return (r'range => l) and r;
end function;
------------------------------------------------------------------------------
FUNCTION "=" (L: STD_LOGIC_VECTOR; R: STD_LOGIC) return BOOLEAN is
begin
	return (L'range => R) = L;
end function;
------------------------------------------------------------------------------
FUNCTION "+" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
begin
	return STD_LOGIC_VECTOR( to_unsigned(R, L'length) + unsigned(L) );
end function;
--------------------------------------------------------------------------------
FUNCTION absolute(L: real) return real is
begin
	if(L < 0.0) then 
		return L* (-1.0); end if;
	return L;
end function;
--------------------------------------------------------------------------------
FUNCTION absolute(L: INTEGER) return INTEGER is
begin
	if(L < 0) then 
		return L* (-1);	end if;
		
	return L;
end function;
------------------------------------------------------------------------------
FUNCTION "-" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
begin
	return STD_LOGIC_VECTOR(  unsigned(L) - to_unsigned(R, L'length) );
end function;
------------------------------------------------------------------------------
FUNCTION y_shift_cntrl( l : STD_LOGIC_VECTOR  ) RETURN INTEGER is
begin
	if( l(l'high) = '0' ) then
		return sm_abs(l);
	else
		return	0;
	end if;

end function;
------------------------------------------------------------------------------
FUNCTION x_shift_cntrl( l : STD_LOGIC_VECTOR  ) RETURN INTEGER is
begin

	if( l(l'high) = '1' ) then
		return sm_abs(l);
	else
		return	0;
	end if;

end function;
------------------------------------------------------------------------------
FUNCTION unaryor( inp : STD_LOGIC_VECTOR  ) RETURN STD_LOGIC is

	variable temp: STD_LOGIC_VECTOR(inp'Range);
begin

   temp(inp'low) := inp(inp'low);
   gen: for i in (inp'low+1) to inp'high loop
        temp(i) := temp(i-1) or inp(i);
   end loop;
	 
	return temp(inp'high);

end function;
------------------------------------------------------------------------------
FUNCTION slog2( inp : INTEGER  ) RETURN INTEGER is

begin

if(inp = 0) then return 2; 
end if;

return INTEGER(  floor( log2(real(inp)) + 0.00000000001 ) );

end function;
------------------------------------------------------------------------------
FUNCTION int_bias( float_typedef :float_type  ) RETURN INTEGER is
constant exponent_width 		:INTEGER := float_typedef(1);
begin
	return 2**(exponent_width -1) - 1;
end function;
------------------------------------------------------------------------------
FUNCTION vect_bias( float_typedef :float_type  ) RETURN STD_LOGIC_VECTOR is
constant exponent_width 		:INTEGER := float_typedef(1);
variable temp: STD_LOGIC_VECTOR(exponent_width-1 downto 1):= (others=>'1');
begin
	return '0' & temp;
end function;
------------------------------------------------------------------------------
-- FUNCTION index( vect : STD_LOGIC_VECTOR; search: STD_LOGIC   ) RETURN INTEGER is

-- variable cntr :INTEGER := inp'low;
-- alias inp	:STD_LOGIC_VECTOR(vect'high downto vect'low) is vect;

-- begin
	-- LOOP0: for i in inp'range loop
		-- if(inp(i) = search) then
			-- Exit; 
		-- end if;
		-- cntr := cntr +1;
	-- end loop;
	
	-- return cntr;
-- end function;	
------------------------------------------------------------------------------
-- FUNCTION norm_dec_size( dec : real;  constant float_typedef : float_type  ) RETURN INTEGER is

-- constant significand_width :INTEGER := float_typedef(2);
-- variable cntr :INTEGER := 0;
-- variable inp : real := dec;
-- begin
	-- LOOP0: while cntr < (significand_width+1)loop	--max value 1000
		-- inp := inp * 2.0;
		-- if(inp >= 1.0) then
			-- inp := inp - 1.0; 
		-- end if;
		-- cntr := cntr + 1;
	-- end loop;
	
	-- return cntr;
-- end function;	
------------------------------------------------------------------------------
FUNCTION dec_size( dec : real   ) RETURN INTEGER is
constant max_size : INTEGER := 400;
variable cntr :INTEGER := 0;
variable inp : real := dec;
begin

	if(dec = 0.0) then return 5; end if; --its can be any value
	LOOP0: while not(inp = 0.0) and (cntr < max_size) loop	--max value 1000
		inp := inp * 2.0;
		if(inp >= 1.0) then
			inp := inp - 1.0; 
		end if;
		cntr := cntr + 1;
	end loop;
	
	return cntr;
end function;	
------------------------------------------------------------------------------
FUNCTION norm_dec2vect( dec : real; constant float_typedef : float_type )  RETURN STD_LOGIC_VECTOR is

constant significand_width :INTEGER := float_typedef(2);
--seprating INTEGER and real part
variable inp : real := dec;
variable int_part :STD_LOGIC ;
variable cntr :INTEGER := 1;
variable vect_int : STD_LOGIC_VECTOR( 1 to dec_size(inp));


alias vect_res	:STD_LOGIC_VECTOR(vect_int'high downto 1) is vect_int;

begin
	
	if(dec = 0.0) then return STD_LOGIC_VECTOR( to_unsigned(0, significand_width ) );
	end if;
	
	LOOP0: while not(inp=0.0)  and (cntr < 400)  loop
		inp := inp * 2.0;
		if(inp >= 1.0) then
			int_part := '1';
			inp := inp - 1.0; 
		else 
			int_part := '0';
		end if;
		vect_int(cntr) := int_part;
		cntr := cntr + 1;
	end loop;
	
return frounding(vect_res, significand_width) ;	
end function;
------------------------------------------------------------------------------
--decimal part to vector converter
FUNCTION dec2vect( dec : real   ) RETURN STD_LOGIC_VECTOR is
	--seprating INTEGER and real part
variable inp : real := dec;
variable int_part :STD_LOGIC ;
variable cntr :INTEGER := 1;
variable vect_int : STD_LOGIC_VECTOR( 1 to dec_size(inp));


alias vect_res	:STD_LOGIC_VECTOR(vect_int'high downto 1) is vect_int;

begin
	if(dec = 0.0) then return STD_LOGIC_VECTOR( to_unsigned(0, vect_res'length ) );
	end if;
	
	LOOP0: while not(inp=0.0)  and (cntr < 400) loop --max value
		inp := inp * 2.0;
		if(inp >= 1.0) then
			int_part := '1';
			inp := inp - 1.0; 
		else 
			int_part := '0';
		end if;
		vect_int(cntr) := int_part;
		cntr := cntr + 1;
	end loop;
	
return vect_res;	
end function;	
------------------------------------------------------------------------------
--vector to decimal part converter
--vect format: 2**(-1) +  2**(-2) +     0   +   2**(-3) + ...
--vect format(just arrange is important, i dont care about downto/to style ): MSB[1			1			0		1	      ...]LSB
FUNCTION vect2dec( vect : STD_LOGIC_VECTOR    ) RETURN real is
	--seprating INTEGER and real part
alias inp	: STD_LOGIC_VECTOR(1 to vect'length) is vect;
variable tmp :real := 1.0;
begin

	LOOP0: for i in inp'low to inp'high loop --max value
		if( inp(i)='1' ) then
			tmp :=  tmp + ( 2**(-1.0 * real(i)) );
		end if;
	end loop;
	
return tmp;	
end function;	
------------------------------------------------------------------------------
--floating point sinificand rounding
-- input format: [actual sinificand,(downto) additional bits] 

function frounding (
	input						: STD_LOGIC_VECTOR;
	constant desired_length :INTEGER := 23 --float_typedef determine output length
) return 					STD_LOGIC_VECTOR  is

	--outp 	:out STD_LOGIC_VECTOR(desired_length  downto 1)
	variable RS	: STD_LOGIC_VECTOR(1 to 2);	--see rounding standard method 
	alias inp	:STD_LOGIC_VECTOR(input'length downto 1) is input;
	
begin
	RS(1) := inp( inp'high - desired_length );	--R bit
	RS(2) := unaryor( inp( inp'high - desired_length-1 downto 1) ); --S bit
		
	if( RS = "11") then	--increment
		return inp( inp'high downto (inp'high - desired_length +1)) +1;--significand+1
		
	else--check carry bit																--shift right if carry buffer is high
		return inp( inp'high downto (inp'high - desired_length +1));--significand
	
	end if;
	
end function;
------------------------------------------------------------------------------
FUNCTION to_vector( inp : real; constant float_typedef : float_type  ) RETURN STD_LOGIC_VECTOR is
	--seprating INTEGER and real part
	
constant exponent_width :INTEGER := float_typedef(1);
constant significand_width :INTEGER := float_typedef(2);

constant bias_value: INTEGER := int_bias(float_typedef);
	
variable int_part :INTEGER :=  INTEGER( floor(  absolute(inp)  ) );
variable dec_part :real := absolute(inp) - absolute(real(int_part)) ;

variable vect_int_part : STD_LOGIC_VECTOR( slog2(int_part) downto 1);
variable vect_real_part : STD_LOGIC_VECTOR( dec_size(dec_part) downto 1 );
variable sign_bit : STD_LOGIC := '0';

variable significand_vect : STD_LOGIC_VECTOR( significand_width downto 1 ) := (others=> '0');

begin
	if (inp = 0.0) then
		return  STD_LOGIC_VECTOR( to_unsigned(0, exponent_width + significand_width + 1 ) );
	elsif(inp < 0.0) then 
		sign_bit := '1';
	end if;
	
	if(int_part = 0) then
		significand_vect := norm_dec2vect(dec_part, float_typedef);		
		return sign_bit & fnormalization('0' & '0' & significand_vect, vect_bias(float_typedef),  float_typedef);
	else
		vect_real_part :=  dec2vect(dec_part) ; --decimal part
		vect_int_part := STD_LOGIC_VECTOR( to_unsigned(int_part, slog2(int_part) ) );
		
		if ( (vect_int_part'length + vect_real_part'length) < significand_width ) then 
		
			significand_vect := frounding(vect_int_part & vect_real_part & significand_vect,
											significand_width);
			
		
		elsif ( (vect_int_part'length + vect_real_part'length) > significand_width ) then 
			significand_vect := frounding(vect_int_part & vect_real_part,
											significand_width);
		else
			significand_vect := vect_int_part & vect_real_part;
		end if;
		
		return sign_bit & STD_LOGIC_VECTOR( to_unsigned(vect_int_part'length + bias_value, exponent_width ) ) & significand_vect;
	end if;
	
	
end function;	
------------------------------------------------------------------------------
--the inp must be normalized
--note real TYPE just suitable for single precision float TYPE 
FUNCTION to_float( inp : STD_LOGIC_VECTOR;  constant float_typedef : float_type  ) RETURN real is
	--seprating INTEGER and real part
	
constant exponent_width :INTEGER := float_typedef(1);
constant significand_width :INTEGER := float_typedef(2);

variable fx			:STD_LOGIC_VECTOR(significand_width downto 1) := inp( significand_width  downto 1 );
variable expx 		:STD_LOGIC_VECTOR(exponent_width downto 1) := inp( (significand_width + exponent_width) downto (significand_width + 1) ) ;
constant bias_value: INTEGER := int_bias(float_typedef);

variable result : real;

begin

if(inp(inp'high) = '1') then
	return  -1.0 * vect2dec(fx) * 2**( real(to_integer(unsigned(expx)) - bias_value) );
else
	return  vect2dec(fx) * 2**( real(to_integer(unsigned(expx)) - bias_value) );
end if;	
end function;
------------------------------------------------------------------------------
--floating point sinificand normalization
--output format => [normalized exponent(input exponent width), normalized sinificand(input sinificand width-1)] => example significand: "1001001001"(without normalization'1' bit)
--input format =>  [carry bit, normalization bit,significand] => example: "00.1001001001"

function fnormalization ( 
	inp		: STD_LOGIC_VECTOR;--(float_typedef(2)+2 downto 1);  
	exponent 		: STD_LOGIC_VECTOR;--(float_typedef(1) downto 1);  
	constant float_typedef :float_type := float_single_precision
	--normalized_out 	:out STD_LOGIC_VECTOR(float_typedef(2) + float_typedef(1) downto 1)
) return STD_LOGIC_VECTOR is

	alias unnormal_in : STD_LOGIC_VECTOR(float_typedef(2)+2 downto 1) is inp;
	constant significand_width :INTEGER := float_typedef(2);
	variable significand_out 	: STD_LOGIC_VECTOR(significand_width+1 downto 1);
	variable final_exp 			: STD_LOGIC_VECTOR(exponent'range) ;
	variable cntr				: INTEGER range -1 to unnormal_in'high := 0 ;

begin
	if( unnormal_in = '0' ) then
	significand_out := ( others => '0' );
	final_exp := (final_exp'range => '0');

	elsif(unnormal_in( unnormal_in'high) = '1') then--check carry bit																--shift right if carry buffer is high
		significand_out :=   unnormal_in(significand_width +2 downto 2);--STD_LOGIC_VECTOR( shift_right( unnormalized_signed_res(), 1 ) )
		final_exp :=  exponent + 1;
		
	elsif(unnormal_in( significand_width + 1) = '1') then	--normalization bit
		significand_out := unnormal_in(significand_width+1 downto 1);
		final_exp := exponent;
		
	else				--shift left if  additional normalization bit cleared
		significand_out := unnormal_in(significand_width+1 downto 1);
		final_exp :=  exponent;
		
		cntr := 0;
		LOOP0:while cntr < significand_width loop 
			exit when (significand_out( significand_width +1 ) = '1');
			significand_out := STD_LOGIC_VECTOR( shift_left(unsigned(significand_out),	1 ) );
			cntr := cntr + 1;
		end loop;
		final_exp := final_exp - cntr;
	end if;
	
	return final_exp & significand_out(significand_width downto 1);
	
end function;
------------------------------------------------------------------------------

end std_float;
--------------------------------------------------------------------


--------------------------------------------------------------------


--format:
--MSB  [sign], [float_type(1): exponent], [float_type(2): sinificant]		LSB
--inputs must be normalized

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.std_arith.all;
use work.std_float.all;
--sub sign magnitude adder
entity fadder is 
generic (
float_typedef :float_type := float_single_precision
);
port(
	X,Y		: STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1);--defined in std_arith.vhd
	outp	:out STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1)--defined in std_arith.vhd
);
end fadder;

architecture structural of fadder is

constant exponent_width :INTEGER := float_typedef(1);
constant significand_width :INTEGER := float_typedef(2);

alias fx	:STD_LOGIC_VECTOR(significand_width downto 1) is X( significand_width  downto 1 );
alias fy	:STD_LOGIC_VECTOR(significand_width downto 1) is Y( significand_width  downto 1 );

alias expx 			:STD_LOGIC_VECTOR(exponent_width downto 1) is X( (significand_width + exponent_width) downto (significand_width + 1) ) ;
alias expy 			:STD_LOGIC_VECTOR(exponent_width downto 1) is Y( (significand_width + exponent_width) downto (significand_width + 1) ) ;


signal  es_result 				: STD_LOGIC_VECTOR((exponent_width + 1) downto 1); --exponent sub result each element income with sign magnitude TYPE
signal sig_expoutp 												: STD_LOGIC_VECTOR(exponent_width downto 1);

signal shifted_x, shifted_y, unnormalized_signed_res	: STD_LOGIC_VECTOR(significand_width+2 downto 1);-- 1.011011111 add normalized 1
signal carry_buff													: STD_LOGIC_VECTOR(2 downto 1);

signal normal_out	:	STD_LOGIC_VECTOR((significand_width + exponent_width) downto 1);

begin

---------------------------------------------------------------section1 exponent processing
FA000: sadder generic map(io_width => exponent_width+1) port map( '0' & expx, '1' & expy, '0',carry_buff(1), es_result    ); --subtract exponents(exp X - exp Y)
-------------------------------------------
shifted_y(significand_width+1 downto 1) <=  STD_LOGIC_VECTOR(	shift_right(unsigned('1' & fy), 
																		y_shift_cntrl( es_result ) )); -- exp x > exp y then y must be shift
shifted_y(significand_width+2) <= Y(Y'high);
-------------------------------------------
shifted_x(significand_width+1 downto 1) <=  STD_LOGIC_VECTOR( 	shift_right(unsigned('1' & fx), 
																		x_shift_cntrl( es_result ) )); -- exp x < exp y then x must be shift
shifted_x(significand_width+2) <= X(X'high);--X sign
-------------------------------------------
sig_expoutp <=  ((expx'range => not es_result( es_result'high )) and expx ) or ( (expx'range => es_result( es_result'high )) and expy );
---------------------------------------------------------------section2 significand processing

FA100: sadder generic map(io_width => significand_width + 2) port map( shifted_x, shifted_y, '0',carry_buff(2), unnormalized_signed_res    ); --addition/subtract between two significand

---------------------------------------------------------------section3 normalization process
normal_out <= fnormalization(
				carry_buff(2) & unnormalized_signed_res(unnormalized_signed_res'high-1 downto 1),
				sig_expoutp,
				float_typedef
				);
outp <= unnormalized_signed_res(unnormalized_signed_res'high) & normal_out;


end structural;


--------------------------------------------------------------------
--format:
--MSB  [sign], [float_type(1): exponent], [float_type(2): sinificant]		LSB
--inputs must be normalized

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.std_arith.all;
use work.std_float.all;
--sub sign magnitude adder
entity fmul is 
generic (
float_typedef :float_type := float_single_precision
);
port(
	X,Y				:in  STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1);--defined in std_arith.vhd
	outp			:out STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1) := (others=>'0') --defined in std_arith.vhd
);
end fmul;

architecture structural of fmul is

constant exponent_width 		:INTEGER := float_typedef(1);
constant significand_width  	:INTEGER := float_typedef(2);
constant normalization_ftype 	:float_type :=( (significand_width * 2) ,  exponent_width  );-- 2 downto 1 

alias fx	:STD_LOGIC_VECTOR(significand_width downto 1) is X( significand_width  downto 1 );
alias fy	:STD_LOGIC_VECTOR(significand_width downto 1) is Y( significand_width  downto 1 );

alias expx 			:STD_LOGIC_VECTOR(exponent_width downto 1) is X( (significand_width + exponent_width) downto (significand_width + 1) ) ;
alias expy 			:STD_LOGIC_VECTOR(exponent_width downto 1) is Y( (significand_width + exponent_width) downto (significand_width + 1) ) ;

TYPE sadder_type is array(2 downto 1) of STD_LOGIC_VECTOR((exponent_width + 1) downto 1);
--signal sadder_x, sadder_Y  	: STD_LOGIC_VECTOR((exponent_width + 1) downto 1); --exponent sub result each element income with sign magnitude TYPE
signal sadder_out			: sadder_type;

--  [sign] ['1'] [significand_bits]
signal smul_out			: STD_LOGIC_VECTOR((significand_width+2)*2 downto 1);-- 1.011011111 add normalized 1

--  [carry] ['1'] [significand_bits]
signal sfnorm_out		: STD_LOGIC_VECTOR(normalization_ftype(2) + normalization_ftype(1)  downto 1);-- normalization_ftype significand length and without carry bit and normalization bit

begin

---------------------------------------------------------------section1 exponent processing
	--adding two exponents(handled in process PR0)
	FA000: sadder generic map(io_width => exponent_width + 1) port map( '0' & expx, '1' & vect_bias(float_typedef), '0', open, sadder_out(1)    ); --subtract exponents(exp X - exp Y)
	FA100: sadder generic map(io_width => exponent_width + 1) port map( sadder_out(1), '0' & expy, '0', open, sadder_out(2)    ); --subtract exponents(exp X - exp Y)

	-- handle multiply operation	
	--input format: input format: ['sign', 'normalization bit', 'significand']
	--smul_out
	--[sign]['0'][48 bit out(single)  10.1011100011111011111100110010100001000000000000 [48 downto 1]]
	FA200: smul generic map(io_width => significand_width + 2) port map( X(X'high) & '1' & fx,	--first input
																		 Y(Y'high) & '1' & fy, 	--second input
																		 smul_out); --addition/subtract between two significand

	sfnorm_out <= fnormalization( 	smul_out(smul_out'high-2 downto 1),
									sadder_out(2)(sadder_out(2)'high-1 downto 1), 
									normalization_ftype);
	--rounding operaion
	outp(significand_width + exponent_width downto 1) <= frounding(sfnorm_out, significand_width + exponent_width );
	--putting results on output
	outp(significand_width + exponent_width + 1) <= smul_out(smul_out'high);--sign assigment
																
---------------------------------------------------------------section3 normalization process


end structural;

