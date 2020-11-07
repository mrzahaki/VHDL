--in the name of allah

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.Numeric_Std.ALL;
--LIBRARY drogrammer;
--use drogrammer.std_lcm.ALL;

use work.std_ac.ALL;
use work.std_lcm.ALL;
use work.std_float.ALL;
use work.std_type.ALL;
use work.std_arith.all;
use work.std_delay.all;

--bidirectional bus controller 
--if oe = 1 input mode (write on bus)
--if oe = 0 output mode (read from bus)
ENTITY sm_top IS
PORT(
--LCD COM PORTS
lcd_com    	:OUT LCM_COM_DATATYPE ;        
lcd_data   	:INOUT LCM_I8080_DATATYPE
);
END sm_top;

ARCHITECTURE sim OF sm_top IS
------------------------------------------------------------COMONENT DEF

constant clock_frequency: integer := 10e6;
constant clock_period: time := 1000ms/clock_frequency;


------------------------------------------------------------Node 1 Temperature
CONSTANT sen_vect : SENSOR_TYPEDEF(1 to 3) := (T1, T2, T3);
CONSTANT sen_time : SETTLING_TIME_TYPEDEF(1 to 3) := (9, 15, 5);
CONSTANT op_range :OPERATING_RANGE_TYPEDEF := (-150, 100);
CONSTANT sensor_reliability :EFFICIENCY_VECT(1 to 3) := (60, 15, 25);


CONSTANT act_vect : ACT_TYPEDEF(1 to 3) := (ACT1,ACT2 , ACT3);
CONSTANT asettling_time : SETTLING_TIME_TYPEDEF(1 to 3) := (10,20 , 17);
CONSTANT actuator_efficiency : EFFICIENCY_VECT(1 to 3) := (23,21, 26);

CONSTANT deact_vect : DEACT_TYPEDEF(1 to 3) := (DACT1,DACT2 , DACT3);
CONSTANT deactuator_efficiency : EFFICIENCY_VECT(1 to 3) := (20,50 , 30);
CONSTANT dasettling_time : SETTLING_TIME_TYPEDEF(1 to 3) := (6,10 ,7);

CONSTANT measurement_mode : MEASUREMENT_TYPEDEF := INRANGE_METHOD ;
CONSTANT control_mode : CONTROL_MODE_TYPEDEF := ACT_DEACT;
CONSTANT efficiency_exception: efficiency_EXCEPT_TYPEDEF(1 to 2) := ( (-150, -100, 70), (200, 250, 90) );


--range method
CONSTANT temp :ACNODE := ( sens_obj => (
								sensor=>to_sens(sen_vect),
								settling_time=>to_sens(sen_time),
								operating_range=>op_range,
								operating_point => 0,
								sensor_reliability => to_sens(sensor_reliability)
							),act_obj=>(
								actuator =>to_act(act_vect),
								actuator_efficiency =>to_act(actuator_efficiency),
								asettling_time =>to_act(asettling_time),
								deactuator =>to_act(deact_vect),
								deactuator_efficiency =>to_act(deactuator_efficiency),
								dasettling_time =>to_act(dasettling_time)
							),time_obj=>(
								measurement_mode=>measurement_mode,
								control_mode=> control_mode,
								efficiency_exception_range_method=>to_tim(efficiency_exception),
								gap_size=>8),
								ID=>2);
------------------------------------------------------------END Node 1 Temperature
------------------------------------------------------------Node 2 Humidity
CONSTANT sen_vect1 : SENSOR_TYPEDEF(1 to 4) := (H1, H2, H3,H4);
CONSTANT sen_time1 : SETTLING_TIME_TYPEDEF(1 to 4) := (5,7,4,3);--(100, 750, 510, 450);
--CONSTANT op_range1 :OPERATING_RANGE_TYPEDEF := (0, 500);
CONSTANT sensor_reliability1 :EFFICIENCY_VECT(1 to 4) := (35, 40, 10, 15);


CONSTANT act_vect1 : ACT_TYPEDEF(1 to 2) := (ACT4,ACT5);
CONSTANT asettling_time1 : SETTLING_TIME_TYPEDEF(1 to 2) := (15,17 );
CONSTANT actuator_efficiency1 : EFFICIENCY_VECT(1 to 2) := (62, 38);

-- CONSTANT deact_vect1 : DEACT_TYPEDEF(1 to 3) := (DACT4, DACT5, DACT6);
-- CONSTANT deactuator_efficiency1 : EFFICIENCY_VECT(1 to 3) := (80, 15, 60);
-- CONSTANT dasettling_time1 : INTEGER_VECTOR(1 to 3) := (19200, 500, 6600);

CONSTANT measurement_mode1 : MEASUREMENT_TYPEDEF := GPOINT_METHOD ;
CONSTANT control_mode1 : CONTROL_MODE_TYPEDEF := ACT;
CONSTANT efficiency_exception1: efficiency_EXCEPT_TYPEDEF(1 to 2) := ( (70, 90, 80), (90, 100, 100) );


--range method
CONSTANT humid :ACNODE := ( sens_obj => (
								sensor=>to_sens(sen_vect1),
								settling_time=>to_sens(sen_time1),
								operating_range=> (others=>0),
								operating_point => 65,
								sensor_reliability => to_sens(sensor_reliability1)
							),act_obj=>(
								actuator =>to_act(act_vect1),
								actuator_efficiency =>to_act(actuator_efficiency1),
								asettling_time =>to_act(asettling_time1),
								deactuator =>(others=>NONE),
								deactuator_efficiency =>(others=>0),
								dasettling_time =>(others=>0)
							),time_obj=>(
								measurement_mode=>measurement_mode1,
								control_mode=> control_mode1,
								efficiency_exception_range_method=>to_tim(efficiency_exception1),
								gap_size=>10),
							ID => 1
							);
------------------------------------------------------------END Node 2 Humidity

------------------------------------------------------------MAIN NODE
SIGNAL main :ACM := (	admin_password=>84265,
						bootloader=> OFF,
						low_power_mode=> OFF,
						operation_mode=> NORMAL,
						Control_gate_mode=>	SECURE_GUI	);


------------------------------------------------------------END MAIN NODE

-------------------------------------------------------------other definitions
CONSTANT nodes :NODE_VECTOR(1 TO 2) := (humid, temp);


----------------------------------------------------------------SIGNAL 
SIGNAL clk, nrst:STD_LOGIC := '0';

 -- SIGNAL fres0, fres1:STD_LOGIC_VECTOR(64 downto 1);
-- -- SIGNAL tst0:STD_LOGIC_VECTOR(8 downto 1) := "00100010";
 -- --SIGNAL tst1:STD_LOGIC_VECTOR(8 downto 1) := "10110111";
 -- SIGNAL f0,f1:boolean;
-- SIGNAL fint:INTEGER;

	-- SIGNAL	fopcode					:   STD_LOGIC_VECTOR(2 downto 1);
	-- SIGNAL	finp_ready				:   STD_LOGIC := '0'; 
	-- SIGNAL	finp_vld				:   STD_LOGIC := '0'; 
	-- SIGNAL	finp0_data, finp1_data	:   doublePrecision_type;
	-- SIGNAL	foutp_ready				:  STD_LOGIC := '0';--status 
	-- SIGNAL	foutp_data				: doublePrecision_type;


signal tst: integer_vector(4 downto 1);

--COM BUS
SIGNAL main_ac_com_enable		: STD_LOGIC ;
SIGNAL main_data_com		: AC_BUS_TYPE ;
SIGNAL main_com_request_to_boot	: STD_LOGIC;

SIGNAL sensor_com_vld : STD_LOGIC_VECTOR(1 to  node_detector(nodes)) := (others=>'1') ;  --node number length
SIGNAL	sensor_com_data : SENSOR_DATA_TYPEDEF(1 to sensor_detector(nodes));

SIGNAL	actuator_com_vld : STD_LOGIC_VECTOR(1 to  node_detector(nodes));  --node number length
SIGNAL	actuator_com_data : DOUBLEPRECISION_ARRAY(1 to actuator_detector(nodes));--node0 ->[sens0, sens1,..], node1->[..sens n, sens n+1, ...]
	
SIGNAL	deactuator_com_data : DOUBLEPRECISION_ARRAY(1 to deactuator_detector(nodes));--node0 ->[sens0, sens1,..], node1->[..sens n, sens n+1, ...]


SIGNAL instruction_delay	: boolean_vector(1 to 4);


BEGIN                  
	FA0:ac_main	generic map(clock_frequency, to_node( nodes)) port map(
			clk=> clk,
			nrst=> nrst,
			main_node => main,
			
			------------------------------------------UI SECTION
			--2X16 LCD
			lcd_com=> lcd_com,        
			--data signals for lcd in buffer mode
			lcd_data=> lcd_data,

			----------------------------------------COM SECTION
			ac_request_to_boot	=>	main_com_request_to_boot,
			ac_data_com	=> main_data_com ,	
			n_ac_com_enable => main_ac_com_enable,	
			----------------------------------------sensor
			sensor_com_vld		=> sensor_com_vld,
			sensor_com_data		=> sensor_com_data,
			
			actuator_com_vld	=> actuator_com_vld,
			actuator_com_data	=> actuator_com_data,
			deactuator_com_data	=> deactuator_com_data
		);


    clk <= not clk after clock_period/2;
	nrst<= '0', '1' after clock_period;
	sensor_com_vld(1) <= not sensor_com_vld(1) after 10000*clock_period;
	sensor_com_vld(2) <= not sensor_com_vld(2) after 40000*clock_period;
		--tst<=to_integer_vector(humid.sens_obj.settling_time, 4);
	  --fres0 <= to_vector( 0.078,float_double_precision);
	  --fres1 <= to_float(3,float_double_precision );
	 --f0 <=  gt(3, fres0, float_double_precision);
	 --f1 <=  lt(3, fres0, float_double_precision);
	-- f0 <=  to_real(foutp_data, float_double_precision) ;
	-- fint<= to_integer(foutp_data, float_double_precision);
	
	    -- FA2: float_alu generic map( 	float_double_precision 	)	port map(
		-- clk=>clk, 
		-- nrst => nrst,
		-- opcode=>fopcode,
		-- inp_ready=>	finp_ready,
		-- inp_vld	=>	finp_vld,			
		-- inp0_data=>fres0,
		-- inp1_data=>fres1,
		-- outp_ready	=>foutp_ready,		
		-- outp_data	=>foutp_data		
	-- );
	
	
	-- process
	-- begin
	-----------------------------first check
		-- wait for 1ms;
		-- --humid CONSTANT sensor_reliability1 :EFFICIENCY_VECT(1 to 4) := (35, 40, 10, 15);
		-- sensor_com_data <= (67, 70, 85, 57, 10, 25, 6);
		
	
	-- end process;
	
	
	-- PROCESS(clk)
		
		-- VARIABLE clk_count 			: NATURAL := 0; 
		-- VARIABLE prs_tst 			: INTEGER := 0; 
		-- VARIABLE pre_instruction_delay, backup_vector	: boolean_vector(1 to 4);
	-- BEGIN  
	-- BIGIF:IF(  (clk'event and clk='1')  ) THEN
	-- clk_count:= clk_count+1;
	-- instruction_delay <= mdelay_machine_parallel(clock_frequency, clk_count, to_integer_vector(humid.sens_obj.settling_time, 4) );
	
	
	-- if( instruction_delay(1) ) then
		-- prs_tst:=2;
		
		-- end if;
		
	-- if( instruction_delay(2) ) then
		-- prs_tst:=4;
		-- end if;
	
	-- if( instruction_delay(3) ) then
		-- prs_tst:=6;
		-- end if;
	
	-- if( instruction_delay(4) ) then
		-- prs_tst:=8;
	-- end if;
	
	
	--prs_tst := indexof( to_integer_vector(humid.sens_obj.settling_time, 4), max(to_integer_vector(humid.sens_obj.settling_time, 4)), -1 );
	
	-- END IF BIGIF;
	-- END PROCESS;
END sim;


--end with the name of allah