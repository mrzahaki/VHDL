--in the name of allah

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
--LIBRARY AC;
USE work.std_ac.ALL;
USE work.std_lcm.ALL;
USE work.std_float.ALL;

ENTITY ac_main IS
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
	lcd_com    	:OUT LCM_COM_DATATYPE  ;        
	--data signals for lcd in buffer mode
    lcd_data   	: INOUT  	LCM_I8080_DATATYPE;

	------------------------------------------END UI SECTION
	
	
	----------------------------------------COM SECTION
	ac_request_to_boot:out STD_LOGIC:= '0';
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
END ac_main;
ARCHITECTURE ARCH OF ac_main IS
---------------------------------------type
TYPE BOOT_STATE IS( idle,
					ch_sens_settling_time,
					ch_sens_op_range,
					ch_sens_op_point,
					ch_sens_reliability,
					ch_act_efficiency,
					ch_act_settling_time,
					ch_deact_efficiency,
					ch_deact_settling_time,
					ch_tm_measurement_mode,
					ch_tm_control_mode,
					ch_tm_efficiency_exception_range_method,
					ch_tm_gap_size,
					ch_node_number,
					apply_changes);
type opcode_array is array(natural range<>) of STD_LOGIC_VECTOR(1 TO 2);
---------------------------------------constant 
	CONSTANT NODE_NUMBER : INTEGER := node_detector(nodes) ;
	
	CONSTANT ac_data_com_close : STD_LOGIC:= '1';--busy mode
	CONSTANT ac_data_com_open : STD_LOGIC:= '0';--read from it
	
	CONSTANT ac_apply_changes : ac_bus_modetype 			:= x"01";	
	CONSTANT ac_ch_sens_settling_time : ac_bus_modetype 	:= x"02";
	CONSTANT ac_ch_sens_op_range : ac_bus_modetype 			:= x"03";
	CONSTANT ac_ch_sens_op_point : ac_bus_modetype 			:= x"04";
	CONSTANT ac_ch_sens_reliability : ac_bus_modetype 		:= x"05";
	CONSTANT ac_ch_act_efficiency : ac_bus_modetype 		:= x"06";
	CONSTANT ac_ch_act_settling_time : ac_bus_modetype 		:= x"07";
	CONSTANT ac_ch_deact_efficiency : ac_bus_modetype 		:= x"08";
	CONSTANT ac_ch_deact_settling_time : ac_bus_modetype 	:= x"09";
	CONSTANT ac_ch_tm_measurement_mode : ac_bus_modetype 	:= x"0A";
	CONSTANT ac_ch_tm_control_mode : ac_bus_modetype 		:= x"0B";
	CONSTANT ac_ch_tm_efficiency_exception_range_method 	: ac_bus_modetype := x"0C";
	CONSTANT ac_ch_tm_gap_size : ac_bus_modetype 			:= x"0D";
	CONSTANT ac_ch_node_number : ac_bus_modetype 			:= x"0E";
	CONSTANT ac_start_all : ac_bus_modetype 		:= x"0F";
	CONSTANT ac_stop_all : ac_bus_modetype 			:= x"10";
	
---------------------------------------alias section
alias ac_com_state_part  	:ac_bus_modetype  is ac_data_com(40 downto 33);
alias ac_com_data_Part :  ac_bus_datatype is ac_data_com(32 downto 1);
---------------------------------------signal
	SIGNAL backup_data : ac_bus_datatype := (others=>'0') ;
	SIGNAL main_enable_delay, boot_complate_enable_delay:STD_LOGIC := '0';
	SIGNAL nrst_soft :STD_LOGIC_VECTOR(1 TO NODE_NUMBER):=(others=>'0');
	SIGNAL  fpu_nrst, nbt_reset, ngui_reset:STD_LOGIC := '1';
	
	--main command format is: MSB[8 bit flags/data, init, send]LSB
	SIGNAL machine_com:  LCM_BUS_TYPE:=(OTHERS=>'0');
	SIGNAL listen_flg :STD_LOGIC;
	
	
	
	SIGNAL snode : NODE_VECTOR(1 to  NODE_NUMBER ) := node_slice( nodes , NODE_NUMBER ); 
	SIGNAL	fopcode					:   STD_LOGIC_VECTOR(1 TO 2);
	SIGNAL	finp0_data, finp1_data	:   doublePrecision_type;
	SIGNAL	finp_ready				:   STD_LOGIC := '0'; --using this signal in fpu
	SIGNAL	finp_vld				:   STD_LOGIC := '0'; 
	SIGNAL	foutp_ready				:  STD_LOGIC := '0';--status 
	SIGNAL	foutp_data				: doublePrecision_type;
	
	SIGNAL	node_opcode					:   opcode_array(1 TO NODE_NUMBER);
	SIGNAL	node_finp0_data, node_finp1_data	:   DOUBLEPRECISION_ARRAY(1 to NODE_NUMBER);
	SIGNAL	node_finp_vld				:   STD_LOGIC_VECTOR(1 TO NODE_NUMBER) := (others=> '0'); 
	SIGNAL	fp_request				: STD_LOGIC_VECTOR(1 TO NODE_NUMBER);
	SIGNAL	fp_ready				: STD_LOGIC_VECTOR(1 TO NODE_NUMBER);
	
	SIGNAL  nc_bootloader_complete, nc_force_bootloader: STD_LOGIC:='0';
	SIGNAL booting_state:BOOT_STATE:= idle;
-------------------------------------------------procedure def
	procedure incoming_message (
		SIGNAL listen_flg:IN STD_LOGIC; 
		SIGNAL machine_com:OUT LCM_BUS_TYPE;
		SIGNAL enable_delay_out:OUT STD_LOGIC;
		subseed   :INOUT SUBSEED_TYPEDEF;
		preseed:IN SEED_TYPEDEF;
		CONSTANT work_id 		:in INTEGER
	) is
	--variable wait_on_delay:;
	begin
			 subseed_breeding (
				listen_flg,	
				preseed,
				work_id,
				subseed,
				12
			);
			
			lcm_gotoxy(
				listen_flg,
				machine_com,
				subseed,
				2,0,	--x, y
				1
				);


				lcm_string(
				listen_flg,
				machine_com,
				subseed,
				"the name of",
				2
			 );
			 lcm_gotoxy(
				listen_flg,
				machine_com,
				subseed,
				7,1,	--x, y
				3
				);

			lcm_string(
				listen_flg,
				machine_com,
				subseed,
				"AllAH",
				4
			 );
			 
			 lcm_delay(
				listen_flg,
				machine_com,
				subseed,
				enable_delay_out,
				40,--2000
				clock_frequency,
				5
			); 
			
			lcm_instruction(
				listen_flg,
				machine_com,
				subseed,
				LCD_CMD_CLEAR_DISPLAY,
				6
			);
			
			lcm_gotoxy(
				listen_flg,
				machine_com,
				subseed,
				3,0,	--x, y
				7
				);

			lcm_string(
				listen_flg,
				machine_com,
				subseed,
				"Designed by",
				8
			 );
			lcm_delay(
				listen_flg,
				machine_com,
				subseed,
				enable_delay_out,
				20,--400
				clock_frequency,
				9
			); 
			
			lcm_gotoxy(
				listen_flg,
				machine_com,
				subseed,
				1,1,	--x, y
				10
				);

			lcm_string(
				listen_flg,
				machine_com,
				subseed,
				"Hussein Zahaki",
				11
			 );
			 lcm_delay(
				listen_flg,
				machine_com,
				subseed,
				enable_delay_out,
				40,--2000
				clock_frequency,
				12
			); 
	end procedure;
--------------------------
		procedure booting (
		
		SIGNAL listen_flg:IN STD_LOGIC; 
		SIGNAL machine_com:OUT LCM_BUS_TYPE;
		SIGNAL enable_delay_out:OUT STD_LOGIC;
		subseed   :INOUT SUBSEED_TYPEDEF;
		preseed:IN SEED_TYPEDEF;
		CONSTANT work_id 		:in INTEGER;
		
		SIGNAL force_bootloader: OUT STD_LOGIC ;
		SIGNAL bootloader_complete: IN  STD_LOGIC
		
	) is
	
	variable boot_flg: boolean:= false;
	
	begin

		
			 subseed_breeding (
				listen_flg,	
				preseed,
				work_id,
				subseed,
				4
			);
			
			lcm_instruction(
				listen_flg,
				machine_com,
				subseed,
				LCD_CMD_CLEAR_DISPLAY,
				1
			);
			
			lcm_gotoxy(
				listen_flg,
				machine_com,
				subseed,
				3,0,	--x, y
				2
				);


			lcm_string(
				listen_flg,
				machine_com,
				subseed,
				"booting.*.",
				3
			 ); 
			 
			if(main_node.bootloader = ONN) then
			
				lcm_wait_for (
					listen_flg,
					machine_com,
					subseed,
					boot_flg,
					4
				);  
				
				if(subseed = 4) then 
					force_bootloader<='1';
					if(bootloader_complete='1') then--bootloader must be keep running
						boot_flg:= true;
					end if;
				end if;
			else 
			 
			 lcm_delay(
				listen_flg,
				machine_com,
				subseed,
				enable_delay_out,
				30,--1000
				clock_frequency,
				4
			); 
				
			end if;
		


			
			

	end procedure;
---------------------------------------------
	procedure check_com (
		
		SIGNAL listen_flg:IN STD_LOGIC; 
		SIGNAL machine_com:OUT LCM_BUS_TYPE;
		SIGNAL enable_delay_out:OUT STD_LOGIC;
		subseed   :INOUT SUBSEED_TYPEDEF;
		preseed:IN SEED_TYPEDEF;
		CONSTANT work_id 		:in INTEGER;
		
		SIGNAL nrst_soft_0 :IN STD_LOGIC_VECTOR(1 TO NODE_NUMBER)
		
	) is
	
	--variable cntr_0: integer 0 to nrst_soft'length ;
	
	begin

		
			 subseed_breeding (
				listen_flg,	
				preseed,
				work_id,
				subseed,
				6
			);
			lcm_instruction(
				listen_flg,
				machine_com,
				subseed,
				LCD_CMD_CLEAR_DISPLAY,
				1
			);
			lcm_gotoxy(
					listen_flg,
					machine_com,
					subseed,
					0,0,	--x, y
					2
					);
			if(nrst_soft_0 = (nrst_soft_0'range=>'1')) then
				lcm_string(
					listen_flg,
					machine_com,
					subseed,
					"all nodes:",
					3
				 ); 
				 lcm_gotoxy(
					listen_flg,
					machine_com,
					subseed,
					0,1,	--x, y
					4
					);


				lcm_string(
					listen_flg,
					machine_com,
					subseed,
					"stable mode",
					5
				 ); 
			elsif(nrst_soft_0 = (nrst_soft_0'range=>'0')) then
				lcm_string(
					listen_flg,
					machine_com,
					subseed,
					"all nodes:",
					3
				 ); 
				 lcm_gotoxy(
					listen_flg,
					machine_com,
					subseed,
					0,1,	--x, y
					4
					);


				lcm_string(
					listen_flg,
					machine_com,
					subseed,
					"stoped",
					5
				 ); 
			else
				lcm_string(
					listen_flg,
					machine_com,
					subseed,
					"some of nodes:",
					3
				 ); 
				 lcm_gotoxy(
					listen_flg,
					machine_com,
					subseed,
					0,1,	--x, y
					4
					);


				lcm_string(
					listen_flg,
					machine_com,
					subseed,
					"stoped",
					5
				 ); 
				
				
			end if;

			

			 
			 lcm_delay(
				listen_flg,
				machine_com,
				subseed,
				enable_delay_out,
				20,--800
				clock_frequency,
				6
			); 
						

	end procedure;
-------------------------------------------------end procedure def	
BEGIN
-------------------------------------assert-----------------------------------------
assert NODE_NUMBER /= 0 report "control node number" severity error;
-------------------------------------component--------------------------------------
	FA1:lcm_main generic map( clock_frequency )port map(
		clk=>clk, 
		nrst => nrst,
		machine_com => machine_com,
		nencom=>listen_flg,
		lcd_com=>lcd_com,
		lcd_data=>lcd_data
	);

    FA2: float_alu generic map( 	float_typedef 	)	port map(
		clk=>clk, 
		nrst => fpu_nrst,
		opcode=>fopcode,
		inp_ready=>	finp_ready,
		inp_vld	=>	finp_vld,			
		inp0_data=>finp0_data,
		inp1_data=>finp1_data,
		outp_ready	=>foutp_ready,		
		outp_data	=>foutp_data		
	);
-------------------------------------------------- BOOT LOADER HANDLER
---NC section
	process(clk)
		variable node_selector, next_node_selector :INTEGER RANGE 1 TO NODE_NUMBER := 1 ;
		variable backup_vector : AC_BUS_TYPE := ac_data_com;
		variable tmp: STD_LOGIC :='0' ;
		variable nbt_reset_backup: boolean :=false ;
		
	begin
	
		BIGIF:IF(nbt_reset = '0') then
			node_selector := 1;
			backup_vector:= ac_data_com;
			booting_state <=  idle;
			n_ac_com_enable <= ac_data_com_close;
			nc_bootloader_complete<= '0';
			ac_request_to_boot <= '0';
			nrst_soft <= (others=>'0');
			nbt_reset_backup:= true;
		
		
		
		
		ELSIF(  (clk'event and clk='1')  ) THEN
		
		
			 CASE booting_state IS
		  
			 WHEN idle =>
				
				
				if(nbt_reset_backup)then
					nbt_reset_backup:= false;
					
					nrst_soft(1)<= '1';
					
					--nrst_soft <= (others=>'1');
				end if;
				
				--force bootloader
				if(nc_force_bootloader = '1') then
					nc_bootloader_complete<= '0';
					ac_request_to_boot <= '1';
				end if;
				
				n_ac_com_enable <= ac_data_com_open;
				tmp := vector_event(ac_data_com, backup_vector);
				IF(tmp = '1') then
				
					nc_bootloader_complete<= '0';
					backup_data <= ac_com_data_Part;
					
					IF(ac_com_state_part = ac_ch_sens_settling_time) then	

						booting_state <= ch_sens_settling_time;
						n_ac_com_enable <= ac_data_com_close;
						
					ELSIF(ac_com_state_part = ac_ch_sens_op_range) then	

						booting_state <= ch_sens_op_range;
						n_ac_com_enable <= ac_data_com_close;
						
					ELSIF(ac_com_state_part = ac_ch_sens_op_point) then

						booting_state <= ch_sens_op_point;
						n_ac_com_enable <= ac_data_com_close;
					
					ELSIF(ac_com_state_part = ac_ch_sens_reliability) then

						booting_state <= ch_sens_reliability;
						n_ac_com_enable <= ac_data_com_close;
					
					ELSIF(ac_com_state_part = ac_ch_act_efficiency) then

						booting_state <= ch_act_efficiency;
						n_ac_com_enable <= ac_data_com_close;
					
					ELSIF(ac_com_state_part = ac_ch_act_settling_time) then

						booting_state <= ch_act_settling_time;
						n_ac_com_enable <= ac_data_com_close;
					
					ELSIF(ac_com_state_part = ac_ch_deact_efficiency) then

						booting_state <= ch_deact_efficiency;
						n_ac_com_enable <= ac_data_com_close;
					
					ELSIF(ac_com_state_part = ac_ch_deact_settling_time) then

						booting_state <= ch_deact_settling_time;
						n_ac_com_enable <= ac_data_com_close;
					
					ELSIF(ac_com_state_part = ac_ch_tm_measurement_mode) then

						booting_state <= ch_tm_measurement_mode;
						n_ac_com_enable <= ac_data_com_close;
					
					ELSIF(ac_com_state_part = ac_ch_tm_control_mode) then

						booting_state <= ch_tm_control_mode;
						n_ac_com_enable <= ac_data_com_close;
					
					ELSIF(ac_com_state_part = ac_ch_tm_efficiency_exception_range_method) then

						booting_state <= ch_tm_efficiency_exception_range_method;
						n_ac_com_enable <= ac_data_com_close;
					
					ELSIF(ac_com_state_part = ac_ch_tm_gap_size) then

						booting_state <= ch_tm_gap_size;
						n_ac_com_enable <= ac_data_com_close;
					
					ELSIF(ac_com_state_part = ac_ch_node_number) then

						booting_state <= ch_node_number;
						n_ac_com_enable <= ac_data_com_close;
					
					ELSIF(ac_com_state_part = ac_apply_changes) then

						booting_state <= apply_changes;
						n_ac_com_enable <= ac_data_com_close;
					
					ELSIF(ac_com_state_part = ac_start_all) then

						booting_state <= idle;
						n_ac_com_enable <= ac_data_com_close;
						nrst_soft <= (others=>'1');
						
					ELSIF(ac_com_state_part = ac_stop_all) then

						booting_state <= idle;
						n_ac_com_enable <= ac_data_com_close;
						nrst_soft <= (others=>'0');
					END IF;
					
				ELSE
					booting_state <= idle;
				END IF;
					
				
			 WHEN ch_sens_settling_time =>		--15 17	

				assert to_integer(unsigned(backup_data(32 downto 18))) < MAX_SENSOR_NUMBER+1 report "control_input" severity error;
				assert to_integer(unsigned(backup_data(17 downto 1))) < MAX_SETTLING_TIME+1 report "control_input" severity error;
				
				snode(node_selector).sens_obj.settling_time(to_integer(unsigned(backup_data(32 downto 18)))) <=	to_integer(unsigned(backup_data(17 downto 1)));
				booting_state <= idle;
				nrst_soft(node_selector) <= '0';
				
			 WHEN ch_sens_op_range =>	--16 + 16
				assert to_integer(signed(backup_data(32 downto 17))) > MAX_AMBIENT_OPERATING_RANGE(1)-1 report "control_input" severity error;
				assert to_integer(signed(backup_data(16 downto 1))) < MAX_AMBIENT_OPERATING_RANGE(2)+1 report "control_input" severity error;
				snode(node_selector).sens_obj.operating_range<= ( to_integer(signed(backup_data(32 downto 17))),
												to_integer(signed(backup_data(16 downto 1))));
				booting_state <= idle;
				nrst_soft(node_selector) <= '0';
				
			 WHEN ch_sens_op_point =>	--32
				assert to_integer(signed(backup_data)) < MAX_AMBIENT_OPERATING_RANGE(2)+1 report "control_input" severity error;
				assert to_integer(signed(backup_data)) > MAX_AMBIENT_OPERATING_RANGE(1)-1 report "control_input" severity error;
				snode(node_selector).sens_obj.operating_point <= to_integer(signed(backup_data));
				booting_state <= idle;
				nrst_soft(node_selector) <= '0';
				
			 WHEN ch_sens_reliability =>	--15 + 17	
				assert to_integer(unsigned(backup_data(32 downto 18))) < MAX_SENSOR_NUMBER+1 report "control_input" severity error;
				assert to_integer(unsigned(backup_data(17 downto 1))) < 101 report "control_input" severity error;
				nrst_soft(node_selector) <= '0';
				
				snode(node_selector).sens_obj.sensor_reliability( to_integer(unsigned(backup_data(32 downto 18))) )<= to_integer(unsigned(backup_data(17 downto 1)));
				booting_state <= idle;
				
			WHEN ch_act_efficiency => ----15 + 17
				assert to_integer(unsigned(backup_data(32 downto 18))) < MAX_ACTUATOR_NUMBER+1 report "control_input" severity error;
				assert to_integer(unsigned(backup_data(17 downto 1))) < 101 report "control_input" severity error;
				
				snode(node_selector).act_obj.actuator_efficiency(to_integer(unsigned(backup_data(32 downto 18)))) <= to_integer(unsigned(backup_data(17 downto 1)));
				booting_state <= idle;
				nrst_soft(node_selector) <= '0';
				
			 WHEN ch_act_settling_time =>	----15 + 17
				assert to_integer(unsigned(backup_data(32 downto 18))) < MAX_ACTUATOR_NUMBER+1 report "control_input" severity error;
				assert to_integer(unsigned(backup_data(17 downto 1))) < MAX_SETTLING_TIME+1 report "control_input" severity error;
				nrst_soft(node_selector) <= '0';
				snode(node_selector).act_obj.asettling_time(to_integer(unsigned(backup_data(32 downto 18)))) <= to_integer(unsigned(backup_data(17 downto 1)));
				booting_state <= idle;
				
			 WHEN ch_deact_efficiency =>--15 + 17
				assert to_integer(unsigned(backup_data(32 downto 18))) < MAX_ACTUATOR_NUMBER+1 report "control_input" severity error;
				assert to_integer(unsigned(backup_data(17 downto 1))) < 101 report "control_input" severity error;
				nrst_soft(node_selector) <= '0';
				snode(node_selector).act_obj.deactuator_efficiency(to_integer(unsigned(backup_data(32 downto 18)))) <= to_integer(unsigned(backup_data(17 downto 1)));
				booting_state <= idle;
			 
			 WHEN ch_deact_settling_time =>	
				assert to_integer(unsigned(backup_data(32 downto 18))) < MAX_ACTUATOR_NUMBER+1 report "control_input" severity error;
				assert to_integer(unsigned(backup_data(17 downto 1))) < MAX_SETTLING_TIME+1 report "control_input" severity error;
				nrst_soft(node_selector) <= '0';
				snode(node_selector).act_obj.dasettling_time(to_integer(unsigned(backup_data(32 downto 18)))) <= to_integer(unsigned(backup_data(17 downto 1)));
				booting_state <= idle;
			 
			 WHEN ch_tm_measurement_mode =>	
				if(backup_data =  MEASUREMENT_TYPEDEF_MODE_INRANGE_METHOD) then
					snode(node_selector).time_obj.measurement_mode<=INRANGE_METHOD;
				
				elsif(backup_data =  MEASUREMENT_TYPEDEF_MODE_OUTRANGE_METHOD) then
					snode(node_selector).time_obj.measurement_mode<=OUTRANGE_METHOD;
					
				elsif(backup_data =  MEASUREMENT_TYPEDEF_MODE_LPOINT_METHOD) then
					snode(node_selector).time_obj.measurement_mode<=LPOINT_METHOD;
					
				elsif(backup_data =  MEASUREMENT_TYPEDEF_MODE_GPOINT_METHOD) then
					snode(node_selector).time_obj.measurement_mode<=GPOINT_METHOD;
					
				end if;
				booting_state <= idle;
				nrst_soft(node_selector) <= '0';
				
			 WHEN ch_tm_control_mode =>	
				if(backup_data =  CONTROL_MODE_TYPEDEF_ACT) then
					snode(node_selector).time_obj.control_mode<= ACT;	
			
				elsif(backup_data =  CONTROL_MODE_TYPEDEF_DEACT) then
					snode(node_selector).time_obj.control_mode<=DEACT;	
				
				elsif(backup_data =  CONTROL_MODE_TYPEDEF_ACT_DEACT) then
					snode(node_selector).time_obj.control_mode<=ACT_DEACT;
						
				end if;
			 booting_state <= idle;
				nrst_soft(node_selector) <= '0';
				
			 WHEN ch_tm_efficiency_exception_range_method =>	
				--snode(node_selector).time_obj.efficiency_exception_range_method<=
				booting_state <= idle;
			 WHEN ch_tm_gap_size =>	
				nrst_soft(node_selector) <= '0';
				assert to_integer(unsigned(backup_data)) < MAX_AMBIENT_OPERATING_RANGE(2)-MAX_AMBIENT_OPERATING_RANGE(2)-5 report "control_input" severity error;
				snode(node_selector).time_obj.gap_size<= to_integer(unsigned(backup_data));
				booting_state <= idle;
			 
			 WHEN ch_node_number =>
				assert (to_integer(unsigned(backup_data)) < NODE_NUMBER) report "control_input" severity error;
				for i in snode'range loop 
					if(snode(i).ID = to_integer(unsigned(backup_data))) then 
						next_node_selector := i; 
					end if;
				end loop;
				booting_state <= idle;
				
			WHEN apply_changes =>	
				nrst_soft(node_selector) <= '1';
				booting_state <= idle;
				nc_bootloader_complete <= '1';
				node_selector := next_node_selector;
				ac_request_to_boot <= '0';
		   END CASE;    	   
		backup_vector := ac_data_com; --take backup
	END IF BIGIF;
		
	end process;

--------------------------------------------------FLOATING POINT UNIT
	FPU_ACCESS_HANDLE:process(clk)
		variable cntr0:INTEGER RANGE 0 to  NODE_NUMBER+1;
		variable backup_cntr:INTEGER RANGE 0 to  NODE_NUMBER;
		variable act2request:boolean := false;
	begin
	
		BIGIF:if(fpu_nrst = '0') then
				fp_ready <=  (others=>'0');
				cntr0 := 1;
				backup_cntr := 0;
			-- end if rst_chck;		

		ELSIF(  (clk'event and clk='1')  ) THEN
			
			
				if(finp_ready='1')then
					
					if( fp_request(cntr0)='1'  ) then	
						fp_ready(cntr0) <=  '1';
						act2request:= true;
					elsif(node_finp_vld(cntr0) = '1' and act2request)then
						
						finp_vld <= '1';
						fopcode <= node_opcode(cntr0);
						finp0_data <= node_finp0_data(cntr0);
						finp1_data <= node_finp1_data(cntr0);
						act2request := false;
						backup_cntr :=  cntr0;
					else
						finp_vld <= '0';
					end if;
					
					if(cntr0 = NODE_NUMBER) then cntr0 := 0; end if;
					
					cntr0 := cntr0+1;
					
				else
					if(backup_cntr /= 0) then
						fp_ready(backup_cntr) <= '0';
						backup_cntr:= 0;
					end if;
					
				end if;
			
			
		END IF BIGIF;
	end process FPU_ACCESS_HANDLE;
-------------------------------------process UI HANDLER--------------------------------------
	process(clk, machine_com, listen_flg)
		variable seed : SEED_TYPEDEF:=0; --true
		variable subseed : SUBSEED_TYPEDEF:=0; --true
		variable first_boot_flg : boolean:= false; --true
	begin
		-- seed:= seed +1;
		-- ret_vect_tst:= udelay_machine_serial_serial_serial_serial(clock_frequency, seed, delays  );
		-- ret_vect<=ret_vect_tst;
		BIGIF:IF( nrst = '0') then 
				--nrst_soft <=(others=>'0');
				nbt_reset <= '0';
				ngui_reset<='0';
				fpu_nrst<= '0';
				first_boot_flg := true; 

		ELSIF(  (clk'event and clk='1')  ) THEN
		
		
			
			seed := seed_breeding(listen_flg, ngui_reset,5, 3, true); --reduce error of transaction
			--cascade method
			--must start with number 1

				
				lcm_init(
					listen_flg,
					machine_com,
					seed,
					LCD_INIT_INC_NOSHIFT , LCD_INIT_NO_CURSOR_NO_BLINK , LCD_INIT_2ROW_5X7,
					1
				);
				
				-- incoming_message ( --true
					-- listen_flg,
					-- machine_com,
					-- main_enable_delay,
					-- subseed,
					-- seed,
					-- 2
				-- );
				
				lcm_delay(
					listen_flg,
					machine_com,
					seed,
					main_enable_delay,
					5,
					clock_frequency,
					2
				); 
				if(seed > 2) then 

					if(seed = 3 ) then
						if(first_boot_flg) then
							 booting (
								listen_flg,
								machine_com,
								main_enable_delay,
								subseed,
								seed,
								3,
								nc_force_bootloader,
								nc_bootloader_complete
							);
							fpu_nrst <= '1';	
							nbt_reset <= '1';
							
							
						else
							 check_com (
								listen_flg,
								machine_com,
								main_enable_delay,
								subseed,
								seed,
								3,
								nrst_soft
							);
						end if;
						
					else
						first_boot_flg:= false;
					end if;
						--check boot coomplate
						lcm_gotoxy(
								listen_flg,
								machine_com,
								seed,
								7,1,	--x, y
								4
								);
						 lcm_delay(
							listen_flg,
							machine_com,
							seed,
							main_enable_delay,
							5,
							clock_frequency,
							5
						); 
			
				else
					nbt_reset <= '0';
					--fpu_nrst <= '0';
				end if;
				ngui_reset <= '1'; 
				-- lcm_delay(
					-- listen_flg,
					-- machine_com,
					-- subseed,
					-- wait_enable,
					-- 2000,
					-- clock_frequency,
					-- 3
				-- );
				
				--booting up
				-- if(bootloader  =on)--get start conditions from gui_or uart (Control_gate_mode)
					-- IF(Control_gate_mode = secure/gui/ secure_gui)
				
				-- end if;

				
				--exception handler on com bus to change 
				-- lcm_wait_for
					--parsing data on com bus 
					
						--ac main setting low_efficiency_mode, auto_restart, operation_mode
								-- admin_password, Control_gate_mode
						--ac node:access all objects in ACTIME,ACACT,ACSENS
						
						--showing status
						
						--stop ac 
						
						--start ac
						
						--restart ac
				--showing status on free time

		END IF BIGIF;
	end process;
	
	ge0:FOR i IN 1 TO NODE_NUMBER GENERATE
		FA33:node_handler 
			generic map(
					clock_frequency,
					nodes(i),
					float_typedef) Port map (
						clk=> clk,
						nrst=> nrst_soft(i),--stop and start op
						active_node=> snode(i),
						main_node=> main_node,
						--------------------------------------------floating point section
						fp_request=>fp_request(i),
						opcode	=> node_opcode(i),								
						inp_ready => fp_ready(i),
						inp_vld	=>	node_finp_vld(i),
						inp0_data=>node_finp1_data(i), 
						inp1_data=>node_finp0_data(i),	
						
						outp_ready=> foutp_ready,
						outp_data=>	foutp_data,
						--------------------------------------------
						sensor_com_vld=>sensor_com_vld(i), 
						sensor_com_data=>sensor_com_data(1 to sub_node_detector(nodes(i).sens_obj.sensor)),
						
						--------------------------------------END SENSOR COM
						
						-------------------------------------actuator COM
						actuator_com_vld=>actuator_com_vld(i) ,
						actuator_com_data =>actuator_com_data(1 to sub_node_detector(nodes(i).act_obj.actuator)),
						deactuator_com_data=> deactuator_com_data(1 to sub_node_detector(nodes(i).act_obj.deactuator))		  
					  );
		
	
	end generate ge0;
	
	
--control each node in threat 

END ARCH;