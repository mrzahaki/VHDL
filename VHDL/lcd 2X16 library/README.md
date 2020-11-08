# Liquid crystal display driver based on VHDL

This library, with a different approach than that of the similar libraries, uses the idea
of **seed breeding** to set up and work with the display. It is only designed for 2X16 LCM, but the library structure is very flexible so the user
can easily change it for different types of LCM.

With this library, user has ability to display animation on his/her screen by adding only
a few lines of code to the main body of the program.

### Let's start writing a simple program based on the liquid crystal display driver


```vhdl
LIBRARY DROGRAMMER;
USE DROGRAMMER.std_lcm.all;
USE DROGRAMMER.std_arith.all;
```

```vhdl
FA0:lcm_main port map(clk=>clk, 
                      nrst => rst,
                      machine_com => machine_com,
                      nencom=>listen_flg,
                      lcd_com=>lcd_com,
                      lcd_data=>lcd_data);
```

```vhdl
process(clk, machine_com, listen_flg)
		variable seed : seed_typedef:=0; --true
begin


end process;
```

```vhdl
process(clk, machine_com, listen_flg)
		variable seed : seed_typedef:=0; --true
begin


end process;
```

