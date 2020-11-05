--------------------------------------------------------------------------------
--					in the name of allah
--
--
--		designer: 			hussein zahaki
--		library name : 		DROGRAMMER	
--   	FileName:         	std_lcm_comp.vhd
--   	Dependencies:     	std_lcm.vhdl, std_logic_1164, std_arith(see it)
--		version: vhdl 2008(important)
--		breif : components declaration
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

use work.std_lcm.all;

--bidirectional bus controller 
--if oe = 1 input mode (write on bus)
--if oe = 0 output mode (read from bus)
ENTITY bidir IS
    PORT(
        bidir   : INOUT LCM_I8080_DATATYPE;
        enwrite, clk : IN STD_LOGIC;
        inp     : IN LCM_I8080_DATATYPE;
        outp    : OUT LCM_I8080_DATATYPE
		);
END bidir;

ARCHITECTURE maxpld OF bidir IS
SIGNAL  a  : STD_LOGIC_VECTOR (7 DOWNTO 0) := (others=>'0');  -- DFF that stores 
                                             -- value from input.
SIGNAL  b  : STD_LOGIC_VECTOR (7 DOWNTO 0) := (others=>'0');  -- DFF that stores 
BEGIN                                        -- feedback value.
    PROCESS(clk)
    BEGIN
    IF clk = '1' AND clk'EVENT THEN  -- Creates the flipflops
        a <= inp;                    
        outp <= b;                  
        END IF;
    END PROCESS;    
	 
    PROCESS (a, b, enwrite, bidir)          -- Behavioral representation 
        BEGIN                    -- of tri-states.
        IF( enwrite = '0') THEN
            bidir <= "ZZZZZZZZ";
            b <= bidir;
        ELSE
            bidir <= a; 
            b <= bidir;
        END IF;
    END PROCESS;
END maxpld;

-------------------------------------------------------------------------
-- standard Liquid Crystal Module or LCM  Module(components section)
--	protocol i8080(8 bit interface)
--	Liquid Crystal Module or LCD Module (LCM)
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.std_lcm.all;
use work.std_arith.all;
use work.std_delay.ALL;
use work.std_type.all;

ENTITY lcm_main IS
  GENERIC(
    clk_freq       		:  INTEGER    := 10e6    --system clock frequency in Hz
); 
  PORT(
 	---------------------------------------------------inner signals
	--system clock, reset_lcm_main
    clk, nrst: IN   		STD_LOGIC; --clock, reset, enable write on machine_com port('1')(requset to write on lcd)
	
	--main command format is: [ MSB[8 bit additional data][3 bit mode selector]LSB ] (in mode(read))
	machine_com: in		LCM_BUS_TYPE := (others=>'0');
	nencom 	: out STD_LOGIC := '1';	--enable com with acive low(busy flag)
	---------------------------------------------------LCD signals
    --(msb) lcd enable, read/write, data/setup pin
	lcd_com    	: out  		LCM_COM_DATATYPE := (others=>'0');        
	--data signals for lcd in buffer mode
    lcd_data   	: inout  	LCM_I8080_DATATYPE	

);
END lcm_main;

ARCHITECTURE structural OF lcm_main IS
---------------------------------------- types ------------------------------------------- 
  TYPE CONTROL IS( efficiency_up, idle, initialize, busy_check, write_instruction, WriteData);
  
---------------------------------------- constants ------------------------------------------- 
  --define @mode_of_operation (write/read  instruction/data)
  --LCM_COM_DATATYPE format: [enwrite2data, rw, rs]
  CONSTANT LCM_MODE_BUS_WRITE_INSTRUCTION :LCM_COM_DATATYPE := "100";
  CONSTANT LCM_MODE_BUS_WRITE_DATA :LCM_COM_DATATYPE := "101";  
  CONSTANT LCM_MODE_BUS_READ :LCM_COM_DATATYPE := "010";  
  
  --control machine_com port with nencom input pin
  CONSTANT machine_com_close : STD_LOGIC:= '1';--busy mode
  CONSTANT machine_com_open : STD_LOGIC:= '0';--read from it
---------------------------------------- signals ------------------------------------------- 
  --state of operation
  SIGNAL  state  : CONTROL;
  --enable write on lcd_data input/output pin
  SIGNAL enwrite2data : STD_LOGIC;
  -- with this signals and enwrite2data we can control our lcd_data bus
  SIGNAL data_read, data_write :LCM_I8080_DATATYPE;
  -- format: [ enwrite2data, rw, rs] 
  -- see @mode_of_operation
  SIGNAL lcm_bus_state : LCM_COM_DATATYPE;
  
  SIGNAL backup_data : lcm_bus_datatype := (others=>'0') ;
 
  ------------------------------------------------alias section -------------------------------------------
	--enable SIGNAL
	alias en : STD_LOGIC is lcd_com(3);
 	
	--Lcm main com format is: [ MSB[6 bit additional data][2 bit mode selector]LSB ] (in mode(read))	
	--determine next state
	--SIGNAL control_signal
	
	alias next_state  	:lcm_bus_modetype  is machine_com(3 downto 1);
	-------------------------------------------------------------------------
	------------------------------------------------------------------
	--------------------------------------------------------
	--------------------------------------------------
	----------------------------------------------
	------------------------------------------
	-- In this section, we break the Machine_com port in different parts according to the working mode
	alias machine_com_data_Part :  lcm_bus_datatype is machine_com(11 downto 4);
	
	--first initialize mode
	--see  LCM_INIT_TYPEDEF definition
	
	alias as_shift_cntrol		   	:LCM_INIT_TYPEDEF is backup_data(6 downto 5);
	alias as_display_cursor_blink 	:LCM_INIT_TYPEDEF is backup_data(4 downto 3);
	alias as_display_lines_size  	:LCM_INIT_TYPEDEF  is backup_data(2 downto 1);
	
	-- write_instruction & write_data states
	alias as_data	:LCM_I8080_DATATYPE is backup_data(8 downto 1);
	

		
----------------------------------------others-------------------------------------------
	--see  LCM_INIT_TYPEDEF definition
	--	alias ypos		   	:STD_LOGIC is machine_com(8); --row 0 or row 1
	--	alias xpos 			:STD_LOGIC_VECTOR(4 downto 1) is machine_com(7 downto 4);-- xpos between 0 to 15
		
  
 BEGIN
  -----------------------------------------------------------------------------------first part
 enwrite2data <= lcm_bus_state(3);
 lcd_com(2 downto 1) <= lcm_bus_state(2 downto 1);
 ----------------------------------------
 --bidirectional bus controller instance
 FA0: bidir PORT map(
        bidir 	=> lcd_data,
        enwrite	=> enwrite2data,
		clk 	=> clk,
        inp 	=> data_write,
        outp 	=> data_read 
		);
  --------------------------------------------------------------------------------------second part
  
  PROCESS(clk, data_read, data_write)
	--event counter for timing
    VARIABLE clk_count 			: NATURAL := 0; 
	--In this section, we enter the required delays for each command separately and are finally processed by udelay_machine_serial function.
	--specifically used in initialize section
	CONSTANT instruction_delay_generator	: integer_vector(1 to 10) := (
		10, 50, 10, 50, 10, 2000, 10, 50, 10, 60	--us timing
	);
	--specifically used in initialize section
	variable instruction_delay	: boolean_vector(instruction_delay_generator'range);
	--temporary variable
	variable tmp: STD_LOGIC :='0' ;
	
	variable backup_vector : LCM_BUS_TYPE := machine_com;
	
  BEGIN
    BIGIF:IF(  (clk'event and clk='1')  ) THEN
	  --FSM machine
      CASE state IS
	  
         WHEN idle =>
		 
			nencom <= machine_com_open;
			tmp := vector_event(machine_com, backup_vector);
			IF(tmp='1') then
			
				backup_data <= machine_com_data_Part;
				
				IF(next_state = LCD_BUS_INIT_MODE) then	
					state <= initialize;
					nencom <= machine_com_close;
					
				ELSIF(next_state = LCD_BUS_DATA_MODE) then	
					state <= WriteData;
					nencom <= machine_com_close;
					
				ELSIF(next_state = LCD_BUS_INSTRUCTION_MODE) then
					state <= write_instruction;
					nencom <= machine_com_close;
				ELSIF(next_state = LCD_BUS_DELAY_MODE) then
					state <= idle;
					nencom <= machine_com_close;
		
				END IF;
				
			ELSE
				state <= idle;
			END IF;
		 
        --lcd, efficiency suply startup delay 
        WHEN efficiency_up =>
			  nencom <= machine_com_close;
			  IF( delay_ms(clk_freq, clk_count, 10 )) THEN    --wait 50 ms
				clk_count := clk_count + 1;
				state <= efficiency_up;
			  ELSE                                       --efficiency-up complete
				lcm_bus_state <= LCM_MODE_BUS_WRITE_INSTRUCTION;
				data_write <= (data_write'range =>'0');
				clk_count := 0;
				state <= idle;
				
			  END IF;
          
         --cycle through initialization sequence  
         WHEN initialize =>
			  lcm_bus_state <= LCM_MODE_BUS_WRITE_INSTRUCTION;
			  
			  clk_count := clk_count + 1;
			  instruction_delay := udelay_machine_serial(clk_freq, clk_count, instruction_delay_generator);
			 
			  IF( instruction_delay(1) ) THEN       --function set
				data_write <= "0011" & as_display_lines_size & "00";--2bit
				en <= '1';
				state <= initialize;
			  ELSIF( instruction_delay(2) ) THEN    --wait 50 us
				data_write <= LCD_CMD_FLUSH_DISPLAY; en <= '0';   state <= initialize;
				
			  ELSIF( instruction_delay(3) ) THEN    --display off
				data_write <= LCD_CMD_DISPLAY_OFF;
				en <= '1';
				state <= initialize;
			  ELSIF( instruction_delay(4) ) THEN   --wait 50 us
				data_write <= LCD_CMD_FLUSH_DISPLAY;  en <= '0'; state <= initialize;
				
			  ELSIF( instruction_delay(5) ) THEN   --display clear
				data_write <= LCD_CMD_CLEAR_DISPLAY;
				en <= '1';
				state <= initialize;
			  ELSIF( instruction_delay(6) ) THEN  --wait 2 ms
				data_write <= LCD_CMD_FLUSH_DISPLAY;   en <= '0'; state <= initialize;
				
			  ELSIF( instruction_delay(7) ) THEN    --display on/off control
				data_write <= "000011" & as_display_cursor_blink; --2bit
				en <= '1';
				state <= initialize;
			  ELSIF( instruction_delay(8) ) THEN   --wait 50 us
				data_write <= LCD_CMD_FLUSH_DISPLAY;   en <= '0'; state <= initialize;
				
			  ELSIF( instruction_delay(9) ) THEN  --entry mode set
				data_write <= "000001" & as_shift_cntrol; --2bit
				en <= '1';
				state <= initialize;
			  ELSIF( instruction_delay(10) ) THEN  --wait 60 us
				data_write <= LCD_CMD_FLUSH_DISPLAY;   en <= '0'; state <= initialize;
				
			  ELSE                                       --initialization complete
				clk_count := 0;
				state <= idle;
			  END IF;    

         --wait for lcd to completing  operation
         WHEN busy_check =>
			  IF( delay_us(clk_freq, clk_count, 10) ) THEN	--10us delay
				lcm_bus_state <= LCM_MODE_BUS_READ; en <= '1';
				state <= busy_check;
				clk_count := clk_count + 1;
			  ELSE
				tmp := '0';--data_read(8);
				en <= '0';
				clk_count := 0;
					IF(tmp = '1') then
						state <= busy_check;
					ELSIF(tmp = '0') then
						state <= idle;
						lcm_bus_state <= LCM_MODE_BUS_WRITE_INSTRUCTION;
						
					END IF;
			  END IF;
		 -- --             	  
         --send instruction to lcd        
         WHEN write_instruction =>			
			clk_count := clk_count + 1;
			IF( delay_us(clk_freq, clk_count, 2) ) THEN	--50us delay
			
				lcm_bus_state <= LCM_MODE_BUS_WRITE_INSTRUCTION; en <= '1';
				data_write <= as_data;
			ELSE
				data_write <= LCD_CMD_FLUSH_DISPLAY;
				en <= '0';
				state <= busy_check;
				clk_count := 0;			
			end if;
			

		 WHEN WriteData =>			
			clk_count := clk_count + 1;
			IF( delay_us(clk_freq, clk_count, 2) ) THEN	--50us delay
			
				lcm_bus_state <= LCM_MODE_BUS_WRITE_DATA; en <= '1';
				data_write <= as_data;		
			else
				en <= '0';
				state <= busy_check;
				clk_count := 0;		
			end if;
			
       END CASE;    
  
       --reset
       IF(nrst = '0') THEN
           state <= efficiency_up;
       END IF;
	   
    backup_vector := machine_com; --take backup
	
    END IF BIGIF;
	
  END PROCESS;
END structural;
--the name of AlLaH