LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY DROGRAMMER;
USE DROGRAMMER.std_lcm.all;
USE DROGRAMMER.std_arith.all;
ENTITY lcd_top IS
  PORT(
	--system clock, reset_lcm_main
	-- clk, rst   	: IN   		STD_LOGIC;   					
	---------------------------------------------------LCD signals
    	--lcd enable, read/write, data/setup pin
	lcd_com    	: out  		LCM_COM_DATATYPE;        
	--data signals for lcd in buffer mode
    lcd_data   	: inout  	LCM_I8080_DATATYPE
);
END lcd_top;

	 

ARCHITECTURE sim OF lcd_top IS
	signal  clk, rst   	: STD_LOGIC := '0';  
	---------------------------------------------------inner signals
	--main command format is: MSB[8 bit flags/data, init, send]LSB
	signal machine_com:  lcm_bus_type:=(others=>'0');
	signal listen_flg :std_logic;
	--unprocessed signal
	
	constant clock_frequency: integer := 10e6;
	constant clock_period: time := 1000ms/clock_frequency;
	
	signal shared_conter : integer;
	-- constant delays	: integer_vector(1 to 10) := (
		-- 10, 50, 10, 50, 10, 2000, 10, 50, 10, 60	--us timing
	-- );
	-- signal ret_vect :boolean_vector(delays'range);
	signal enable_delay:std_logic;
 BEGIN
	FA0:lcm_main port map(clk=>clk, 
						  nrst => rst,
						  machine_com => machine_com,
						  nencom=>listen_flg,
						  lcd_com=>lcd_com,
						  lcd_data=>lcd_data);
						  
						  
	
	process(clk, machine_com, listen_flg)
		variable seed : seed_typedef:=0; --true
	begin
		-- seed:= seed +1;
		-- ret_vect_tst:= udelay_machine(clock_frequency, seed, delays  );
		-- ret_vect<=ret_vect_tst;
		BIGIF:IF(  (clk'event and clk='1')  ) THEN
		
			seed := seed_breeding(listen_flg, 9); --reduce error of transaction
			--cascade method
			--must start with number 1
			lcm_init(
				listen_flg,
				machine_com,
				seed,
				LCD_INIT_INC_NOSHIFT , LCD_INIT_NO_CURSOR_NO_BLINK , LCD_INIT_2ROW_5X7,
				1
			);
			lcm_gotoxy(
				listen_flg,
				machine_com,
				seed,
				0,0,	--x, y
				2
				);

				lcm_string(
				listen_flg,
				machine_com,
				seed,
				"in the name of",
				3
			 );
			 lcm_gotoxy(
				listen_flg,
				machine_com,
				seed,
				7,1,	--x, y
				4
				);

			lcm_string(
				listen_flg,
				machine_com,
				seed,
				"AllAH",
				5
			 );
			 
			lcm_delay(
				listen_flg,
				machine_com,
				seed,
				enable_delay,
				2000,
				clock_frequency,
				6
			);
			lcm_instruction(
				listen_flg,
				machine_com,
				seed,
				LCD_CMD_CLEAR_DISPLAY,
				7
			);
			lcm_gotoxy(
				listen_flg,
				machine_com,
				seed,
				4,0,	--x, y
				8
				);

			lcm_string(
				listen_flg,
				machine_com,
				seed,
				"Hussein Zahaki",
				9
			 );
			
		END IF BIGIF;
	end process;
	---------------------------------------------------
	
	
	clk <= not clk after clock_period/2;
	rst<= '0', '1' after clock_period;
	-- process
	
	-- begin
		-- rst<= '0', '1' after 5ns;
		-- wa
	
		
	-- end process;

END sim;