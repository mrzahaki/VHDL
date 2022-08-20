W T A

The <b>shift</b> package contains functions and components to perform shifting operations, include:
- bi-directional synthesizable barrel shifters(left to right and vice versa) 
- bi-directional non synthesizable barrel shifters.


info:

```vhdl
package name: shift
Dependencies:     work.std_mux and std_logic_1164 and std_logic_unsigned 
version: vhdl 2008
```
:memo: **Note:** Left and right directions are valid for (n down to m) descending type operations, shift directions are reversed for ascending type ranges.
		
:memo: **Note:** All functions and components are designed so that the number of bits in the input lines is flexible.

---

<h4>components</h4>

  <b>std_brshift</b>		standard barrel right shifter		(synthesizable)

```vhdl
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
```

<b>std_blshift</b>: standard barrel left shifter		(synthesizable)
  
```vhdl
component std_blshift 
generic(
	shifter_size 	:integer := 8 --8bit shifter 
	default 
);
Port( 	
			inp 			:in  std_logic_vector( (shifter_size-1) downto 0); 		
			shift_num 		:in  integer range 0 to inp'high;
			outp 			:out std_logic_vector( (shifter_size-1) downto 0)
);
						
end component;
```
---



<h4>typedef</h4>

```vhdl
type integer_vector_array is  array (NATURAL range <>) of integer_vector ;
```

---



<h4>functions</h4>

<b>brshift</b>: barrel right shifter	(synthesizable)

  - param inp:  that takes input vector
  - param shift_num:  determines number of shifts and must be a constant value

```vhdl  
FUNCTION brshift  ( inp : std_logic_vector;	 shift_num :integer range 0 to 32 ) RETURN std_logic_vector;
FUNCTION brshift  ( inp : integer_vector; 	 shift_num :integer range 0 to 32 ) RETURN integer_vector ;
```
  example: 
```vhdl
(inp)"10100011"(std_logic_vector 7 downto 0) >>> 3(shift_num) : result= "01110100"
```
</br>
</br>

<b>blshift</b>	barrel left shifter	(synthesizable)
  - param inp:  that takes input vector
  - param shift_num:  determines number of shifts and must be a constant value

```vhdl
FUNCTION blshift  ( inp : std_logic_vector; 	 shift_num :integer range 0 to 32 ) RETURN std_logic_vector;
FUNCTION blshift  ( 	inp : integer_vector; 	shift_num :integer range 0 to 32 ) RETURN integer_vector;
```

</br>
</br>


<b>lshift</b>		left shifter		(non synthesizable)
  - param inp:  that takes input vector
  - param shift_num:  determines number of shifts and must be a constant value

```vhdl
FUNCTION lshift  ( inp : std_logic_vector; 	 shift_num :integer range 0 to 32 ) RETURN std_logic_vector;
```


</br>
</br>

<b>rshift</b>		right shifter		(non synthesizable)
  - param inp:  that takes input vector
  - param shift_num:  determines number of shifts and must be a constant value

```vhdl
FUNCTION rshift  ( inp : std_logic_vector;	 shift_num :integer range 0 to 32 ) RETURN std_logic_vector;
```



</br>
</br>

  			
<b>gen_range</b>
The gen_range function returns a sequence of numbers, starting from lower parameter, and increments by 1 , and stops before a specified number called higher.

- param lower	:  An integer number specifying at which position to start. 
- param higher :	An integer number specifying at which position to stop.
- retval			:	is an integer_vector: (array of integers) 
- :memo: **Note:**			: 	output lowest number put on index 0 and high number put on higher index 

```vhdl
	FUNCTION gen_range  ( lower: integer; higher:integer) RETURN integer_vector;
```

example: 
```vhdl
	gen_range(10,15) retval is (integer_vector 4 downto 0)(14, 13, 12, 11, 10)
```

</br>
</br>
  
<b>gen_blshift_array</b>
This function produces an array in which each element shifts (with blshift) relative to the previous index.	

- param inp				:	input reference vector.
- param array_length	:	length of the output array.
- param shift_number	:	number of shift that the gen_blshift_array, shifts the inp parameter in final result acording to this number.
  
```vhdl
	FUNCTION gen_blshift_array  ( inp : integer_vector; array_length : integer; shift_number : integer) RETURN integer_vector_array ;
```

example: 
```vhdl
	inp : (1,2,3,4,5,6,7,8,9)<integer_vector>, array_length: 5(integer), shift_number: 2(integer)
	retval: ( (1,2,3,4,5,6,7,8,9), (3,4,5,6,7,8,9,1,2), (5,6,7,8,9,1,2,3,4), (7,8,9,1,2,3,4,5,6), (9,1,2,3,4,5,6,7,8) )<integer_vector_array 4 downto 0>
						index0					index1					index2					index3					index4 
	
```
</br>
</br>


 
<b>gen_brshift_array</b>
This function produces an array in which each element shifts (with brshift) relative to the previous index.	

- param inp				:	input reference vector.
- param array_length	:	length of the output array.
- param shift_number	:	number of shift that the gen_brshift_array, shifts the inp parameter in final result acording to this number.
  
```vhdl
	FUNCTION gen_brshift_array  ( inp : integer_vector; array_length : integer; shift_number : integer) RETURN integer_vector_array ;
```

example: 
```vhdl
	inp : (1,2,3,4,5,6,7,8,9)<integer_vector>, array_length: 5(integer), shift_number: 2(integer)
	return value: ( (1,2,3,4,5,6,7,8,9), (8,9,1,2,3,4,5,6,7), (6,7,8,9,1,2,3,4,5), (4,5,6,7,8,9,1,2,3), (2,3,4,5,6,7,8,9,1) )<integer_vector_array>
						index0					index1					index2					index3					index4

```
</br>
</br>
