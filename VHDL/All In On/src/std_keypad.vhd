--------------------------------------------------------------------------------
--					in the name of allah
--
--
--
--
--		designer: hussein zahaki
--   	FileName:         std_keypad.vhd
--   	Dependencies:     work.std_shift  and std_logic_1164 
--		version: vhdl 2008		
--
--   	brief: this package used to drive one or more nXm keypads
--		note: n,m (the size of key pad) are user define values that can be defined with @keypad_size constant(see below).
--		note: you must define your keypad characters in @keypad_table array constant(see below), then complete that array as shown on your keyboard.
--		note: the index of the column and row signals must be compatible with the shape of the keypad_table array array.(see @keypad_table)
--  	note: keypad_row_vector and keypad_col_vector are inner vectors that dont need to change thenm, they are automatically set with definition of keypad_table array(see @keypad_table) and with @keypad_size constants.
--		note: you can use  keypad_row_vector and keypad_col_vector, vectors in your component instance( and dont take care about size of vector just put it on your instance! )
--		component:	keypad
--		ports:
--		
--				clk_frequency :integer := 100000--Hz --generic port
-- 			inp_rows		:input 	keypad_row_vector
--	 			clk			:input 	std_logic			--input clock()
--			 	out_cols		:output 	keypad_col_vector --defined in std_keypad.vhd
--				res			:output 	character         --result of keyboard
--
--
--
-- 	important note: depend on your clock frequency, you need delay on the process inside keypad component for debouncing keys on keypad
--		note: you can control debouncing delay with debouncing_delay constant see below
--		note: debouncing_delay formulation is :
--				debouncing_delay_period(s time) = (debouncing_delay / clk_frequency)		
--
--   
--------------------------------------------------------------------------------




library ieee;
use ieee.std_logic_1164.all;
use work.std_shift.all;

--std_keypad package 
package std_keypad is 

-------------------------------------------------------------------------------------------
subtype   ninteger is integer range 3 to 40;
type keypad_size_type is array(1 downto 0) of ninteger;


-------------------------------------------------------------------------------------------
--here define size of keypad(default 4X4 keypad)(keypad_size(0) => size of rows, keypad_size(1) => size of columns)
constant keypad_size: keypad_size_type := (20 , 20);	
	
constant debouncing_delay: integer := 100;--depend on main clock frequency					

type sys_state is (scan, result_extract, final_result);

------------------------------------------------------------------------------------inner definitions


--define general vector type for rows of keypad derivers
subtype keypad_row_vector	is std_logic_vector((keypad_size(0)-1) downto 0);
--define general vector type for columns of keypad derivers
subtype keypad_col_vector	is std_logic_vector((keypad_size(1)-1) downto 0);


type mask_array_type is array(natural range <>) of std_logic_vector(keypad_col_vector'range);

-------------------------------------------------------------------------------------main functions definition
--you must define special caracteres used in your key pad
--my key pad (default keypad) characters


TYPE std_keypad_table IS ARRAY(keypad_row_vector'range, keypad_col_vector'range) OF character;


--you also must define this two dimentional array equal to your keypad keys
-- this definition is only for my own 4X4 keypad
-- @keypad_table definition
 CONSTANT keypad_table : std_keypad_table := (																																
													 --      ----------------------------------------------------------------------------------------------------------
													 --      |  9    8   7    6    5    4   3    2    1    0   9    8   7    6    5    4   3    2    1    0(lsb)    |   |  
													 --      ----------------------------------------------------------------------------------------------------------
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-' ),  -- | 9 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','b', 'j', 'r', 'z','4', '5', '6', '/' ),  -- | 8 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','c', 'k', 's', '!','7', '8', '9', '*' ),  -- | 7 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','d', 'l', 't', '@','0', '=', '+', '^' ),  -- | 6 | 
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','e', 'm', 'u', '#',' ', ')', ',', '?' ),  -- | 5 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','f', 'n', 'v', '$','4', '&', '.', '"' ),  -- | 4 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','g', 'o', 'w', '%','<', ':', ']', '}' ),  -- | 3 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','h', 'p', 'x', '(','>', '_', '[', '{' ),  -- | 2 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','g', 'o', 'w', '%','<', ':', ']', '}' ),  -- | 1 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','h', 'p', 'x', '(','>', '_', '[', '{' ),  -- | 0 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-' ),  -- | 9 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','b', 'j', 'r', 'z','4', '5', '6', '/' ),  -- | 8 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','c', 'k', 's', '!','7', '8', '9', '*' ),  -- | 7 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','d', 'l', 't', '@','0', '=', '+', '^' ),  -- | 6 | 
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','e', 'm', 'u', '#',' ', ')', ',', '?' ),  -- | 5 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','f', 'n', 'v', '$','4', '&', '.', '"' ),  -- | 4 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','g', 'o', 'w', '%','<', ':', ']', '}' ),  -- | 3 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','h', 'p', 'x', '(','>', '_', '[', '{' ),  -- | 2 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','g', 'o', 'w', '%','<', ':', ']', '}' ),  -- | 1 |
																 ('a', 'i','a', 'i', 'q', 'y','1', '2', '3', '-','a', 'i','h', 'p', 'x', '(','>', '_', '[', '{' ) );-- | 0 | start lsb
 																 
---------------------------------------------------------------------------------
component keypad
generic(
	clk_frequency :integer := 100000--Hz
);
port(
	 inp_rows	:in keypad_row_vector;--defined in std_keypad.vhd
	 clk, nrst			:in std_logic;
	 out_cols	:out keypad_col_vector; --defined in std_keypad.vhd
	 ready		:out std_logic;
	 res			:out character
);
end component keypad;
--------------------------------------------
function mask_array_creator(inp :integer) return mask_array_type;


end package std_keypad;



package body std_keypad is

---------------------------------------------------------------------------------------
function mask_array_creator(inp :integer) return mask_array_type is
	
	variable mask_array : mask_array_type( keypad_col_vector'range); --we putting this on output
	
	-----------------------------------
	
begin
	--inital state
	mask_array(keypad_col_vector'low) := (keypad_col_vector'range => '0');
	mask_array(keypad_col_vector'low)( keypad_col_vector'low ) := '1';

	for i in (keypad_col_vector'low+1) to keypad_col_vector'high  loop --widthout considering index zero

		mask_array(i) := blshift(mask_array(i-1), 1); --barrel shifter
		
	end loop;

return mask_array;

end mask_array_creator;
---------------------------------------------------------------------------------------
end package body;


---------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.std_keypad.all;


entity keypad is
generic(
	clk_frequency :integer := 100000--Hz
);
port(
	 inp_rows	:in keypad_row_vector;--defined in std_keypad.vhd
	 clk, nrst			:in std_logic;
	 out_cols	:out keypad_col_vector; --defined in std_keypad.vhd
	 ready		:out std_logic;
	 res			:out character
);
end entity keypad;

architecture behavioral of keypad is


--------------------------------------------------------signal declaration
signal state : sys_state	:= scan;
constant mask_array : mask_array_type(out_cols'range) := mask_array_creator(0);


begin

process(clk) 

	-----------------------------------

	variable clk_counter 	: integer:= 0; --timing
	-----------------------------------
	variable col_index	: integer range 0 to keypad_col_vector'length := 0; 
	variable row_index	: integer range 0 to keypad_row_vector'length := 0; 
	-----------------------------------
	
begin

	
	if (clk'event and clk = '1') then
	
		if (clk_counter > (clk_frequency * debouncing_delay)) then

			case state is 
				------------------------------------------------scan state 
				when scan =>
					ready <= '0';
					if(col_index > out_cols'length) then 
						col_index := 0;
					end if;
					
					out_cols <= mask_array(col_index);
					state <= result_extract;
				
				------------------------------------------------result extraction state 
				when result_extract => 
				
					if(row_index < inp_rows'length) then
			
						if inp_rows(row_index) = '1' then
							
							state <= final_result;
						
						else 
						
							row_index := row_index +1;
							--state <= result_extract;--current state
						
						end if;
						
					else 
						col_index := col_index +1;
						row_index := 0;
						state <= scan;
					end if;
					
				------------------------------------------------final_result state 
				when final_result =>
					res <= keypad_table( row_index, col_index );
					ready <= '1';
					col_index := 0;
					row_index := 0;
					state <= scan;
					clk_counter:= 0;	
			end case;

			

		else
			clk_counter := clk_counter + 1; 
			
		end if;
		
		IF(nrst = '0') THEN
           state <= scan;
       END IF;
	
	end if;
	
end process;

end behavioral;
---------------------------------------------------------------------------------------
