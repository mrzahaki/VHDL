# Liquid crystal display driver based on VHDL

This library, with a different approach than that of the similar libraries, uses the idea
of **seed breeding** to set up and work with the display. It is only designed for 2X16 LCM, but the library structure is very flexible so the user
can easily change it for different types of LCM.

With this library, user has ability to display animation on his/her screen by adding only
a few lines of code to the main body of the program.

### Let's start writing a simple program based on the liquid crystal display driver

- First we need to include std_lcm module
```vhdl
LIBRARY DROGRAMMER;
USE DROGRAMMER.std_lcm.all;
USE DROGRAMMER.std_arith.all;
```

- In this section we define the signals we want to use in the main part of the program. Note that using this driver requires an external clock source
```vhdl
SIGNAL machine_com:  LCM_BUS_TYPE:=(OTHERS=>'0');
SIGNAL listen_flg :STD_LOGIC;
SIGNAL clk, rst :STD_LOGIC := '1';
CONSTANT clock_frequency : INTEGER := 10e6;
```

- We need to define two signals to communicate with the LCD, 
```vhdl
--refer to std_lcm
-- SUBTYPE LCM_I8080_DATATYPE	is STD_LOGIC_VECTOR(8 downto 1);
-- LCM_COM_DATATYPE format : (msb) lcd enable, read/write, data/setup pin
-- SUBTYPE LCM_COM_DATATYPE	is STD_LOGIC_VECTOR(3 downto 1);

lcd_com    	:OUT LCM_COM_DATATYPE  ;        
lcd_data   	:INOUT  LCM_I8080_DATATYPE;
 ```
 
- This component is a low-level controller for other functions and procedures written based on the finite state machine. 
```vhdl
FA0:lcm_main generic map(clock_frequency) port map(clk=>clk, 
                      nrst => rst,
                      machine_com => machine_com,
                      nencom=>listen_flg,
                      lcd_com=>lcd_com,
                      lcd_data=>lcd_data);
```

- If we want to work with higher level functions, we need to add a "process" to our program. Note that the seed variable is used to synchronize and schedule tasks on a clock basis.
```vhdl
process(clk, machine_com, listen_flg)
		variable seed : seed_typedef:=0; --true
begin


end process;
```

- Here we try to send a simple string to the lcd, If we consider each 'UI' procedure as a seed, the 'seed_breeding' function controls the time and determines how each seed accesses the clock gate. please enter the following code in the 'process' body.
```vhdl
seed := seed_breeding(listen_flg,
			rst, -- reset signal 
			3, -- number of jobs
			0, 
			false
);

-- We try to initialize lcd with three parameters: 
--	LCD_INIT_INC_NOSHIFT: Set the moving direction of cursor and display. See page 11 of the attached datasheet.	
--	LCD_INIT_NO_CURSOR_NO_BLINK: Control display/cursor/blink ON/OFF.
--	LCD_INIT_2ROW_5X7: Display line number control.
lcm_init(
	listen_flg, machine_com, seed,
	LCD_INIT_INC_NOSHIFT , LCD_INIT_NO_CURSOR_NO_BLINK , LCD_INIT_2ROW_5X7,
	1 --first jop
);

-- Set cursor position
lcm_gotoxy(
	listen_flg, machine_com, seed,
	1,0,	--x, y
	2 --second jop
);

-- Send string to LCD
lcm_string(
	listen_flg, machine_com, seed,
	"name of Allah",
	3 --third job
 );
```
**With this driver, that's all you need to do in VHDL to set up an LCD.**

- Well, lets modify the above code to achieve a simple blinking 'hello world' text on the screen:
```vhdl
seed := seed_breeding(listen_flg,
			rst, -- reset signal 
			5, -- number of jobs
			2, -- 'reset-offset' number. After reset 
			true -- Change 'false' value to 'true', by doing this, after completing the to-do list, the driver will start working from task number 2 ('reset-offset')(We do not want to initialize the LCD forever), and this will continue forever as a while loop. 
);

-- We try to initialize lcd with three parameters: 
--	LCD_INIT_INC_NOSHIFT: Set the moving direction of cursor and display. See page 11 of the attached datasheet.	
--	LCD_INIT_NO_CURSOR_NO_BLINK: Control display/cursor/blink ON/OFF.
--	LCD_INIT_2ROW_5X7: Display line number control.
lcm_init(
	listen_flg, machine_com, seed,
	LCD_INIT_INC_NOSHIFT , LCD_INIT_NO_CURSOR_NO_BLINK , LCD_INIT_2ROW_5X7,
	1 --first jop
);


--clear display
lcm_instruction(
	listen_flg, machine_com, seed,
	LCD_CMD_CLEAR_DISPLAY,
	2
);

-- Set cursor position
lcm_gotoxy(
	listen_flg, machine_com, seed,
	2,0,	--x, y
	3 --second jop
);

-- Send string to LCD
lcm_string(
	listen_flg, machine_com, seed,
	"Hello World",
	4 --third job
 );
 
 lcm_delay(
	listen_flg, machine_com, seed,
	open,
	1000, --based on millisecond
	clock_frequency,
	5
);
 
```

