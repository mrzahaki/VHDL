--	in the name of ALLAH
--
-- brief: sign magnitude adder
--	param inp: is the input parameter and it is an array containing the numbers to be added.
-- note: this adder is an selectable m bit, sign magnitude adder with n inputs.
-- note: you can change m and n parameters (described above) in std_signed.vhd with sadder_io_width and sadder_io_numbers constants.
-- 
-- note: sadder_io_width is an user define constant that it's placed on std_signed.vhd file, with control this value you can change the length of the input vectors(sadder_io_type)
-- note: sadder_io_numbers is an user define constant that it's placed on std_signed.vhd file, with control this value you can You can change the number of input vectors.(sadder_io_numbers)
-- 
-- note: 
-- param outp: is the output, and it is an number of TYPE sadder_io_type(defined in std_signed.vhd).
--
--
-- designed by hussein zahaki



----------------------------------------------------------------------------------------------------------------



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use work.std_type.all;

--std_signed package 
package std_arith is 

--TYPE integer_vector	is array(NATURAL range<>) of INTEGER;


--you can change the i/o(input and output) width and number of adder inputs in here (selectable n bit sign magnitude adder with n inputs)
constant sadder_io_width 	:	INTEGER := 8;--default value 8bit adder
constant sadder_io_numbers 	:	INTEGER := 4;--default an adder with 2 inputs
------------------------------------------------------------------------------------inner definitions

--define general vector TYPE in sign magnitude adder 
--subtype sadder_io_type	is STD_LOGIC_VECTOR(sadder_io_width downto 1);
--defining main vector used in sadder package(input and out and other)
TYPE SUB_SORT_TYPEDEF IS ARRAY(1 TO 2)	OF INTEGER;
TYPE SORT_TYPEDEF IS ARRAY(NATURAL RANGE<>)	OF SUB_SORT_TYPEDEF;

function sm2tc(inp :STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR ;
FUNCTION signed_not  ( l : STD_LOGIC_VECTOR  ) RETURN STD_LOGIC_VECTOR;
FUNCTION sm_abs  ( l : STD_LOGIC_VECTOR  ) RETURN INTEGER;
FUNCTION accumulate  ( l : integer_vector  ) RETURN integer_vector;
FUNCTION lw_sort  ( l : integer_vector ) RETURN SORT_TYPEDEF;
FUNCTION max  ( l : integer; r:integer ) RETURN integer;
FUNCTION max  ( l : integer_vector ) RETURN integer;
FUNCTION indexof  ( l : integer_vector; elem:integer; false_num:integer ) RETURN integer;

FUNCTION normal_sort  ( l : integer_vector ) RETURN integer_vector ;
FUNCTION sorted_index  ( l : integer_vector ) RETURN integer_vector ;
function "+"(l :STD_LOGIC_VECTOR; r:STD_LOGIC) return unsigned;
function mux( inp : STD_LOGIC_VECTOR; sel : STD_LOGIC_VECTOR) return STD_LOGIC;
-------------------------------------------------------------------------------------main functions definition
--extend sign magnitude adder
-- component extend_sadder 
-- port(
	-- inp			:in sadder_vector;--defined in std_arith.vhd
	-- carry_in	:in STD_LOGIC;
	-- carry_out	:out STD_LOGIC;
	-- outp		:out sadder_io_type--defined in std_arith.vhd

-- );
-- end component;

--sign magnitude adder
component sadder 
generic (
io_width :INTEGER := 8
);
port(
	in0,in1		:in STD_LOGIC_VECTOR(io_width downto 1);--defined in std_arith.vhd
	carry_in	:in STD_LOGIC;
	carry_out	:out STD_LOGIC;
	outp		:out STD_LOGIC_VECTOR(io_width downto 1)--defined in std_arith.vhd
);
end component;


--------------------------------------------------------
-- unsigned  adder
component uadder 
generic(
	 io_width : INTEGER := 8
);
port(
		 inp0,inp1 	:in STD_LOGIC_VECTOR(io_width downto 1);
		 carry_in	:in STD_LOGIC;
		 carry_out	:out STD_LOGIC;
		 outp	:out STD_LOGIC_VECTOR(io_width downto 1)
);
end component;

--------------------------------------------------------
--signed multiplier
component smul 
	generic (
		io_width :INTEGER := 8
	);	
	port(
		x, y :in STD_LOGIC_VECTOR(io_width downto 1); --input
		mulRes :out STD_LOGIC_VECTOR((io_width * 2) downto 1) --output multiplier result
	);
end component;

--------------------------------------------------------
--unsigned multiplier
component umul 
	generic (
		io_width :INTEGER := 8
	);	
	port(
		x, y :in STD_LOGIC_VECTOR(io_width downto 1); --input
		mulRes :out STD_LOGIC_VECTOR((io_width * 2 ) downto 1) --output multiplier result
	);

end component;



end package std_arith;
package body std_arith is
--sign magnitude to two's complement converter
-----------------------------------------------------------------------------
function sm2tc(inp :STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
	variable tmp: STD_LOGIC_VECTOR(inp'range) := ( inp'range => inp( inp'high ) );
	
  begin
  
  return ((not tmp) and inp) or ( ( not(inp) + 1) and tmp);
end sm2tc;
-----------------------------------------------------------------------------
function mux( inp : STD_LOGIC_VECTOR; sel : STD_LOGIC_VECTOR) return STD_LOGIC is 
begin 

	return( inp(to_integer( unsigned(sel) )) );

end function;
--------------------------------------------------------------------------------------------------------------inner functions
function "+"(l :STD_LOGIC_VECTOR; r:STD_LOGIC) return unsigned is
	variable tmp: STD_LOGIC_VECTOR(l'range) := (l'range=>'0');
  begin
	tmp(tmp'low) := r;
  return unsigned(l) + unsigned(tmp);
end function;
--------------------------------------------------------------------------------------------------------------inner functions
FUNCTION max  ( l : integer; r:integer ) RETURN integer is

begin
if(l > r) then return l; end if;
return r;
end function;
--------------------------------------------------------------------------------------------------------------inner functions
FUNCTION max  ( l : integer_vector ) RETURN integer is
 variable tmp: integer;
 -- variable buf: integer_vector(l'range) := l ;
begin
tmp:=l(l'low);
for i in l'low+1 to l'high loop
	tmp :=  max(tmp, l(i));
end loop;

return tmp;
end function;
--------------------------------------------------------------------------------------------------------------inner functions
FUNCTION indexof  ( l : integer_vector; elem:integer; false_num:integer ) RETURN integer is

begin
	for i in l'range loop
			if(l(i) = elem) then return i; end if;
	end loop;
	return false_num;
end function;
------------------------------------------------------------------------------
FUNCTION signed_not  ( l : STD_LOGIC_VECTOR  ) RETURN STD_LOGIC_VECTOR is
		
	variable  result: STD_LOGIC_VECTOR(l'range);

begin
	
	if (l(l'high) = '1') then
		result := '1' & not(l(l'high-1 downto 1));
	else 
		result := l;
	end if;
	
	return result;
	
end function;
------------------------------------------------------------------------------
--sign magnitude abs
FUNCTION sm_abs  ( l : STD_LOGIC_VECTOR  ) RETURN INTEGER is
begin
	return to_integer( unsigned('0' & l(l'high-1 downto l'low) ) );
end function;
--------------------------------------------------------------------
--sign magnitude abs
FUNCTION accumulate  ( l : integer_vector  ) RETURN integer_vector is
 variable ret_vect :integer_vector(l'range) := (others => 0);
begin
	ret_vect(l'low) :=  l(l'low);
	l0:for i in l'low+1 to l'high loop
	
			ret_vect(i) := ret_vect(i-1) + l(i);		
	
	end loop l0;
	
	return ret_vect;
	
end function;
-----------------------------------------------------------------
--SORT_TYPEDEF=>( sorted value, pre index)
FUNCTION lw_sort  ( l : integer_vector ) RETURN SORT_TYPEDEF IS--sort low to high

variable res : SORT_TYPEDEF(1 to l'length);
variable temp : SORT_TYPEDEF(1 to 2);
BEGIN
	for i in  l'range loop
		res(i)(1) :=  l(i);
		res(i)(2) := i;
	end loop;
	
	for i in  1 to res'length loop
		for j in (i+1) to res'length loop
		
		if(res(i)(1) > res(j)(1)) then
		
		    temp(1) := res(i);    
            res(i) := res(j);    
            res(j) := temp(1);
		
		end if;
		
		end loop;
	end loop;
	
	return res;
	
END FUNCTION;
-----------------------------------------------------------------
FUNCTION sorted_index  ( l : integer_vector ) RETURN integer_vector IS
	variable tmp : SORT_TYPEDEF(1 to l'length);
	variable res : integer_vector(1 to l'length);
BEGIN
	tmp := lw_sort(l);
	for i in 1 to res'length loop
		res(i) := tmp(i)(2); 
	end loop;
	return res;
END FUNCTION;
-----------------------------------------------------------------
--SORT_TYPEDEF=>( sorted value, pre index)
FUNCTION normal_sort  ( l : integer_vector ) RETURN integer_vector IS--sort low to high

variable res : integer_vector(1 to l'length) := l ;
variable temp : integer;
BEGIN

	for i in  1 to res'length loop
		for j in (i+1) to res'length loop
		
		if(res(i) > res(j)) then
		
		    temp := res(i);    
            res(i) := res(j);    
            res(j) := temp;
		
		end if;
		
		end loop;
	end loop;
	return res;
	
END FUNCTION;
---------------------------------------------------------------------------------------
end package body;
---------------------------------------------------------------------------------------signed multiplier
library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
-- start umul entity
-- multiplier result must have double length compare with inputs
--input format: ['sign', 'unsigned data']
-- output format: [size(x) *2] => [sign, '0', size( widthout_sign(x)*2 )]
entity smul is
	generic (
		io_width :INTEGER := 8
	);	
	port(
		x, y :in STD_LOGIC_VECTOR(io_width downto 1); --input
		mulRes :out STD_LOGIC_VECTOR( io_width * 2  downto 1) --output multiplier result
	);
	
end smul;
architecture mul_strct of smul is
	signal tmp : STD_LOGIC_VECTOR((io_width-1)*2 downto 1);
begin

	FA0 : umul generic map(io_width-1) port map( x(io_width-1 downto 1), y(io_width-1 downto 1),tmp   );
	mulRes <= (x(x'high) xor y(y'high)) & '0' & tmp;
	
end mul_strct;

---------------------------------------------------------------------------------------unsigned multiplier
library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;
-- start umul entity
-- multiplier result must have double length compare with inputs
entity umul is
	generic (
		io_width :INTEGER := 8
	);	
	port(
		x, y :in STD_LOGIC_VECTOR(io_width downto 1); --input
		mulRes :out STD_LOGIC_VECTOR((io_width * 2 ) downto 1) --output multiplier result
	);

end umul;

architecture mul_strct of umul is

TYPE adder_result_type	is array(io_width-2 downto 1) of STD_LOGIC_VECTOR(io_width downto 1);
TYPE temp_signal_type	is array(4 downto 1) of STD_LOGIC_VECTOR(io_width downto 1);
	
	signal adders_result : adder_result_type;
	signal tmp: temp_signal_type;
begin
	assert io_width > 2 report "the number of input lines must be greater than 2" severity error;
	
	mulRes(1) <=  x(1) and y(1);
	
		--first  summer
	FA81: uadder generic map( io_width ) 
	port map (
		--ones input
		inp0 =>  '0'&(x(io_width downto 2) and (x(io_width downto 2)'Range => y(1)) ),
		--second input
		inp1 => (x and (x'Range => y(2)) ),
		carry_in=> '0',
		--cout
		carry_out => adders_result(1)(io_width),
		--sum out
		
		outp(io_width downto 2) => (adders_result(1)(io_width-1 downto 1) ),
		outp(1) => mulRes(2)
	);
	
	
	LOOP22: for i in 1  to ( io_width - 3 ) generate
	
		FA82: uadder generic map( io_width ) 
		port map(
			--ones input
			inp0 => adders_result(i),
			--second input
			inp1 => (x and (x'Range => y(i + 2)) ),
			carry_in => '0',
			--cout
			carry_out => adders_result(i+1)(io_width),
			--sum outs
			outp(io_width downto 2) => adders_result(i+1)(io_width-1 downto 1),
			outp(1) => mulRes(i + 2)
		);	
		
		
	end generate;

	FA83: uadder generic map( io_width ) 
	port map(
		--ones input
		inp0 => adders_result(io_width - 2),
		--second input
		inp1 => (x and (x'Range => y(io_width)) ),
		carry_in => '0',
		--cout
		carry_out => mulRes(mulRes'high),
		--sum out
		outp(io_width downto 1) => mulRes(mulRes'high-1 downto io_width)
	);	

end mul_strct;
-------------------------------------------------------------------------------------
-- library ieee;
-- use ieee.std_logic_1164.all;
-- use work.std_arith.all;

-- entity extend_sadder is 
-- port(
	-- inp			:in sadder_vector;--defined in std_arith.vhd
	-- carry_in	:in STD_LOGIC;
	-- carry_out	:out STD_LOGIC;
	-- outp		:out sadder_io_type--defined in std_arith.vhd

-- );
-- end extend_sadder;

-- architecture structural of extend_sadder is

-- signal sig :sadder_vector;

-- signal  cout: STD_LOGIC_VECTOR(sadder_io_numbers downto 1);



-- begin

	-- FA0: sadder generic map(sadder_io_width) port map( inp(1), inp(2), carry_in, cout(1), sig(1));
	-- LOOP11: for i in 1  to ( sadder_io_numbers - 2 ) generate

		-- FA1: sadder generic map(sadder_io_width) port map( sig(i), inp(i + 2), '0', cout(i+1),sig(i + 1));		
	-- end generate;


	-- assert sadder_io_numbers > 1 report "the number of input lines must be greater than 1" severity error;
	-- assert sadder_io_width > 0 report "the width of each line must be greater than 0" severity error;
	
	-- outp <= sig(sadder_io_numbers -1);
	-- carry_out	<= cout(sadder_io_numbers -1);

-- end structural;
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;

--sub sign magnitude adder
entity sadder is 
generic (
io_width :INTEGER := 8
);
port(
	in0,in1		:in STD_LOGIC_VECTOR(io_width downto 1);--defined in std_arith.vhd
	carry_in	:in STD_LOGIC;
	carry_out	:out STD_LOGIC;
	outp		:out STD_LOGIC_VECTOR(io_width downto 1)--defined in std_arith.vhd
);
end sadder;

architecture structural of sadder is
signal inp0, inp1:STD_LOGIC_VECTOR(io_width+1 downto 1);
signal carry_fromadder, carry_toadder: STD_LOGIC;
signal out_to_adder0, out_to_adder1, adder_out_to_controller: STD_LOGIC_VECTOR(io_width+1 downto 1);

begin
inp0 <= in0( io_width ) & '0' & in0(io_width-1 downto 1);
inp1 <= in1( io_width ) & '0' & in1(io_width-1 downto 1);

FA88:uadder generic map( io_width=> io_width + 1 ) port map(	out_to_adder0,
																out_to_adder1,
																carry_toadder xor carry_in, 
																carry_fromadder, 
																adder_out_to_controller);
																
																

	process(inp0, inp1, carry_fromadder, adder_out_to_controller ) is

			alias inp0_sign	:STD_LOGIC is inp0(inp0'high);
			alias inp1_sign	:STD_LOGIC is inp1(inp1'high);

	begin

		if (( inp0_sign xor inp1_sign) = '1') then --different signs
				--if carry = 1 overflow occured and the result is posetive (we must add the number with carry) otherwise it must be complemented
				carry_toadder <= carry_fromadder;
				out_to_adder0 <= signed_not(inp0); out_to_adder1 <= signed_not(inp1);
				
				if ( carry_fromadder = '1') then	--positive result
				
					outp <= '0' & adder_out_to_controller((io_width-1)downto 1);
					carry_out <= adder_out_to_controller(io_width);
				else
					outp <=  '1' & not adder_out_to_controller(io_width-1 downto 1);
					carry_out <= not adder_out_to_controller(io_width);
				
				end if;
				
			else --same sign
				carry_toadder <= '0';
				out_to_adder0 <= inp0;	out_to_adder1 <= inp1;
				outp <= (inp1_sign) & adder_out_to_controller((io_width-1)downto 1);
				carry_out <= adder_out_to_controller(io_width);
			
			end if;
	  
	end process;

end structural;
-----------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all; 

entity uadder is
generic(
	 io_width : INTEGER := 8
);
port(
		 inp0,inp1 	:in STD_LOGIC_VECTOR(io_width downto 1);
		 carry_in	:in STD_LOGIC;
		 carry_out	:out STD_LOGIC;
		 outp	:out STD_LOGIC_VECTOR(io_width downto 1)
);
end uadder;	

architecture behave of uadder is

	--component definition
	component fulladder
		port(
			a, b, cin : in STD_LOGIC; --inputs
			cout, sum : out STD_LOGIC --outputs
		);
	end component;
	
	--signal definition with one useless signall
	signal carrySig 	: STD_LOGIC_VECTOR(io_width downto 1);--default 8 downto 1
	
begin
	--note carrySig(sadder_io_width) = carry input because if carry out = 1 overflow occured and the result is posetive
	FA99:fulladder port map(inp0(1), inp1(1), carry_in	, carrySig(1), outp(1)  );
	
	GEN0:for i in 1 to (io_width-1) generate
			
			FA111:fulladder port map(inp0(i + 1), inp1(i + 1), carrySig(i), carrySig(i +1), outp(i + 1)  );
	
	end generate;
	
	carry_out <= carrySig( io_width );
	
end behave; 

-------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

--start full adder entity
entity fulladder is
	port(
		a, b, cin : in STD_LOGIC; --inputs
		cout, sum : out STD_LOGIC --outputs
	);
end fulladder;

architecture adder_strct of fulladder is

	--signal definition
	signal after_xor : STD_LOGIC;

begin

	after_xor <= a xor b;
	sum <= after_xor xor cin;
	cout <= (a and b) or (cin and after_xor);

end adder_strct;
--end full adder entity


 --END WITH THE NAME OF ALLAH
