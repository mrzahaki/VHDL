in the name of allah

brief: the shift package contains functions and components that they perform sifting operations, such as bi-directional synthesizable  barrel shifters(left to right and vice versa) and bi-directional normal shiters just same as barrel shifters.
    
    package name: shift
   	Dependencies:     work.std_mux and std_logic_1164 and std_logic_unsigned 
		version: vhdl 2008(important)
	
important note: left and right directions are valid for (n downto m) descending type operations note that for ascending type range the shift directions are reversed
		
Note: All functions and components are designed so that the number of bits in the input lines is flexible.

Note: as described above you can change the number of input line's bits with generic ports in defined components. 
		
Note: The std_mux package contains an n * n multiplexer (multiplexer with arbitrary number of inputs).

components:	

    std_brshift	standard barrel right shifter		(note shift number can be a variable argument)(synthesizable)
    std_blshift	standard barrel left shifter		(note shift number can be a variable argument)(synthesizable)
		 
functions:

    -brshift		barrel right shifter	(note shift number must be a constant argument)(synthesizable)
		-blshift		barrel left shifter	(note shift number must be a constant argument)(synthesizable)
   	-lshift		normal right shift	(note shift number must be a constant argument)(synthesizable)
		-rshift		normal right shift	(note shift number must be a constant argument)(synthesizable)
 

useful functions:				

    -gen_range				The gen_range function returns a sequence of numbers, starting from lower parameter, and increments by 1 , and stops before a specified number called higher.			
 		-gen_blshift_array	This function produces an array in which each element shifts(with blshift) relative to the previous index.	
		-gen_brshift_array	This function produces an array in which each element shifts(with brshift) relative to the previous index.	
