--in the name of allah

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all; 
--use ieee.MATH_REAL.all;
USE work.std_keypad.ALL;
USE work.std_lcm.ALL;
 use work.std_type.all;
  use work.std_float.all;

PACKAGE STD_AC IS
------------------------------------type definition----------------------------------------
TYPE SPOPERATING_RANGE_TYPEDEF	is array(1 to 2) of INTEGER;
--type integer_vector is  array (NATURAL range <>) of integer ;

------------------------------------end type definition------------------------------------



------------------------------------@basictypedef group definition-----------------------------------------------
--max 15 bit
CONSTANT MAX_SENSOR_NUMBER :INTEGER := 10;
--max 15 bit
CONSTANT MAX_ACTUATOR_NUMBER :INTEGER := 10;
--max of minimum amd max must be lower than 16 bit
CONSTANT MAX_AMBIENT_OPERATING_RANGE : SPOPERATING_RANGE_TYPEDEF := (-300, 400); 
--32 bit
CONSTANT MAX_NODES : INTEGER := 5;
CONSTANT MAX_efficiency_EXCEPTION_NUMBER : INTEGER := 3;
--max 17bit
CONSTANT MAX_SETTLING_TIME : INTEGER := 100000;
CONSTANT POWERUP_DELAY : INTEGER := 5;--ms + 4000ms(graphic interface) + depend on bias mode 

--This is an example of different types of sensosrs (you can define your own types)
--define your own types after NONE type(important)(dont try to change it)
TYPE SENSOR_SUBTYPEDEF	is (NONE, RTD, THERMOCOUPLE, NTC, PTC, T1, T2, T3, H1, H2, H3, H4);
--
TYPE ACT_SUBTYPEDEF  is (NONE, ACT1, ACT2, ACT3, ACT4, ACT5);
TYPE DEACT_SUBTYPEDEF  is (NONE, DACT1, DACT2, DACT3, DACT4,DACT5,DACT6);
SUBTYPE ADMIN_PASSWORD_TYPEDEF IS NATURAL;
------------------------------------end @basictypedef group definition-----------------------------------------------


------------------------------------type definition------------------------------------
SUBTYPE NODE_ID_TYPEDEF  IS INTEGER range 0 TO MAX_NODES;
--
SUBTYPE COM_BUS_TYPEDEF  IS STD_LOGIC_VECTOR(32 DOWNTO 1);
--
TYPE SUB_efficiency_EXCEPT_TYPEDEF	is array(1 TO 3) of INTEGER;
--
SUBTYPE OPERATING_POINT_TYPEDEF  IS INTEGER RANGE MAX_AMBIENT_OPERATING_RANGE(1) TO MAX_AMBIENT_OPERATING_RANGE(2);
--
TYPE OPERATING_RANGE_TYPEDEF	is array(1 to 2) of OPERATING_POINT_TYPEDEF;
--
TYPE SENSOR_DATA_TYPEDEF		IS ARRAY( NATURAL RANGE<>) OF  OPERATING_POINT_TYPEDEF;
--
SUBTYPE SUB_EFFICIENCY_VECT  IS INTEGER RANGE 0 TO 100;
TYPE EFFICIENCY_VECT	is array(NATURAL range<>) of SUB_EFFICIENCY_VECT;
--																	
TYPE BOOLEAN_VECT	is array(NATURAL range<>) of INTEGER;
--
TYPE SENSOR_TYPEDEF	is array (NATURAL RANGE<>) OF SENSOR_SUBTYPEDEF;
--
TYPE ACT_TYPEDEF	is array (NATURAL RANGE<>) OF ACT_SUBTYPEDEF;
--
TYPE DEACT_TYPEDEF	is array (NATURAL RANGE<>) OF DEACT_SUBTYPEDEF;
--
TYPE efficiency_EXCEPT_TYPEDEF is array (NATURAL RANGE<>) OF SUB_efficiency_EXCEPT_TYPEDEF;
--
SUBTYPE WATCHDOG_TYPEDEF IS INTEGER RANGE 0 TO INTEGER'high;
--
TYPE MEASUREMENT_TYPEDEF	is (GPOINT_METHOD, LPOINT_METHOD, INRANGE_METHOD, OUTRANGE_METHOD); --set true in range
--
TYPE CONTROL_MODE_TYPEDEF	is (ACT, DEACT, ACT_DEACT);
--
TYPE OPERATION_MODE_TYPEDEF IS (TURBO, NORMAL, SLEEP);
--
TYPE STATE_TYPEDEF IS (ONN, OFF);
--
TYPE SETTLING_TIME_TYPEDEF IS ARRAY( NATURAL RANGE<> ) OF INTEGER RANGE 0 TO MAX_SETTLING_TIME;
--
TYPE CONTROL_GATE_TYPE IS (SECURE, GUI, SECURE_GUI);
--
SUBTYPE AC_BUS_TYPE	is STD_LOGIC_VECTOR(41 downto 1);
--
SUBTYPE ac_bus_datatype	is STD_LOGIC_VECTOR(32 downto 1);
--see @initialization_constants
SUBTYPE ac_bus_modetype	is STD_LOGIC_VECTOR(8 downto 1);
-------------------------------CONSTANT------------------------------
CONSTANT MEASUREMENT_TYPEDEF_MODE_INRANGE_METHOD : ac_bus_datatype := x"00000001";
CONSTANT MEASUREMENT_TYPEDEF_MODE_OUTRANGE_METHOD : ac_bus_datatype := x"00000002";
CONSTANT MEASUREMENT_TYPEDEF_MODE_LPOINT_METHOD : ac_bus_datatype := x"00000003";
CONSTANT MEASUREMENT_TYPEDEF_MODE_GPOINT_METHOD : ac_bus_datatype := x"00000004";

CONSTANT CONTROL_MODE_TYPEDEF_ACT		 	 : ac_bus_datatype := x"00000001";
CONSTANT CONTROL_MODE_TYPEDEF_DEACT			 : ac_bus_datatype := x"00000002";	
CONSTANT CONTROL_MODE_TYPEDEF_ACT_DEACT		 : ac_bus_datatype := x"00000003";

--sensor device record
TYPE ACSENS	IS RECORD 
	
	sensor : SENSOR_TYPEDEF(1 TO MAX_SENSOR_NUMBER); -- detect type and number of sensors
	settling_time: SETTLING_TIME_TYPEDEF(1 TO MAX_SENSOR_NUMBER); --ms
	operating_range: OPERATING_RANGE_TYPEDEF;
	operating_point: OPERATING_POINT_TYPEDEF;
	sensor_reliability: EFFICIENCY_VECT(1 TO MAX_SENSOR_NUMBER);
	
END RECORD ACSENS;
------------------------------
--actuator device record
--active high actuators
TYPE ACACT	IS RECORD 
	
	actuator : ACT_TYPEDEF(1 TO MAX_ACTUATOR_NUMBER);  -- detect type and number of heaters
	actuator_efficiency: EFFICIENCY_VECT(1 TO MAX_ACTUATOR_NUMBER); 
	asettling_time: SETTLING_TIME_TYPEDEF(1 TO MAX_ACTUATOR_NUMBER); --ms
	
	deactuator : DEACT_TYPEDEF(1 TO MAX_ACTUATOR_NUMBER);  -- detect type and number of heaters
	deactuator_efficiency: EFFICIENCY_VECT(1 TO MAX_ACTUATOR_NUMBER); 
	dasettling_time: SETTLING_TIME_TYPEDEF(1 TO MAX_ACTUATOR_NUMBER); --ms
	
END RECORD ACACT;
--
TYPE ACT_VECT IS ARRAY(NATURAL RANGE<>) OF ACACT;
------------------------------
--air conditioner timing record
TYPE ACTIME	IS RECORD 
	
--	watchdog     : WATCHDOG_TYPEDEF;
	measurement_mode  : MEASUREMENT_TYPEDEF; 
	control_mode : CONTROL_MODE_TYPEDEF;
    efficiency_exception_range_method : efficiency_EXCEPT_TYPEDEF(1 TO MAX_efficiency_EXCEPTION_NUMBER);
	gap_size	: OPERATING_POINT_TYPEDEF;--depends on measurement unit
END RECORD ACTIME;

------------------------------
--standard air conditioner node
--static
 TYPE ACNODE	IS RECORD 
 
	sens_obj : ACSENS;	--sensor object
	act_obj :  ACACT;	--actuator object
	time_obj : ACTIME;
	ID		 : NODE_ID_TYPEDEF;
 END RECORD ACNODE;
 
--
TYPE NODE_VECTOR IS ARRAY(NATURAL RANGE<>) OF ACNODE;
--
TYPE NODE_PORT IS ARRAY(1 TO MAX_NODES) OF ACNODE;
--
----------------------------
--standard air conditioner main node
--dynamic
TYPE ACM IS RECORD 
	
	operation_mode : OPERATION_MODE_TYPEDEF;
	low_power_mode : STATE_TYPEDEF;
	bootloader    : STATE_TYPEDEF; --wait for uart to send input initialization data
	admin_password : ADMIN_PASSWORD_TYPEDEF;
	Control_gate_mode : CONTROL_GATE_TYPE;
END RECORD ACM;

------------------------------------end type definition------------------------------------



------------------------------------constant definition




------------------------------------function definition
--FUNCTION node_sensing(constant node : ACNODE ) RETURN  INTEGER;
FUNCTION node_detector (nodes : NODE_PORT) RETURN INTEGER ;
FUNCTION node_detector (nodes : NODE_VECTOR) RETURN INTEGER ;
FUNCTION sub_node_detector (sens : SENSOR_TYPEDEF) RETURN INTEGER ;
FUNCTION sub_node_detector (deact : DEACT_TYPEDEF) RETURN INTEGER;
FUNCTION sub_node_detector (act : ACT_TYPEDEF) RETURN INTEGER ;
FUNCTION sensor_detector (nodes : NODE_PORT) RETURN INTEGER ;
FUNCTION sensor_detector (nodes : NODE_VECTOR) RETURN INTEGER;
FUNCTION actuator_detector (nodes : NODE_PORT) RETURN INTEGER ;
FUNCTION deactuator_detector (nodes : NODE_PORT) RETURN INTEGER;
FUNCTION actuator_detector (nodes : NODE_VECTOR) RETURN INTEGER;
FUNCTION deactuator_detector (nodes : NODE_VECTOR) RETURN INTEGER ;

FUNCTION to_sens (vct : SENSOR_TYPEDEF) RETURN SENSOR_TYPEDEF;
FUNCTION to_sens (vct : INTEGER_VECTOR) RETURN INTEGER_VECTOR;
FUNCTION to_sens (vct : SETTLING_TIME_TYPEDEF) RETURN SETTLING_TIME_TYPEDEF;
FUNCTION to_sens (vct : EFFICIENCY_VECT) RETURN EFFICIENCY_VECT;

FUNCTION to_act (vct : ACT_TYPEDEF) RETURN ACT_TYPEDEF;
FUNCTION to_act (vct : DEACT_TYPEDEF) RETURN DEACT_TYPEDEF;
FUNCTION to_act (vct : INTEGER_VECTOR) RETURN INTEGER_VECTOR;
FUNCTION to_act (vct : SETTLING_TIME_TYPEDEF) RETURN SETTLING_TIME_TYPEDEF;
FUNCTION to_act (vct : EFFICIENCY_VECT) RETURN EFFICIENCY_VECT;
FUNCTION to_integer_vector (vct : SETTLING_TIME_TYPEDEF; out_length:INTEGER) RETURN integer_vector ;

--FUNCTION to_float( inp : OPERATING_POINT_TYPEDEF;  constant float_typedef : float_type  ) RETURN STD_LOGIC_VECTOR;

FUNCTION to_tim (vct : efficiency_EXCEPT_TYPEDEF) RETURN efficiency_EXCEPT_TYPEDEF;

FUNCTION to_node (vct : NODE_VECTOR) RETURN NODE_PORT;
FUNCTION node_slice (vct : NODE_PORT; final_length: INTEGER) RETURN NODE_VECTOR ;
-------------------------





------------------------------------procedure definition



------------------------------------component definition
COMPONENT node_handler 
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
	actuator_com_data  :OUT DOUBLEPRECISION_ARRAY(1 to sub_node_detector(single_node.act_obj.actuator));--node0 ->[sens0, sens1,..],
	deactuator_com_data :OUT DOUBLEPRECISION_ARRAY(1 to sub_node_detector( single_node.act_obj.deactuator ))--node0 ->[sens0, sens1,..]
  
  );
end COMPONENT node_handler;
-----------------------
COMPONENT ac_main 
generic(
	clock_frequency	: INTEGER := 10e6;
	nodes : NODE_PORT;
	float_typedef :float_type := float_double_precision
);port(
	clk,nrst :IN STD_LOGiC;
	--main nodes
	main_node:IN ACM;
	
	------------------------------------------UI SECTION
	--2X16 LCD
	lcd_com    	:OUT LCM_COM_DATATYPE ;        
	--data signals for lcd in buffer mode
    lcd_data   	: INOUT  	LCM_I8080_DATATYPE;

	------------------------------------------END UI SECTION
	
	
	----------------------------------------COM SECTION
	ac_request_to_boot:out STD_LOGIC;
	ac_data_com		: in		AC_BUS_TYPE := (others=>'0');
	n_ac_com_enable	: out STD_LOGIC := '1';	--enable com with acive low(busy flag)


	----------------------------------------END COM SECTION
	
	
	-----------------------------------------SENSOR COM
	sensor_com_vld :IN STD_LOGIC_VECTOR(1 to  node_detector(nodes));  --node number length
	sensor_com_data :IN SENSOR_DATA_TYPEDEF(1 to sensor_detector(nodes));--node0 ->[sens0, sens1,..], node1->[..sens n, sens n+1, ...]
	------------------------------------------END SENSOR COM
	
	-----------------------------------------actuator COM
	actuator_com_vld :OUT STD_LOGIC_VECTOR(1 to  node_detector(nodes));  --node number length
	actuator_com_data :OUT DOUBLEPRECISION_ARRAY(1 to actuator_detector(nodes));--node0 ->[sens0, sens1,..], node1->[..sens n, sens n+1, ...]
	deactuator_com_data :OUT DOUBLEPRECISION_ARRAY(1 to deactuator_detector(nodes))--node0 ->[sens0, sens1,..], node1->[..sens n, sens n+1, ...]
	-----------------------------------------end actuator COM
);
END COMPONENT ac_main;
------------------------------------end component definition

END PACKAGE STD_AC;


PACKAGE BODY STD_AC IS

----------------------------------------------------FUNCTION---------------------------------------------
FUNCTION to_integer( inp : OPERATING_POINT_TYPEDEF ) RETURN integer is

variable i: integer;

begin

i:= inp;
return i;

end function;
-----------
FUNCTION node_detector (nodes : NODE_PORT) RETURN INTEGER is
VARIABLE cntr : INTEGER := 0;
begin
	FOR i IN 1 TO NODE_PORT'high LOOP
		if ( sub_node_detector( nodes(i).sens_obj.sensor) = 0  and  sub_node_detector( nodes(i).act_obj.actuator) = 0 and sub_node_detector( nodes(i).act_obj.deactuator ) = 0) then RETURN cntr; end if;
		cntr := cntr + 1; 
	
	END LOOP;
	return 0;
end function;
------------------
FUNCTION node_detector (nodes : NODE_VECTOR) RETURN INTEGER is
VARIABLE cntr : INTEGER := 0;
begin

	return nodes'length;

end function;
-------------------
FUNCTION sub_node_detector (sens : SENSOR_TYPEDEF) RETURN INTEGER is
VARIABLE cntr : INTEGER := 0;
begin
	FOR i IN 1 TO sens'high LOOP
		if ( sens(i) = NONE ) then RETURN cntr; end if;
		cntr := cntr + 1; 
	
	END LOOP;
	return 0;
end function;
-------------------
FUNCTION sub_node_detector (act : ACT_TYPEDEF) RETURN INTEGER is
VARIABLE cntr : INTEGER := 0;
begin
	FOR i IN 1 TO act'high LOOP
		if ( act(i) = NONE ) then RETURN cntr; end if;
		cntr := cntr + 1; 
	
	END LOOP;
	return 0;
end function;
-------------------
FUNCTION sub_node_detector (deact : DEACT_TYPEDEF) RETURN INTEGER is
VARIABLE cntr : INTEGER := 0;
begin
	FOR i IN 1 TO deact'high LOOP
		if ( deact(i) = NONE ) then RETURN cntr; end if;
		cntr := cntr + 1; 
	
	END LOOP;
	return 0;
end function;
----------------------
FUNCTION sensor_detector (nodes : NODE_PORT) RETURN INTEGER IS
VARIABLE cntr : INTEGER := 0;
begin
	FOR i IN 1 TO node_detector(nodes) LOOP
				
		cntr := cntr + sub_node_detector( nodes(i).sens_obj.sensor);
		
	END LOOP;
	RETURN cntr;
end function;
----------------------
FUNCTION sensor_detector (nodes : node_vector) RETURN INTEGER IS
VARIABLE cntr: INTEGER := 0;
begin
	FOR i IN 1 TO node_detector(nodes) LOOP
		
		cntr := cntr + sub_node_detector( nodes(i).sens_obj.sensor);
		
	END LOOP;
	RETURN cntr;
end function;

---------------------
FUNCTION actuator_detector (nodes : NODE_PORT) RETURN INTEGER IS
VARIABLE cntr: INTEGER := 0;
begin
	FOR i IN 1 TO node_detector(nodes) LOOP
				
		cntr := cntr + sub_node_detector( nodes(i).act_obj.actuator);
		
	END LOOP;
	RETURN cntr;
end function;
---------------------
FUNCTION actuator_detector (nodes : node_vector) RETURN INTEGER IS
VARIABLE cntr: INTEGER := 0;
begin
	FOR i IN 1 TO node_detector(nodes) LOOP
				
		cntr := cntr + sub_node_detector( nodes(i).act_obj.actuator);
		
	END LOOP;
	RETURN cntr;
end function;
---------------------
FUNCTION deactuator_detector (nodes : NODE_PORT) RETURN INTEGER IS
VARIABLE cntr : INTEGER := 0;
begin
	FOR i IN 1 TO node_detector(nodes) LOOP
		
		cntr := cntr + sub_node_detector(nodes(i).act_obj.deactuator); 
	END LOOP;
	RETURN cntr;
end function;
---------------------
FUNCTION deactuator_detector (nodes : NODE_VECTOR) RETURN INTEGER IS
VARIABLE cntr : INTEGER := 0;
begin
	FOR i IN 1 TO node_detector(nodes) LOOP
		
		cntr := cntr + sub_node_detector(nodes(i).act_obj.deactuator); 
	END LOOP;
	RETURN cntr;
end function;

---------------------
FUNCTION to_sens (vct : SENSOR_TYPEDEF) RETURN SENSOR_TYPEDEF is
variable res : SENSOR_TYPEDEF(1 to MAX_SENSOR_NUMBER);
begin
	res(1 to vct'length) := vct;
	return res;
end function;
---------------------
FUNCTION to_sens (vct : INTEGER_VECTOR) RETURN INTEGER_VECTOR is
variable res : INTEGER_VECTOR(1 to MAX_SENSOR_NUMBER);
begin
	res(1 to vct'length) := vct;
	return res;
end function;
-------------------
FUNCTION to_sens (vct : EFFICIENCY_VECT) RETURN EFFICIENCY_VECT is
variable res : EFFICIENCY_VECT(1 to MAX_SENSOR_NUMBER);
begin
	res(1 to vct'length) := vct;
	return res;
end function;
-------------------
FUNCTION to_sens (vct : SETTLING_TIME_TYPEDEF) RETURN SETTLING_TIME_TYPEDEF IS
variable res : SETTLING_TIME_TYPEDEF(1 to MAX_SENSOR_NUMBER);
begin
	res(1 to vct'length) := vct;
	return res;
end function;

-------------------
FUNCTION to_act (vct : ACT_TYPEDEF) RETURN ACT_TYPEDEF  is
variable res : ACT_TYPEDEF(1 to MAX_ACTUATOR_NUMBER);
begin
	res(1 to vct'length) := vct;
	return res;
end function;
-------------------
FUNCTION to_act (vct : DEACT_TYPEDEF) RETURN DEACT_TYPEDEF is
variable res : DEACT_TYPEDEF(1 to MAX_ACTUATOR_NUMBER);
begin
	res(1 to vct'length) := vct;
	return res;
end function;
-------------------
FUNCTION to_act (vct : INTEGER_VECTOR) RETURN INTEGER_VECTOR  is
variable res : INTEGER_VECTOR(1 to MAX_ACTUATOR_NUMBER);
begin
	res(1 to vct'length) := vct;
	return res;
end function;
-------------------
FUNCTION to_act (vct : SETTLING_TIME_TYPEDEF) RETURN SETTLING_TIME_TYPEDEF IS
variable res : SETTLING_TIME_TYPEDEF(1 to MAX_ACTUATOR_NUMBER);
begin
	res(1 to vct'length) := vct;
	return res;
end function;
-------------------
FUNCTION to_act (vct : EFFICIENCY_VECT) RETURN EFFICIENCY_VECT is
variable res : EFFICIENCY_VECT(1 to MAX_ACTUATOR_NUMBER);
begin
	res(1 to vct'length) := vct;
	return res;
end function;
-------------------
FUNCTION to_act (inp : ACT_SUBTYPEDEF) RETURN ACT_TYPEDEF is
variable res : ACT_TYPEDEF(1 to MAX_ACTUATOR_NUMBER);
begin
	res(1) := inp;
	return res;
end function;
-------------------
FUNCTION to_act (inp : DEACT_SUBTYPEDEF) RETURN DEACT_TYPEDEF is
variable res : DEACT_TYPEDEF(1 to MAX_ACTUATOR_NUMBER);
begin
	res(1) := inp;
	return res;
end function;
-------------------
FUNCTION to_tim (vct : efficiency_EXCEPT_TYPEDEF) RETURN efficiency_EXCEPT_TYPEDEF IS
variable res : efficiency_EXCEPT_TYPEDEF(1 to MAX_efficiency_EXCEPTION_NUMBER);
begin
	res(1 to vct'length) := vct;
	return res;
end function;
-------------------
FUNCTION to_integer_vector (vct : SETTLING_TIME_TYPEDEF; out_length:INTEGER) RETURN integer_vector IS
variable res : integer_vector(1 to out_length);
begin
	
	for i in  1 to out_length loop
	
		res(i) := vct(i);
		
	end loop;
	
	return res;
end function;
-------------------
FUNCTION to_node (vct : NODE_VECTOR) RETURN NODE_PORT IS
variable res : NODE_PORT;
BEGIN
	for i in 1 to vct'length loop
		res(i) := vct(i);
	end loop;
	return res;
END FUNCTION;
-------------------
FUNCTION node_slice (vct : NODE_PORT; final_length: INTEGER) RETURN NODE_VECTOR IS
variable res : NODE_VECTOR(1 to final_length);
BEGIN
	assert ( (final_length < vct'length)  ) report "check input params!" severity error;	
	
	for i in 1 to final_length loop
		res(i) := vct(i);
	end loop;
	
	return res;
END FUNCTION;
-------------------
FUNCTION sensor_handler(sensor_id :INTEGER ) RETURN  INTEGER IS
	VARIABLE FINAL_RES: INTEGER ;

BEGIN
	--SEE @basictypedef AND SENSOR_SUBTYPEDEF
	--E.G. SENSOR_SUBTYPEDEF is (NONE, RTD, THERMOCOUPLE, NTC, PTC)
	--then the below program is an valib program 
	--sensor_id starts from 1 (ignore NONE in SENSOR_SUBTYPEDEF)
	--RTD=>1 , THERMOCOUPLE => 2, NTC => 3, PTC => 4
	
	case sensor_id is
		when 1 => return 1;--RTD HANDLER;
		when 2 => return 1;--THERMOCOUPLE HANDLER;
		when 3 => return 1;--NTC HANDLER;
		when 4 => return 1;--PTC HANDLER;
	
	end case;

END FUNCTION;
--writed for parralell sensing
-- FUNCTION node_sensing(constant node : ACNODE ) RETURN  INTEGER IS

-- BEGIN
	-- for i in 1 to sub_node_detector( node.sens_obj.sensor ) loop
		
		
	-- end loop;


-- END FUNCTION;
-------------------
-- FUNCTION main_sensing(node : ACNODE ) RETURN  INTEGER IS

-- BEGIN


-- END FUNCTION;
-------------------
END PACKAGE BODY STD_AC;

--end with the name of allah
