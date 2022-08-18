--	in the name of allah
--	designed by hussein zahaki
--		compiled in : quartus
--		simulated in: ISE ISIM
library ieee;
use ieee.std_logic_1164.all;
use STD.textio.all;
use ieee.MATH_REAL.all; 

--see this library
library DROGRAMMER;
use DROGRAMMER.std_float.all;
use DROGRAMMER.std_arith.all;


entity floating is
  generic(
	float_typedef :float_type := float_octuple_precision--float_octuple_precision-- see DROGRAMMER.std_float
  );
  port (
        none   : out std_logic
     );
end floating;

architecture Behavioral of floating is
--	file file_VECTORS : text;
--	file file_RESULTS : text;
	
    signal adder_0, adder_1 :  octuplePrecision_type := (others=> '0') ;
	signal adder_out :  octuplePrecision_type;
	
	
	--fmul inputs
	signal mul_0, mul_1 :  octuplePrecision_type:= (others=> '0') ;
	signal mul_out :  octuplePrecision_type;
	
begin
	FA0: fadder generic map(float_typedef)  port map(adder_0, adder_1, adder_out);		 
	FA1: fmul generic map (float_typedef)  				port map( 	mul_0, mul_1, mul_out);-- see DROGRAMMER.std_float

	  -------------------------------------------------------------------------
  -- This procedure reads the file input_floating_points.txt which is located in the
  -- work document.
  -- It will read the data in and send it to the floating point adder/multiplier components
  -- to perform the arbitrary operations that defined by user in input_floating_points file.  
  -- The result is written to the output_results.txt file, located in the same directory.
  -- note input_floating_points file format is:

  -- 2.665461644 
  --* 
  ---10.99951231549
  --
  -- 89845.878945 
  --+ 
  --12.4499744
  --
  -- 0.0000154584848 
  --* 
  ---1.0e-10

  --ATTENTION------------------------------------------------------ATTENTION
				--NOTE FOR SIMULATION UNCOMMENT FOLLOWING CODE--
  --ATTENTION------------------------------------------------------ATTENTION
  -- process
    -- variable v_ILINE    : line;
    -- variable v_OLINE    : line;
    -- variable v_OPERATION  : character;
	-- variable v_TERM1,v_TERM2 	: real;
     
  -- begin
 
    -- file_open(file_VECTORS, "input_floating_points.txt",  read_mode);
    -- file_open(file_RESULTS, "output_results.txt", write_mode);
 
    -- while not endfile(file_VECTORS) loop
	
		-- readline(file_VECTORS, v_ILINE);
		-- read(v_ILINE, v_TERM1);
	  
		-- readline(file_VECTORS, v_ILINE);
		-- read(v_ILINE, v_OPERATION);           -- read in the space character
	  
		-- readline(file_VECTORS, v_ILINE);
		-- read(v_ILINE, v_TERM2);
		
		-- readline(file_VECTORS, v_ILINE);--dont care
		-- if(v_OPERATION = '*' ) then --multiply
		
			-- mul_0 <= to_vector( v_TERM1 , float_typedef);
			-- mul_1 <= to_vector( v_TERM2 , float_typedef);
			
			-- wait  for 100ns;
			-- write(v_OLINE, to_float(mul_out, float_typedef), right);
			
		-- elsif(v_OPERATION = '/' ) then 
		
			-- mul_0 <= to_vector( v_TERM1 , float_typedef);
			-- mul_1 <=  to_vector( reverse(v_TERM2) , float_typedef) ;
			
			-- wait for 100ns;
			-- write(v_OLINE, to_float(mul_out, float_typedef), right);
			
		-- elsif(v_OPERATION = '-' ) then
			-- v_TERM2 := v_TERM2 * (-1.0);
			-- adder_0 <= to_vector( v_TERM1 , float_typedef);
			-- adder_1 <= to_vector( v_TERM2 , float_typedef);
			
			-- wait for 100ns;
			-- write(v_OLINE, to_float(adder_out, float_typedef), right);
			
		-- elsif(v_OPERATION = '+' ) then
		
			-- adder_0 <= to_vector( v_TERM1 , float_typedef);
			-- adder_1 <= to_vector( v_TERM2 , float_typedef);
			
			-- wait for 100ns;
			-- write(v_OLINE, to_float(adder_out, float_typedef), right);
		-- end if;
		
		
		-- writeline(file_RESULTS, v_OLINE);
    -- end loop;
	
    -- file_close(file_VECTORS);
    -- file_close(file_RESULTS);
     
    -- wait;
  -- end process;
	
	
end Behavioral;
-----------------------------------------------
