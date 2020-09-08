--------------------------------------------------------------------------------
--					in the name of allah
--
--
--
--
--		designer: 			hussein zahaki
--		library name : 		DROGRAMMER	
--   	FileName:         	std_lcm.vhd
--   	Dependencies:     	work.std_arith and std_logic_1164 and numeric_std and math_real
--		version: vhdl 2008(important)
--		compiled in INTEL QUARTUS and simulated with ISIM from XILINX ISE
--
--   	brief: Liquid crystal display(LCM) 2X16 driver with i8080(8 bit interface)  protocol 
--		important note: all of the components are synthesizable 
--		
--		
--		components:	(low level access)
--					- lcm_main		this component is the main Low level control center of other functions and procedures and works with a finite state machine. 
--					  				lcm_main controls low level operations,(such as) it handle input data from higher level units,
--					  				it parse gathered data to appropriate format and  manage LCD timing ,
--					  				lcm_main	 put data with desired format on bidirectional bus and etc. 
--					  				note that the execution of other functions and procedures depends on how this component works. 		
--					- bidir			standard bidirectional bus controller(Internal usage)	
--		 
--		functions:(mid level access)	
--					seed_breeding 	In fact, this function is an agriculture that monitors seed growth.
--										If we consider each 'UI' procedure as a seed, this function controls the timing and determines how each seed
--										accesses the clock gate, in fact, an implicit  state machine that is more understandable and flexible.(important)
--					to_std_logic		(Internal usage)
--					delay_us			(Internal usage)
--					delay_ms			(Internal usage)
---					udelay_machine		(Internal usage)
--					vector_event		(Internal usage)

-- 
--   UI	procedures:(higher level access)				
--				-lcm_init			lcm 2X16 initialization, 			
-- 				-lcm_character		send character to lcm 2X16
--				-lcm_instruction	send instruction to lcm 2X16	
-- 				-lcm_gotoxy			set coordinate of cursor.
-- 				-lcm_string			send string( array of characters )(string TYPE) to lcm 2X16	
--				-lcm_delay			This function is used to create a proper delay in the display workflow without compromising the performance.
--				-note you can use delay and create animations on lcm display.
-- 
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all; 
use ieee.MATH_REAL.all; 
use work.std_arith.all;




 
package std_lcm is

--maximus number of @UI_PROCEDURES 
CONSTANT MAX_WORK_LIST_LENGTH : INTEGER := 50;
--with this TYPE you can define seed object
SUBTYPE SEED_TYPEDEF is INTEGER range 0 to MAX_WORK_LIST_LENGTH;

--------------------------------------------------------------------------------(internal usage)
SHARED VARIABLE impure_cntr: SEED_TYPEDEF := 0;---------------------------------(internal usage)
SHARED VARIABLE impure_backup_flag: STD_LOGIC_VECTOR(1 to 3) := (others=>'1');--(internal usage)
SHARED VARIABLE impure_delay_cntr :NATURAL := 0;--------------------------------(internal usage)
--------------------------------------------------------------------------------(internal usage)
--main types used to communicate with lcd
SUBTYPE LCM_I8080_DATATYPE	is STD_LOGIC_VECTOR(8 downto 1);
--LCM_COM_DATATYPE foormat : (msb) lcd enable, read/write, data/setup pin
SUBTYPE LCM_COM_DATATYPE	is STD_LOGIC_VECTOR(3 downto 1);


-------------------------------------------------------------(internal usage)
SUBTYPE LCM_BUS_TYPE	is STD_LOGIC_VECTOR(12 downto 1);
SUBTYPE lcm_bus_datatype	is STD_LOGIC_VECTOR(8 downto 1);
--see @initialization_constants
SUBTYPE lcm_bus_modetype	is STD_LOGIC_VECTOR(3 downto 1);
TYPE boolean_vector	is array(NATURAL range<>) of BOOLEAN;
-------------------------------------------------------------(internal usage)



-------------------------------------------------------------(internal usage)
--note use this constants for first initialization of lcm_main 
CONSTANT LCD_BUS_INIT_MODE : lcm_bus_modetype := "001";
CONSTANT LCD_BUS_INSTRUCTION_MODE : lcm_bus_modetype := "010";
CONSTANT LCD_BUS_DATA_MODE : lcm_bus_modetype := "011";
CONSTANT LCD_BUS_DELAY_MODE : lcm_bus_modetype := "100";
-------------------------------------------------------------(internal usage)

--@initialization_constants 
SUBTYPE LCM_INIT_TYPEDEF	is STD_LOGIC_VECTOR(2 downto 1);
--used in lcm_init @UI_PROCEDURE

--@initialization_lines_size_control
CONSTANT LCD_INIT_2ROW_5X7 : LCM_INIT_TYPEDEF := "10";
CONSTANT LCD_INIT_1ROW_5X7 : LCM_INIT_TYPEDEF := "00";
CONSTANT LCD_INIT_1ROW_5X10 : LCM_INIT_TYPEDEF := "01";
--@initialization_cursor_blink_control
CONSTANT LCD_INIT_CURSOR_BLINK		: LCM_INIT_TYPEDEF := "11";
CONSTANT LCD_INIT_CURSOR_NO_BLINK	: LCM_INIT_TYPEDEF := "10";
CONSTANT LCD_INIT_NO_CURSOR_NO_BLINK: LCM_INIT_TYPEDEF := "00";
--@initialization_shift_cntrol
CONSTANT LCD_INIT_INC_SHIFT 	: LCM_INIT_TYPEDEF := "11";
CONSTANT LCD_INIT_INC_NOSHIFT	: LCM_INIT_TYPEDEF := "10";
CONSTANT LCD_INIT_DEC_SHIFT		: LCM_INIT_TYPEDEF := "01";
CONSTANT LCD_INIT_DEC_NOSHIFT	: LCM_INIT_TYPEDEF := "00";
--------------------------------------------------------------------


--lcm useful instructions 
--used in lcm_init @UI_PROCEDURE
--note use this CONSTANT for sending actual @instruction into lcd
CONSTANT LCD_CMD_FLUSH_DISPLAY	         : LCM_I8080_DATATYPE :=     x"00";
CONSTANT LCD_CMD_CLEAR_DISPLAY	         : LCM_I8080_DATATYPE :=     x"01";
CONSTANT LCD_CMD_CURSOR_HOME		     : LCM_I8080_DATATYPE :=     x"02";

-- Cursor and display shift
CONSTANT LCD_CMD_ENTRY_MODE_DEC_NOSHIFT  : LCM_I8080_DATATYPE :=   x"04";
CONSTANT LCD_CMD_ENTRY_MODE_DEC_SHIFT    : LCM_I8080_DATATYPE :=   x"05";
CONSTANT LCD_CMD_ENTRY_MODE_INC_NOSHIFT  : LCM_I8080_DATATYPE :=   x"06";
CONSTANT LCD_CMD_ENTRY_MODE_INC_SHIFT    : LCM_I8080_DATATYPE :=   x"07";

-- Display control
CONSTANT LCD_CMD_DISPLAY_OFF             : LCM_I8080_DATATYPE :=   x"08";
CONSTANT LCD_CMD_DISPLAY_NO_CURSOR       : LCM_I8080_DATATYPE :=   x"0c";
CONSTANT LCD_CMD_DISPLAY_CURSOR_NO_BLINK : LCM_I8080_DATATYPE :=   x"0E";
CONSTANT LCD_CMD_DISPLAY_CURSOR_BLINK    : LCM_I8080_DATATYPE :=   x"0F";

-- Cursor and display shift
CONSTANT LCD_CMD_DISPLAY_NOSHIFT_CUR_LEFT  : LCM_I8080_DATATYPE := x"10";
CONSTANT LCD_CMD_DISPLAY_NOSHIFT_CUR_RIGHT : LCM_I8080_DATATYPE := x"14";
CONSTANT LCD_CMD_DISPLAY_SHIFT_LEFT        : LCM_I8080_DATATYPE := x"18";
CONSTANT LCD_CMD_DISPLAY_SHIFT_RIGHT       : LCM_I8080_DATATYPE := x"1C";

-- FUNCTION set
CONSTANT LCD_CMD_4BIT_1ROW_5X7             : LCM_I8080_DATATYPE := x"20";
CONSTANT LCD_CMD_4BIT_1ROW_5X10            : LCM_I8080_DATATYPE := x"24";
CONSTANT LCD_CMD_4BIT_2ROW_5X7             : LCM_I8080_DATATYPE := x"28";
CONSTANT LCD_CMD_8BIT_1ROW_5X7             : LCM_I8080_DATATYPE := x"30";
CONSTANT LCD_CMD_8BIT_1ROW_5X10            : LCM_I8080_DATATYPE := x"34";
CONSTANT LCD_CMD_8BIT_2ROW_5X7             : LCM_I8080_DATATYPE := x"38";

-------------------------------------------------------------------functions
-- mid level section
IMPURE FUNCTION seed_breeding(nencom:STD_LOGIC; works_number:INTEGER; CONSTANT loop_form : BOOLEAN := false ) RETURN SEED_TYPEDEF ;
FUNCTION to_std_logic(  l: INTEGER ) RETURN STD_LOGIC;
FUNCTION delay_us(CONSTANT clk_freq : INTEGER; clk_count : INTEGER; delay: INTEGER  ) RETURN BOOLEAN ;
FUNCTION delay_ms(  CONSTANT clk_freq : INTEGER; clk_count : INTEGER; delay: INTEGER  ) RETURN BOOLEAN;
FUNCTION udelay_machine(CONSTANT clk_freq : NATURAL; clk_count : NATURAL; delays: integer_vector  ) RETURN boolean_vector;
FUNCTION vector_event( vect : STD_LOGIC_VECTOR; backup_vect : STD_LOGIC_VECTOR  ) RETURN STD_LOGIC;
--------------------------------------------------------------------@UI_PROCEDURES 
-- high level section


-- brief: lcm_init used for initialization of lcm display with additional control parameters( control on shift number, AC counter, cursor, font and size of display.)
PROCEDURE lcm_init (
	nencom					: in  STD_LOGIC;	--control main com buss
    SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	seed					: in  SEED_TYPEDEF;
	
	-- see @initialization_constants
	shift_cntrol 			: in LCM_INIT_TYPEDEF; --@initialization_shift_cntrol 
	cursor_blink_control	: in LCM_INIT_TYPEDEF; --@initialization_cursor_blink_control
	lines_size_control		: in LCM_INIT_TYPEDEF; --@initialization_lines_size_control
	CONSTANT work_id 		: in INTEGER
    );

-- brief: lcm_character sends a single character to lcm display
PROCEDURE lcm_character (
	nencom					: in  STD_LOGIC;	--control main com buss
    SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	seed					: in  SEED_TYPEDEF;
	param 				: in character; --parameters of initialization
	CONSTANT work_id 		:in INTEGER
    
	);
-- brief: lcm_instruction sends a single instruction to lcm display
PROCEDURE lcm_instruction (
	SIGNAL  nencom			: in  STD_LOGIC;	--control main com buss
    SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	seed					: in  SEED_TYPEDEF;
	param 				: in LCM_I8080_DATATYPE; 	--param instruction see @instruction in std_lcm
    CONSTANT work_id 		:in INTEGER
	);
-- brief: lcm_instruction sends a single instruction to lcm display(overloading)
PROCEDURE lcm_instruction (
	SIGNAL  nencom			: in  STD_LOGIC;	--control main com buss
    SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	--param instruction see @instruction in std_lcm
	param 				: in LCM_I8080_DATATYPE --parameters of initialization
	);
--set coordinate of cursor with x,y parameters.	
 PROCEDURE lcm_gotoxy (
	SIGNAL  nencom			: in  STD_LOGIC;	--control main com buss
    SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	seed					: in  SEED_TYPEDEF;
	x_coordinate 				: in INTEGER range 0 to 15; --parameters of initialization
	y_coordinate 				: in INTEGER range 0 to 1; --parameters of initialization
    CONSTANT work_id 		:in INTEGER
	);
	
--send string( array of characters )(string TYPE) to lcm 2X16	
PROCEDURE lcm_string (
	SIGNAL  nencom			: in  STD_LOGIC;	--control main com buss
    SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	seed					: in  SEED_TYPEDEF;
	--param format: string
	param 				: in string; --parameters of initialization
	CONSTANT work_id 		:in INTEGER
	);
	
	
--This function is used to create a proper delay in the display workflow without compromising the performance.
--Note that in this method the delay is caused by the internal units of the library.
PROCEDURE lcm_delay (
	SIGNAL  nencom			: in  STD_LOGIC;	--control main com buss
	SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	seed					: in  SEED_TYPEDEF;
	--enable signal used to call other sub programs or components during idle time 
	-- enable = '0' => lcm operations is suspended(in idle time), and we can do another operation during delay time 
	SIGNAL enable			:out STD_LOGIC;
	delay					:in INTEGER;
	clk_freq 				:in	INTEGER;
	CONSTANT work_id 		:in INTEGER
    
	);
	
--wait for event on enable signal
    PROCEDURE lcm_wait_for (
	SIGNAL  nencom			: in  STD_LOGIC;	--control main com buss
	SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	seed					: in  SEED_TYPEDEF;
	enable					:in BOOLEAN; --edge =  1 racing edge
	CONSTANT work_id 		:in INTEGER
);    
		
	
	
--------------------------------------------------------------------components
-- low level section



component lcm_main
  GENERIC(
    clk_freq       		:  INTEGER    := 10000000    --system clock frequency in Hz
); 
  PORT(
 	---------------------------------------------------inner signals
	--system clock, reset_lcm_main
    clk, nrst: IN   		STD_LOGIC; --clock, reset, enable write on machine_com port('1')(requset to write on lcd)
	
	--main command format is: [ MSB[8 bit additional data][3 bit mode selector]LSB ] (in mode(read))
	machine_com: in		LCM_BUS_TYPE;
	nencom 	: out STD_LOGIC;	--enable com with acive low(busy flag)
	---------------------------------------------------LCD signals
    --(msb) lcd enable, read/write, data/setup pin
	lcd_com    	: out  		LCM_COM_DATATYPE;        
	--data signals for lcd in buffer mode
    lcd_data   	: inout  	LCM_I8080_DATATYPE	

);
END component;
-----------------------------------------------------------------------
component bidir 
    PORT(
        bidir   : INOUT LCM_I8080_DATATYPE;
        enwrite, clk : IN STD_LOGIC;
        inp     : IN LCM_I8080_DATATYPE;
        outp    : OUT LCM_I8080_DATATYPE
		);
END component;

end std_lcm;


