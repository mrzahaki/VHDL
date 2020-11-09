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
FA0:lcm_main port map(clk=>clk, 
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

- Here we try to send a simple string to the lcd, If we consider each 'UI' procedure as a seed, the 'seed_breeding' function controls the time and determines how each seed accesses the clock gate. 
```vhdl
seed := seed_breeding(listen_flg, '1', 5, 0, false);

lcm_init(
	listen_flg,
	machine_com,
	seed,
	LCD_INIT_INC_NOSHIFT , LCD_INIT_NO_CURSOR_NO_BLINK , LCD_INIT_2ROW_5X7,
	1 --first jop
);

lcm_gotoxy(
	listen_flg,
	machine_com,
	subseed,
	1,0,	--x, y
	2 --second jop
);

lcm_string(
	listen_flg,
	machine_com,
	subseed,
	"name of Allah",
	3
 );
```

