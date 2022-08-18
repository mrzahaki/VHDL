----------------------------------------------------------------------------------
--the name of allah
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2020 11:04:17 AM
-- Design Name: 
-- Module Name: ac_com - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


USE work.std_type.ALL;
USE work.std_ac.ALL;
use work.std_delay.all;
use work.std_float.all;
use work.std_arith.all;


entity node_handler is
  generic(
		clock_frequency	: INTEGER := 10e6;
		single_node : ACNODE;
		float_typedef :float_type := float_double_precision
); Port (
	clk,nrst :IN STD_LOGiC;
	active_node :IN ACNODE;
	main_node:IN ACM;
	------------------------------------------------floating point section
	fp_request				: out  STD_LOGIC:='0';
	opcode					: out  STD_LOGIC_VECTOR(2 DOWNTO 1);
	
	inp_ready				: in  STD_LOGIC := '0'; 
	inp_vld					: out  STD_LOGIC := '0'; 
	inp0_data, inp1_data	: out  STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1);--defined in std_arith.vhd
	
	outp_ready				: in STD_LOGIC := '0';--status 
	outp_data				: in STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1) := (others=>'0'); --defined in std_arith.vhd
	------------------------------------------------
	sensor_com_vld :IN STD_LOGIC :='0';  
	sensor_com_data :IN SENSOR_DATA_TYPEDEF(1 to sub_node_detector(single_node.sens_obj.sensor));
	
	------------------------------------------END SENSOR COM
	
	-----------------------------------------actuator COM
	actuator_com_vld :OUT STD_LOGIC :='0';  --single_node number length
	actuator_com_data  :OUT DOUBLEPRECISION_ARRAY(1 to sub_node_detector(single_node.act_obj.actuator)) := SET_ZERO(sub_node_detector( single_node.act_obj.actuator ));--node0 ->[sens0, sens1,..],
	deactuator_com_data :OUT DOUBLEPRECISION_ARRAY(1 to sub_node_detector( single_node.act_obj.deactuator )) := SET_ZERO(sub_node_detector( single_node.act_obj.deactuator ))--node0 ->[sens0, sens1,..]
  
  );
end node_handler;

ARCHITECTURE structural OF node_handler IS
---------------------------------------- types ------------------------------------------- 
  TYPE NODE_STATE_TYPE IS(	power_up,
							sens_handler,
							data_handler_0,
							result_extract_0,
							data_handler_1,
							result_extract_1,
							data_handler_2,
							result_extract_2,
							node_handler,
							low_power_handler,
							act_handler );
							
	TYPE act_handler_arith_typedef IS(	data_preparation,
										data_handler_0,
										result_extract_0,
										data_handler_1,
										result_extract_1,
										main_result );
 -- TYPE ARITH_STATE IS(mul0 );

---------------------------------------- constants ------------------------------------------- 
  --define @mode_of_operation (write/read  instruction/data)

  CONSTANT SENSOR_NUMBERS :INTEGER := sensor_com_data'length;
  CONSTANT ACTUATOR_NUMBERS :INTEGER := actuator_com_data'length;
  CONSTANT DEACTUATOR_NUMBERS :INTEGER := deactuator_com_data'length;
  
  
  CONSTANT percent : STD_LOGIC_VECTOR( (float_typedef(1) + float_typedef(2) + 1) downto 1) := to_vector(0.01, float_typedef);
---------------------------------------- signals ------------------------------------------- 
  --state of operation
	SIGNAL  sensing_state  : NODE_STATE_TYPE;
	SIGNAL  act_handler_arith  : act_handler_arith_typedef;
	
	SIGNAL backup_actuator_com_data  : DOUBLEPRECISION_ARRAY(1 to ACTUATOR_NUMBERS) := SET_ZERO(ACTUATOR_NUMBERS);--node0 ->[sens0, sens1,..],
	SIGNAL backup_deactuator_com_data: DOUBLEPRECISION_ARRAY(1 to DEACTUATOR_NUMBERS) := SET_ZERO(DEACTUATOR_NUMBERS);--node0 ->[sens0, sens1,..]
  	-- SIGNAL delayed_vector_act	: boolean_vector(1 to ACTUATOR_NUMBERS):= (others=>false);
	-- SIGNAL delayed_vector_deact	: boolean_vector(1 to DEACTUATOR_NUMBERS):= (others=>false);
	--SIGNAL   tstvar0		: INTEGER RANGE 0 TO max(SENSOR_NUMBERS,ACTUATOR_NUMBERS + DEACTUATOR_NUMBERS);
	--SIGNAL instruction_delay	: boolean_vector(1 to SENSOR_NUMBERS):= (others=>false);
  ------------------------------------------------alias section -------------------------------------------
	--enable SIGNAL
	--alias en : STD_LOGIC is lcd_com(3);
 	

	--alias next_sensing_state  	:lcm_bus_modetype  is machine_com(3 downto 1);

		
----------------------------------------others-------------------------------------------
	--see  LCM_INIT_TYPEDEF definition
	--	alias ypos		   	:STD_LOGIC is machine_com(8); --row 0 or row 1
	--	alias xpos 			:STD_LOGIC_VECTOR(4 downto 1) is machine_com(7 downto 4);-- xpos between 0 to 15
		

---------------------------------------------------------------------------------
 BEGIN
  -----------------------------------------------------------------------------------first part
  output_cntrol:PROCESS(clk)
  
	variable delayed_vector_act	: boolean_vector(1 to ACTUATOR_NUMBERS):= (others=>false);
	variable delayed_vector_deact	: boolean_vector(1 to DEACTUATOR_NUMBERS):= (others=>false);
	VARIABLE aclk_count, daclk_count 			:  NATURAL:=0 ; 
  variable tmp:std_logic:='0';
  begin
  BIGIF:IF(clk'event and clk='1') THEN
  
	 aclk_count := aclk_count + 1; 
	 daclk_count := daclk_count + 1;
	delayed_vector_act := mdelay_machine_parallel(clock_frequency, aclk_count, to_integer_vector(active_node.act_obj.asettling_time, ACTUATOR_NUMBERS) );
	delayed_vector_deact := mdelay_machine_parallel(clock_frequency, daclk_count, to_integer_vector(active_node.act_obj.dasettling_time, DEACTUATOR_NUMBERS) );	 
	
	 act_reg:for i in delayed_vector_act'range loop
			if( delayed_vector_act(i) ) then 
				

				
				actuator_com_data(i) <=  backup_actuator_com_data(i);
				--check end of sensing operation
				--reset counter and ready to jump in next state
				if(i = indexof( to_integer_vector(active_node.act_obj.asettling_time, ACTUATOR_NUMBERS),
								max(to_integer_vector(active_node.act_obj.asettling_time, ACTUATOR_NUMBERS)),
								1 )
								) then
				if(active_node.id = 1)then 
					tmp:='0';
				end if;
				
				aclk_count := 0;
				end if;

			end if;			
		 end loop act_reg;
		 
		 
	 	 deact_reg:for i in delayed_vector_deact'range loop
			if( delayed_vector_deact(i) ) then 

				deactuator_com_data(i) <=  backup_deactuator_com_data(i);
				--check end of sensing operation
				--reset counter and ready to jump in next state
				if(i = indexof( to_integer_vector(active_node.act_obj.dasettling_time, DEACTUATOR_NUMBERS),
								max(to_integer_vector(active_node.act_obj.dasettling_time, DEACTUATOR_NUMBERS)),
								1 )
								) then
				
				if(active_node.id = 1)then 
					tmp:='0';
				end if;
				
				daclk_count := 0;
				end if;

			end if;			
		 end loop deact_reg;
	
	END IF BIGIF;
  end process output_cntrol;
  --------------------------------------------------------------------------------------second part
  
  PROCESS(clk)
	--event counter for timing
    VARIABLE clk_count 			: NATURAL:=0; 
	--In this section, we enter the required delays for each command separately and are finally processed by udelay_machine_serial_serial_serial_serial function.
	--specifically used in initialize section
	--CONSTANT instruction_delay_generator	: integer_vector(1 to 10) := (
	--	10, 50, 10, 50, 10, 2000, 10, 50, 10, 60	--us timing
	--);
	--specifically used in initialize section
	variable instruction_delay	: boolean_vector(1 to SENSOR_NUMBERS):= (others=>false);
	--temporary variable
	variable tmp_flag: BOOLEAN_VECTOR(1 to 2) :=(OTHERS=> true) ;
	variable tmp_int: integer range -1 to SENSOR_NUMBERS+1 ;
	
	
	variable counter0		: INTEGER RANGE 0 TO max(SENSOR_NUMBERS,ACTUATOR_NUMBERS + DEACTUATOR_NUMBERS);
	variable sens_counter	: INTEGER RANGE 1 TO SENSOR_NUMBERS+1;
	
	CONSTANT fp_buffer_len :integer:= max(SENSOR_NUMBERS,ACTUATOR_NUMBERS + DEACTUATOR_NUMBERS); 
	variable fp_buffer	: DOUBLEPRECISION_ARRAY(1 to fp_buffer_len) := SET_ZERO(fp_buffer_len);
	
	
	variable sensor_data_main : DOUBLEPRECISION_ARRAY(sensor_com_data'range) := SET_ZERO(sensor_com_data'length);
	variable act_command, deact_command : SUB_EFFICIENCY_VECT;
	variable fp_backup: DOUBLEPRECISION_ARRAY(2 downto 1):= SET_ZERO(2);
	
  BEGIN
	
		BIGIF:IF(nrst = '0') THEN
			sensing_state <= power_up;
			
			deact_command := 0;
			act_command := 0;
			fp_backup := SET_ZERO(fp_backup'length);
			sensor_data_main := SET_ZERO(sensor_data_main'length);
			fp_buffer := SET_ZERO(fp_buffer'length);
			counter0:= 0;
			tmp_flag:= (others=>true);
			clk_count:= 0;
			fp_request<= '0';
			inp_vld<= '0';
			act_handler_arith <= data_preparation;
			sensing_state <= sens_handler;
			inp1_data <=(others=>'0');
			inp0_data<=(others=>'0');
			 backup_actuator_com_data<= SET_ZERO(actuator_com_data'length);
			 backup_deactuator_com_data<= SET_ZERO(deactuator_com_data'length);			
	
    ELSIF(  (clk'event and clk='1')   ) THEN
	 	       --reset
	
	  --FSM machine
      CASE sensing_state IS
		
		  --lcd, efficiency suply startup delay 
        WHEN power_up =>

			  IF( delay_ms(clock_frequency, clk_count, POWERUP_DELAY) ) THEN    --wait 50 ms
				clk_count := clk_count + 1;
				sensing_state <= power_up;
			  ELSE                                       --efficiency-up complete
				clk_count := 0;
				sensing_state <= sens_handler;
				
			  END IF;
          
      
         --cycle through initialization sequence  
        WHEN sens_handler =>
			  
		 if(tmp_flag(1)) then  clk_count := clk_count + 1; end if;
		 instruction_delay := mdelay_machine_parallel(clock_frequency, clk_count, to_integer_vector(active_node.sens_obj.settling_time, SENSOR_NUMBERS) );
		 
		 for i in instruction_delay'range loop
			if( instruction_delay(i) ) then 

				if(sensor_com_vld = '1') then --put valid data on register
					sensor_data_main(i) := to_float(sensor_com_data(i), float_typedef);
					
					--check end of sensing operation
					--reset counter and ready to jump in next state
					if(i = indexof( to_integer_vector(active_node.sens_obj.settling_time, SENSOR_NUMBERS),
									max(to_integer_vector(active_node.sens_obj.settling_time, SENSOR_NUMBERS)),
									1 )
									) then
					
					clk_count := 0;
					sensing_state <= data_handler_0;
					counter0:=1;
					end if;
					
					tmp_flag(1) := true;
				--	if() need changed
				else--wait for valid data 
					tmp_flag(1) := false; 
					sensing_state <= sens_handler;
					--@status warning in sensor data
				end if;
			else 
				checkcount:if(clk_count /= 0) then
					sensing_state <= sens_handler;
				end if checkcount;
			end if;			
		 end loop;
		 

---------------------------------floating point calculations
		-- wi/100
		WHEN data_handler_0 =>
				
			fp_request <= '1';

			
			if(inp_ready='1')then 	
				inp0_data<= to_float( active_node.sens_obj.sensor_reliability(counter0), float_typedef);
				inp1_data<= percent;
				
				opcode<=opcode_multiplier;
				inp_vld<='1';
				fp_request<= '0';
				sensing_state <= result_extract_0;
			else
				inp_vld<='0';
			end if;
			
		
		 WHEN result_extract_0 =>
				
				if(outp_ready='1')then
					sensing_state <= data_handler_0; 
					fp_buffer(counter0) := outp_data; 
					if(counter0 = SENSOR_NUMBERS) then
						counter0 := 0;
						sensing_state <= data_handler_1; 
					end if;
					
					counter0 := counter0 + 1;
				end if;
		-- wi*xi
		 WHEN data_handler_1 =>

				
			fp_request <= '1';
			if(inp_ready='1')then 					
				inp0_data<= fp_buffer( counter0);
				inp1_data<= sensor_data_main(counter0);
				inp_vld<='1';
				fp_request<= '0';
				opcode<=opcode_multiplier;
				sensing_state <= result_extract_1;
				
			else
				inp_vld<='0';
			end if;

		 WHEN result_extract_1 =>
				if(outp_ready='1')then
					sensing_state <= data_handler_1; 
					fp_buffer(counter0) := outp_data; 
					if(counter0 = SENSOR_NUMBERS) then
						counter0 := 1;
						sensing_state <= data_handler_2; 
					end if;
					
					counter0 := counter0 + 1;
				end if;
		 -- Ewi*xi
		 WHEN data_handler_2 =>

				
			fp_request <= '1';
			if(inp_ready='1')then 					
				inp0_data<= fp_buffer( 1);
				inp1_data<= fp_buffer( counter0);
				inp_vld<='1';
				fp_request<= '0';
				opcode<=opcode_adder;
				sensing_state <= result_extract_2;
				
			else
				inp_vld<='0';
			end if;

		 WHEN result_extract_2 =>
				if(outp_ready='1')then
					sensing_state <= data_handler_2; 
					fp_buffer(1) := outp_data; 
					if(counter0 = SENSOR_NUMBERS) then
						counter0 := 0;
						sensing_state <= node_handler; 
					end if;
					
					counter0 := counter0 + 1;
				end if;
---------------------------------end floating point calculations fp_buffer(1) is final result
		 WHEN node_handler =>
						
			CASE active_node.time_obj.measurement_mode  IS
				
				WHEN OUTRANGE_METHOD =>
					
					-------------------------------------------------------
					IF(active_node.time_obj.control_mode =  ACT) THEN
						deact_command := 0;
						check_range:if(gt(fp_buffer(1), active_node.sens_obj.operating_range(1), float_typedef) and lt(fp_buffer(1), active_node.sens_obj.operating_range(2), float_typedef)) then
						--in range(un sAfe)
							check_backup:if( lt(fp_backup(1), fp_buffer(1), float_typedef)) then --from lower safe range to unsafe actuator must set to ON state
								-----------check operation mode
								check_op:if(main_node.operation_mode = TURBO) then
									act_command := 100;						
								elsif(main_node.operation_mode = NORMAL)then
									act_command := 80;
								else --SLEEP mode_of_operation
									act_command := 50;
								end if check_op;
									
							else  --from upper safe range to unsafe actuator must set to OFF state
								act_command:=0;
								
							end if check_backup;
							tmp_flag(2):= false;--lock backup action
							
						elsif( gt(fp_buffer(1), active_node.sens_obj.operating_range(2) + active_node.time_obj.gap_size, float_typedef)) then
								act_command:=0;
						else
							--handle gap range 		
							tmp_flag(2):= true;
						end if check_range;
					-------------------------------------------------------
					ELSIF(active_node.time_obj.control_mode =  DEACT) THEN 
						act_command := 0;
						check_range1:if(gt(fp_buffer(1), active_node.sens_obj.operating_range(1), float_typedef) and lt(fp_buffer(1), active_node.sens_obj.operating_range(2), float_typedef)) then
						--in range(un sAfe)
							check_backup1:if( gt(fp_backup(1), fp_buffer(1),float_typedef) ) then --from lower safe range to unsafe actuator must set to ON state
								-----------check operation mode
								check_op1:if(main_node.operation_mode = TURBO) then
									deact_command := 100;						
								elsif(main_node.operation_mode = NORMAL)then
									deact_command := 80;
								else --SLEEP mode_of_operation
									deact_command := 50;
								end if check_op1;	
								
							else  --from upper safe range to unsafe actuator must set to OFF state
								deact_command:=0;
								
							end if check_backup1;
							tmp_flag(2):= false;--lock backup action
							
						elsif( lt(fp_buffer(1), active_node.sens_obj.operating_range(1) - active_node.time_obj.gap_size, float_typedef)) then
								deact_command:=0;
						else 
							tmp_flag(2):= true;
						end if check_range1;
					-------------------------------------------------------	
					ELSE --ACT_DEACT
					
						check_range2:if(gt(fp_buffer(1), active_node.sens_obj.operating_range(1), float_typedef) and lt(fp_buffer(1), active_node.sens_obj.operating_range(2), float_typedef)) then
						--in range(un sAfe)
							check_backup2:if( gt(fp_backup(1), fp_buffer(1),float_typedef) ) then --from lower safe range to unsafe actuator must set to ON state
								--deact
								-----------check operation mode
								check_op2:if(main_node.operation_mode = TURBO) then
									deact_command := 100;						
								elsif(main_node.operation_mode = NORMAL)then
									deact_command := 80;
								else --SLEEP mode_of_operation
									deact_command := 50;
								end if check_op2;
									
								act_command:= 0;
								
							else  --from upper safe range to unsafe actuator must set to OFF state
									-----------check operation mode
								check_op3:if(main_node.operation_mode = TURBO) then
									act_command := 100;						
								elsif(main_node.operation_mode = NORMAL)then
									act_command := 80;
								else --SLEEP mode_of_operation
									act_command := 50;
								end if check_op3;

								deact_command:= 0;
							end if check_backup2;
							tmp_flag(2):= false;--lock backup action
							
						elsif( gt(fp_buffer(1), active_node.sens_obj.operating_range(2) + active_node.time_obj.gap_size, float_typedef) or lt(fp_buffer(1), active_node.sens_obj.operating_range(1) - active_node.time_obj.gap_size, float_typedef)) then
								act_command:=0;
								deact_command:=0;
						else											
							tmp_flag(2):= true;
						end if check_range2;
						
					END IF;
					
					if(tmp_flag(2)) then fp_backup(1) :=  fp_buffer(1);  end if;--backup pre sensed unit

--------------------------------------------					
				WHEN INRANGE_METHOD =>
										-------------------------------------------------------
					control_mode:IF(active_node.time_obj.control_mode =  ACT) THEN
						deact_command := 0;
						check_range3:if(lt(fp_buffer(1), active_node.sens_obj.operating_range(1), float_typedef)) then

							-----------check operation mode
							check_op4:if(main_node.operation_mode = TURBO) then
								act_command := 100;						
							elsif(main_node.operation_mode = NORMAL)then
								act_command := 80;
							else --SLEEP mode_of_operation
								act_command := 50;
							end if check_op4;		
							
						elsif( gt(fp_buffer(1), active_node.sens_obj.operating_range(1) + active_node.time_obj.gap_size, float_typedef)) then
							
							act_command:=0;
							
						end if check_range3;
						
						
					-------------------------------------------------------
					ELSIF(active_node.time_obj.control_mode =  DEACT) THEN 
						act_command := 0;
						check_range4:if(gt(fp_buffer(1), active_node.sens_obj.operating_range(2), float_typedef)) then

							-----------check operation mode
							check_op5:if(main_node.operation_mode = TURBO) then
								deact_command := 100;						
							elsif(main_node.operation_mode = NORMAL)then
								deact_command := 80;
							else --SLEEP mode_of_operation
								deact_command := 50;
							end if check_op5;		
							
						elsif( lt(fp_buffer(1), active_node.sens_obj.operating_range(2) - active_node.time_obj.gap_size, float_typedef)) then
							
							deact_command:=0;
							
						end if check_range4;
					-------------------------------------------------------	
					ELSE --ACT_DEACT
					
						
						check_range5:if(lt(fp_buffer(1), active_node.sens_obj.operating_range(1), float_typedef)) then

							-----------check operation mode
							check_op6:if(main_node.operation_mode = TURBO) then
								act_command := 100;						
							elsif(main_node.operation_mode = NORMAL)then
								act_command := 80;
							else --SLEEP mode_of_operation
								act_command := 50;
							end if check_op6;		
							
						elsif(gt(fp_buffer(1), active_node.sens_obj.operating_range(2), float_typedef)) then

							-----------check operation mode
							check_op7:if(main_node.operation_mode = TURBO) then
								deact_command := 100;						
							elsif(main_node.operation_mode = NORMAL)then
								deact_command := 80;
							else --SLEEP mode_of_operation
								deact_command := 50;
							end if check_op7;		
							
						elsif( lt(fp_buffer(1), active_node.sens_obj.operating_range(2) - active_node.time_obj.gap_size, float_typedef)) then
							
							act_command:=0;
							
						elsif( gt(fp_buffer(1), active_node.sens_obj.operating_range(1) + active_node.time_obj.gap_size, float_typedef)) then
							
							act_command:=0;
							
						end if check_range5;
						
					END IF control_mode;
----------------------------------------------------------					
				WHEN LPOINT_METHOD =>
				--just actuator
						deact_command := 0;
						check_range6:if(lt(fp_buffer(1), active_node.sens_obj.operating_point, float_typedef)) then

							-----------check operation mode
							check_op8:if(main_node.operation_mode = TURBO) then
								act_command := 100;						
							elsif(main_node.operation_mode = NORMAL)then
								act_command := 80;
							else --SLEEP mode_of_operation
								act_command := 50;
							end if check_op8;		
							
						elsif( gt(fp_buffer(1), active_node.sens_obj.operating_point + active_node.time_obj.gap_size, float_typedef)) then
							
							act_command:=0;
							
						end if check_range6;
						
----------------------------------------------------------					
				WHEN GPOINT_METHOD =>
						deact_command := 0;
						check_range7:if(gt(fp_buffer(1), active_node.sens_obj.operating_point, float_typedef)) then

							-----------check operation mode
							check_op9:if(main_node.operation_mode = TURBO) then
								act_command := 100;						
							elsif(main_node.operation_mode = NORMAL)then
								act_command := 80;
							else --SLEEP mode_of_operation
								act_command := 50;
							end if check_op9;		
							
						elsif( lt(fp_buffer(1), active_node.sens_obj.operating_point - active_node.time_obj.gap_size, float_typedef)) then
							
							act_command:=0;
							
						end if check_range7;
			END CASE;
			
			-----------check low power mode
			if(main_node.low_power_mode = ONN) then 
				sensing_state <= low_power_handler;
			else 
				
				sensing_state <= act_handler;
			end if ;
			counter0:= 1;
		
		 WHEN low_power_handler =>
			
         WHEN act_handler =>
			
			sensing_state <= act_handler;
			CASE act_handler_arith IS
			
			WHEN data_preparation =>
				IF(active_node.time_obj.control_mode =  ACT) THEN 
					fp_backup(2) := to_float( active_node.act_obj.actuator_efficiency(counter0), float_typedef);
					clk_count := ACTUATOR_NUMBERS;--max value;
				ELSIF(active_node.time_obj.control_mode =  DEACT) THEN 
					fp_backup(2) := to_float( active_node.act_obj.deactuator_efficiency(counter0), float_typedef);
					clk_count := DEACTUATOR_NUMBERS;--max value;
				ELSE --act/deact
					IF(clk_count< ACTUATOR_NUMBERS+1) THEN
						fp_backup(2) := to_float( active_node.act_obj.actuator_efficiency(counter0), float_typedef);
					ELSE
						fp_backup(2) := to_float( active_node.act_obj.deactuator_efficiency(counter0-ACTUATOR_NUMBERS), float_typedef);
					END IF;
					clk_count := DEACTUATOR_NUMBERS + ACTUATOR_NUMBERS;
				END IF;
				act_handler_arith <= data_handler_0;
				
			--wi/100
			WHEN data_handler_0 =>
				act_handler_arith <= data_handler_0;	
				fp_request <= '1';
				if(inp_ready='1')then 					
					inp0_data<= fp_backup(2);
					inp1_data<= percent;
					inp_vld<='1';
					fp_request<= '0';
					opcode<=opcode_multiplier;
					act_handler_arith <= result_extract_0;
					
				else
					inp_vld<='0';
				end if;
				
			
			 WHEN result_extract_0 =>
					if(outp_ready='1')then
						act_handler_arith <= data_preparation; 
						fp_buffer(counter0) := outp_data; 
						if(counter0 = clk_count) then
							counter0 := 0;
							act_handler_arith <= data_handler_1; 
						end if;
						
						counter0 := counter0 + 1;
					end if;
			-- wi*xi
			 WHEN data_handler_1 =>

				act_handler_arith <= data_handler_1;		
				fp_request <= '1';
				if(inp_ready='1')then 					
					inp0_data<= fp_buffer( counter0);
					
					IF(active_node.time_obj.control_mode =  ACT) THEN 
						inp1_data<= to_float(act_command, float_typedef);
					ELSIF(active_node.time_obj.control_mode =  DEACT) THEN 
						inp1_data<=to_float(deact_command, float_typedef);
					ELSE --act/deact
						IF(clk_count< ACTUATOR_NUMBERS+1) THEN
							inp1_data<= to_float(act_command, float_typedef);
						ELSE
							inp1_data<=to_float(deact_command, float_typedef);
						END IF;
					END IF;
					
					
					inp_vld<='1';
					fp_request<= '0';
					opcode<=opcode_multiplier;
					act_handler_arith <= result_extract_1;
					
				else
					inp_vld<='0';
				end if;

			 WHEN result_extract_1 =>
					if(outp_ready='1')then
						act_handler_arith <= data_handler_1; 
						fp_buffer(counter0) := outp_data; 
						if(counter0 = clk_count) then
							counter0 := 0;
							act_handler_arith <= main_result; 
						end if;
						
						counter0 := counter0 + 1;
					end if;
			
			WHEN main_result =>
				IF(active_node.time_obj.control_mode =  ACT) THEN 
					backup_actuator_com_data <= fp_buffer(1 to ACTUATOR_NUMBERS );
					
				ELSIF(active_node.time_obj.control_mode =  DEACT) THEN 
					backup_deactuator_com_data <= fp_buffer(1 to DEACTUATOR_NUMBERS );
				ELSE --act/deact
					backup_actuator_com_data <= fp_buffer(1 to ACTUATOR_NUMBERS );
					backup_deactuator_com_data <= fp_buffer(ACTUATOR_NUMBERS+1 to ACTUATOR_NUMBERS + DEACTUATOR_NUMBERS);

				END IF;
				act_handler_arith <= data_preparation;
				sensing_state <= sens_handler;
			END CASE;
	
       END CASE;    
  

	  
	
    END IF BIGIF;
	
  END PROCESS;
END structural;
