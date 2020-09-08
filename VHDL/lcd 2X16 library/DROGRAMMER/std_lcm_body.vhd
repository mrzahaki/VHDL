--------------------------------------------------------------------------------
--					in the name of allah
--
--
--		designer: 			hussein zahaki
--		library name : 		DROGRAMMER	
--   	FileName:         	std_lcm_body.vhd
--   	Dependencies:     	std_lcm.vhdl(see it)
--		version: vhdl 2008(important)
--------------------------------------------------------------------------------
PACKAGE BODY STD_LCM IS

--must be called in inifinite loop(process with clock)
  PROCEDURE lcm_init (
	nencom					: in  STD_LOGIC;	--control main com buss
    SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	seed					: in  SEED_TYPEDEF;

	shift_cntrol 			: in LCM_INIT_TYPEDEF; --parameters of initialization
	cursor_blink_control	: in LCM_INIT_TYPEDEF;
	lines_size_control		: in LCM_INIT_TYPEDEF;
	CONSTANT work_id 		: in INTEGER
    ) is
	
	CONSTANT bus_isready :STD_LOGIC:= '0';
	CONSTANT bus_isbusy :STD_LOGIC:= '1';
  begin
	IF(seed = work_id) then
		IF(nencom = bus_isready) then
			--write on bus from 
			machine_com <= impure_backup_flag(2)&"00"&shift_cntrol& cursor_blink_control& lines_size_control & LCD_BUS_INIT_MODE;
		END IF;
	END IF;
	
  END PROCEDURE lcm_init;
  ---------------------------------------- 
    PROCEDURE lcm_character (
	nencom					: in  STD_LOGIC;	--control main com buss
    SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	seed					: in  SEED_TYPEDEF;
	--param format: [MSB][shift_cntrol, display_cursor_blink, display_lines_size][LSB]
	param 				: in character; --parameters of initialization
	CONSTANT work_id 		:in INTEGER
    
	) is
	CONSTANT bus_isready :STD_LOGIC:= '0';
	CONSTANT bus_isbusy :STD_LOGIC:= '1';
  begin
	IF(seed = work_id) then	
		IF(nencom = bus_isready) then
			--write on bus from 
			machine_com <= impure_backup_flag(1) & STD_LOGIC_VECTOR( to_unsigned( character'pos(param),  LCM_I8080_DATATYPE'length) ) & LCD_BUS_DATA_MODE;
	END IF;
	END IF;
	
  END PROCEDURE lcm_character;
   ---------------------------------------- 
    PROCEDURE lcm_instruction (
	SIGNAL  nencom			: in  STD_LOGIC;	--control main com buss
    SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	seed					: in  SEED_TYPEDEF;
	--param instruction see @instruction in std_lcm
	param 				: in LCM_I8080_DATATYPE; --parameters of initialization
    CONSTANT work_id 		:in INTEGER
	) is
	CONSTANT bus_isready :STD_LOGIC:= '0';
	CONSTANT bus_isbusy :STD_LOGIC:= '1';
  begin
  
	IF(seed = work_id) then
		IF(nencom = bus_isready) then
		--write on bus from 
		machine_com <= impure_backup_flag(2) & param & LCD_BUS_INSTRUCTION_MODE;
	END IF;
	END IF;
	
  END PROCEDURE lcm_instruction;
     ---------------------------------------- 
    PROCEDURE lcm_instruction (
	SIGNAL  nencom			: in  STD_LOGIC;	--control main com buss
    SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	--param instruction see @instruction in std_lcm
	param 				: in LCM_I8080_DATATYPE --parameters of initialization
	) is
	CONSTANT bus_isready :STD_LOGIC:= '0';
	CONSTANT bus_isbusy :STD_LOGIC:= '1';
  begin
  
		IF(nencom = bus_isready) then
		--write on bus from 
		machine_com <= impure_backup_flag(2) & param & LCD_BUS_INSTRUCTION_MODE;
	END IF;
	
  END PROCEDURE lcm_instruction;
   ---------------------------------------- 
    PROCEDURE lcm_gotoxy (
	SIGNAL  nencom			: in  STD_LOGIC;	--control main com buss
    SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	seed					: in  SEED_TYPEDEF;
	--param instruction see @instruction in std_lcm
	x_coordinate 				: in INTEGER range 0 to 15; --parameters of initialization
	y_coordinate 				: in INTEGER range 0 to 1; --parameters of initialization
    CONSTANT work_id 		:in INTEGER
	) is
	CONSTANT bus_isready :STD_LOGIC:= '0';
	CONSTANT bus_isbusy :STD_LOGIC:= '1';
  begin
  
	IF(seed = work_id) then
		--write on bus from 
		lcm_instruction(nencom, machine_com, '1' & to_std_logic(y_coordinate) & "00"& STD_LOGIC_VECTOR( to_unsigned(x_coordinate, 4)));
	END IF;
	
  END PROCEDURE lcm_gotoxy;
   ---------------------------------------- 
   
    PROCEDURE lcm_string (
	SIGNAL  nencom			: in  STD_LOGIC;	--control main com buss
    SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	seed					: in  SEED_TYPEDEF;
	--param format: string
	param 				: in string; --parameters of initialization
	CONSTANT work_id 		:in INTEGER
    
	) is
	CONSTANT bus_isready :STD_LOGIC:= '0';
	CONSTANT bus_isbusy :STD_LOGIC:= '1';
  begin
	IF(seed = work_id) then	
		IF(impure_backup_flag(2) /= nencom and nencom = bus_isready) then
			--write on bus from 
			impure_backup_flag(2) := nencom;
			impure_delay_cntr := impure_delay_cntr +1;
			machine_com <= to_std_logic(impure_delay_cntr mod 2) & STD_LOGIC_VECTOR( to_unsigned( character'pos(param(impure_delay_cntr)),  LCM_I8080_DATATYPE'length) ) & LCD_BUS_DATA_MODE;
			IF(impure_delay_cntr+1 > param'length) then
				impure_delay_cntr := 0 ;
			END IF;
			
		else 
			impure_backup_flag(2) := nencom;
		END IF;
	END IF;
  END PROCEDURE lcm_string;
     ---------------------------------------- 
   
    PROCEDURE lcm_delay (
	SIGNAL  nencom			: in  STD_LOGIC;	--control main com buss
	SIGNAL machine_com 		: out  LCM_BUS_TYPE; --LCD main com bus
	seed					: in  SEED_TYPEDEF;
	--enable signal used to call other sub programs or components during idle time 
	-- enable = '0' => lcm operations is suspended, and we can do another operation during delay time 
	SIGNAL enable			:out STD_LOGIC;
	delay					:in INTEGER;
	clk_freq 				:in	INTEGER;
	CONSTANT work_id 		:in INTEGER
    
	) is
	CONSTANT bus_isready :STD_LOGIC:= '0';

  begin
	IF(seed = work_id) then	
		
		
		IF(not delay_ms(clk_freq, impure_delay_cntr, delay) and nencom =  bus_isready)then 
			machine_com(lcm_bus_modetype'high downto lcm_bus_modetype'low) <= LCD_BUS_DELAY_MODE;
			impure_delay_cntr := 0; 
			impure_backup_flag(3) := '0';
			
		elsif(impure_backup_flag(3) = '1')  then 
			impure_delay_cntr := impure_delay_cntr + 1;
		END IF;
		
	END IF;
  END PROCEDURE lcm_delay;
  ---------------------------------------- 
   --wait for event on signal
   PROCEDURE lcm_wait_for (
		SIGNAL  nencom			: in  STD_LOGIC;	--control main com buss
		SIGNAL machine_com 	: out  LCM_BUS_TYPE; --LCD main com bus
		seed						: in  SEED_TYPEDEF;
		enable					:in BOOLEAN; --edge =  1 racing edge
		CONSTANT work_id 		:in INTEGER
		
	) is
	CONSTANT bus_isready :STD_LOGIC:= '0';

  begin
	IF(seed = work_id) then	
	
	
		IF(enable and nencom = bus_isready ) then

			machine_com(lcm_bus_modetype'high downto lcm_bus_modetype'low) <= LCD_BUS_DELAY_MODE;

		END IF;
		
	END IF;
  END PROCEDURE lcm_wait_for;

----------------------------------------

impure FUNCTION seed_breeding(nencom:STD_LOGIC; works_number:INTEGER; CONSTANT loop_form : BOOLEAN := false ) RETURN SEED_TYPEDEF is
	CONSTANT bus_isready :STD_LOGIC:= '0';
begin
	
	IF(impure_backup_flag(1) /= nencom and nencom = bus_isready and impure_delay_cntr = 0) then	--event detection
		impure_backup_flag(1) := nencom;
		IF(impure_cntr > works_number) then 
			
			IF(loop_form) then impure_cntr := 0;
			END IF;
			
			return impure_cntr;
		else
			impure_cntr := impure_cntr + 1;
			return impure_cntr;
		END IF;
		
	else 
		impure_backup_flag(1) := nencom;
		return impure_cntr;
	END IF;
	
END FUNCTION;
----------------------------------------.
FUNCTION to_std_logic(  l: INTEGER ) RETURN STD_LOGIC is
begin
	IF( l = 0 ) then 
		return '0';
	else 
		return '1';
	END IF;
END FUNCTION;
----------------------------------------

----------------------------------------
FUNCTION vector_event( vect : STD_LOGIC_VECTOR; backup_vect : STD_LOGIC_VECTOR  ) RETURN STD_LOGIC is
	variable res: BOOLEAN := false;
begin
	IF(vect = backup_vect)	then return '0';
	else return '1';
	END IF;

END FUNCTION;
----------------------------------------
FUNCTION delay_ms(  CONSTANT clk_freq : INTEGER; clk_count : INTEGER; delay: INTEGER  ) RETURN BOOLEAN is

begin

	--seprating INTEGER and real part
	return clk_count < (delay *  INTEGER(real(clk_freq)/1.0e3));		--(delay* clk/1000)/clk = delay(ms)

END FUNCTION;
-- ------------------------------------------------------------------------------
FUNCTION delay_us(CONSTANT clk_freq : INTEGER; clk_count : INTEGER; delay: INTEGER  ) RETURN BOOLEAN is

begin

	--seprating INTEGER and real part
	return clk_count < (delay *  INTEGER(real(clk_freq)/1.0e6));		--(delay* clk/1000)/clk = delay(ms)

END FUNCTION;
-- ------------------------------------------------------------------------------
--micro second delay generator machine
FUNCTION udelay_machine(CONSTANT clk_freq : NATURAL; clk_count : NATURAL; delays: integer_vector  ) RETURN boolean_vector is
 variable ret_vect :boolean_vector(delays'range);
 CONSTANT delay_vector :integer_vector(delays'range) := accumulate(delays);
begin
	
	l0:for i in delays'low to delays'high loop
		ret_vect(i) :=  delay_us(clk_freq, clk_count, delay_vector(i));		
	END loop l0;
	
return ret_vect;

END FUNCTION;
-- ------------------------------------------------------------------------------
-- --mili second delay generator machine
-- FUNCTION mdelay_machine(CONSTANT clk_freq : NATURAL; clk_count : NATURAL; delays: integer_vector  ) RETURN boolean_vector is
 -- variable ret_vect :boolean_vector(delays'range);
 -- CONSTANT delay_vector :integer_vector(delays'range) := accumulate(delays);
-- begin
	
	-- l0:for i in delays'low to delays'high loop
		-- ret_vect(i) :=  delay_ms(clk_freq, clk_count, delay_vector(i));		
	-- END loop l0;
	
-- return ret_vect;

-- END FUNCTION;
-- ------------------------------------------------------------------------------
END STD_LCM;
--------------------------------------------------------------------
