/*W T A*/

# Arithmetic library 			

```vhdl
    designer: 			hussein zahaki
    library name : 		DROGRAMMER	
   	packages:     	std_arith, std_float, std_type
    type: synthesizable
    version: vhdl 2008
```

:memo: **Note:** All functions and components are designed so that the Precision of the operations is variable and depends on user choice.

<h3>Floating point Package</h3>

The floating point package contains functions and components to perform various types of floating point operations, such as addition, multiplication, etc.

		
:memo: **Note:** Pre-defined standard types of IEEE 754 floating point as follows (customizable):

- float_single_precision		(32 bit)
- float_double_precision		(64 bit)
- float_quadruple_precision	(129 bit)
- float_octuple_precision     (257 bit)
</br>
</br>

<h4>types</h4>	
```vhdl
TYPE float_type is array(2 downto 1) of INTEGER;
```

IEEE 754-2008 standard single-precision float type:

```vhdl
constant singlePrecision_SignificandWidth: INTEGER := 23;
constant singlePrecision_ExponentWidth: INTEGER := 8;

constant float_single_precision :float_type := (singlePrecision_SignificandWidth,  singlePrecision_ExponentWidth);
```

IEEE 754-2008 standard double-precision float type:

```vhdl
constant doublePrecision_SignificandWidth: INTEGER := 52;
constant doublePrecision_ExponentWidth: INTEGER := 11;

constant float_double_precision :float_type := (doublePrecision_SignificandWidth,  doublePrecision_ExponentWidth);
```

IEEE 754 quadruple-precision binary floating-point format:

```vhdl
constant quadruplePrecision_SignificandWidth: INTEGER := 113;
constant quadruplePrecision_ExponentWidth: INTEGER := 15;

constant float_quadruple_precision :float_type := (quadruplePrecision_SignificandWidth,  quadruplePrecision_ExponentWidth);
```

IEEE 754 octuple-precision binary floating-point format:

```vhdl
constant octuplePrecision_SignificandWidth: INTEGER := 237;
constant octuplePrecision_ExponentWidth: INTEGER := 19;

constant float_octuple_precision :float_type := (octuplePrecision_SignificandWidth,  octuplePrecision_ExponentWidth);
```
floating point ALU opcodes:

```vhdl
constant opcode_adder 			:STD_LOGIC_VECTOR(2 DOWNTO 1) := "00";
constant opcode_subtracter  	:STD_LOGIC_VECTOR(2 DOWNTO 1) := "01";
constant opcode_multiplier  	:STD_LOGIC_VECTOR(2 DOWNTO 1) := "10";
```

</br>
</br>

<h4>components</h4>	

:memo: **Note:** Input floating point vectors must be normalized to the following format (using the fnormalization function): 
```vhdl        
MSB  [sign], [float_type(1): exponent], [float_type(2): sinificant]		LSB
```

<b>fadder</b>	    standard variable length floating point adder		(synthesizable)

```vhdl
component fadder
generic (
float_typedef :float_type := float_single_precision
);
port(
	X,Y	    :in STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1); --defined in std_arith.vhd
	outp	:out STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1) --defined in std_arith.vhd
);
end component;
```

</br>
</br>

<b>fmul</b>		standard variable length floating point multiplier	(synthesizable)

```vhdl
component fmul 
generic (
float_typedef :float_type := float_single_precision
);
port(
	X,Y		:in STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1); --defined in std_arith.vhd
	outp	:out STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1) := (others=>'0') --defined in std_arith.vhd
);
end component;
```
</br>
</br>
<b>Floating point ALU</b>

```vhdl
component float_alu 
generic (
float_typedef :float_type := float_single_precision
);
port(
	clk		 				: in  STD_LOGIC;
	nrst		 			: in  STD_LOGIC;
	opcode					: in  STD_LOGIC_VECTOR(2 DOWNTO 1);
	
	inp_ready				: out  STD_LOGIC := '0'; 
	inp_vld					: in  STD_LOGIC := '0'; 
	inp0_data, inp1_data	: in  STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1);--defined in std_arith.vhd
	
	outp_ready				: out STD_LOGIC := '0';--status 
	outp_data				: out STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1) := (others=>'0') --defined in std_arith.vhd
);
end component float_alu;
```
</br>
</br>


<h4>functions</h4>	
</br>

<b>to_vector:</b>   is used to convert a real number to a floating point vector (std float vector with type of the float_typedef).

```vhdl
FUNCTION to_vector( inp : real; constant float_typedef : float_type  ) RETURN STD_LOGIC_VECTOR ;
```
</br>
</br>

<b>to_real:</b>			converts floating point vector(std float vector with type of the float_typedef)  to a real number 

- input vector must be normalized
- note real type just suitable for the single precision float type 

```vhdl
FUNCTION to_real( inp : STD_LOGIC_VECTOR; constant float_typedef : float_type  ) RETURN real;
```
</br>
</br>

<b>to_float:</b>			converts to the floating point vector type

```vhdl
FUNCTION to_float( inp : STD_LOGIC_VECTOR;  sign : STD_LOGIC; constant float_typedef : float_type  ) RETURN STD_LOGIC_VECTOR ; -- unsigned input
FUNCTION to_float( inp : INTEGER;  constant float_typedef : float_type  ) RETURN STD_LOGIC_VECTOR; 
```
</br>
</br>
<b>to_integer</b> converts a floating point vector (std float vector with type of the float_typedef)  to an integer number.

- input vector must be normalized
- note real type just suitable for the single precision float type 


```vhdl
FUNCTION to_integer( inp : STD_LOGIC_VECTOR;  constant float_typedef : float_type  ) RETURN INTEGER;
```
</br>
</br>

<b>fnormalization:</b>      is a floating point normalizer 	(Used to convert non-standard floating point numbers to the standard representation for this library).

```vhdl
function fnormalization ( 
	inp		: STD_LOGIC_VECTOR;
	exponent 		: STD_LOGIC_VECTOR; 
	constant float_typedef :float_type := float_single_precision
) return STD_LOGIC_VECTOR;
```

IO Format:

```vhdl
output format => [normalized exponent(input exponent width), normalized sinificand(input sinificand width-1)] => example significand: "1001001001"(without normalization'1' bit)
input format =>  [carry bit, normalization bit,significand] => example: "00.1001001001"

```
</br>
</br>

<b>dec2vect</b>			converts the decimal part of a real number to the vector TYPE

```vhdl
FUNCTION dec2vect( dec : real   ) RETURN STD_LOGIC_VECTOR;
FUNCTION norm_dec2vect( dec : real; constant float_typedef : float_type )  RETURN STD_LOGIC_VECTOR; --(normalized output)
```
</br>
</br>

<b>dec_size</b>            calculates the size of the represented vector for decimal part of a floating-point number.

```vhdl
FUNCTION dec_size( dec : real   ) RETURN INTEGER ;
```
</br>
</br>

<b>vect_bias</b>			calculates bias value of the exponent in floating point numbers(output TYPE is STD_LOGIC_VECTOR) 

```vhdl
FUNCTION vect_bias( float_typedef :float_type  ) RETURN STD_LOGIC_VECTOR;
FUNCTION int_bias( float_typedef :float_type  ) RETURN INTEGER;
```
</br>
</br>
<b>absolute:</b>			used to calculate absolute value of a real or an integer number (internal usage).

```vhdl
FUNCTION absolute(L: real) return real ;
FUNCTION absolute(L: INTEGER) return INTEGER;
```
</br>
</br>

<h5>Floating point comparison:</h5>
</br>

Greater than: 

- param l, r:  floatiing point vector with type of the float_typedef.
- retval: true if l > r else false. 

```vhdl
FUNCTION gt( l : STD_LOGIC_VECTOR; r : STD_LOGIC_VECTOR;  constant float_typedef : float_type  ) RETURN BOOLEAN ;
FUNCTION gt( l : INTEGER; r : STD_LOGIC_VECTOR;  constant float_typedef : float_type  ) RETURN BOOLEAN ;
FUNCTION gt( l : STD_LOGIC_VECTOR; r : INTEGER;  constant float_typedef : float_type  ) RETURN BOOLEAN ;
```
Lower than: 

- param l, r:  floatiing point vector with type of the float_typedef.
- retval: true if l < r else false.
  
```vhdl
FUNCTION lt( l : STD_LOGIC_VECTOR; r : STD_LOGIC_VECTOR;  constant float_typedef : float_type  ) RETURN BOOLEAN ;
FUNCTION lt( l : INTEGER; r : STD_LOGIC_VECTOR;  constant float_typedef : float_type  ) RETURN BOOLEAN ;
FUNCTION lt( l : STD_LOGIC_VECTOR; r : INTEGER;  constant float_typedef : float_type  ) RETURN BOOLEAN ;
```
