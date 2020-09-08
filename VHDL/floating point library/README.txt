#the name of allah

# note vhdl version 2008
/DROGRAMMER -> floating point, lcd2X16, arithmetic  packages

#floating point calculations
/floating_simulation_isim -> simulation file, you can add this file with /DROGRAMMER contents as DROGRAMMER library in ISE and simulate with ISIM.
 floating_synthesizable_quartus -> synthesizable file, you can add this file with /DROGRAMMER contents as DROGRAMMER library in intel quartus and start synthesize, or check RTL view.
/input_floating_points -> you can add your testing equations to calculate operations(division, addition, subtraction, multipliction) on floating point numbers  in this file.
/output_results -> this file will save your testing equations from input_floating_points file

#lcd2X16
/lcd_top.vhd -> lcd top module, you can add this file with /DROGRAMMER contents as DROGRAMMER library in ISE and simulate with ISIM or in intel quartus and start synthesize and check RTL view
/lcd_state.jpg -> lcd state diagram	
/lcm2X16_datasheet.pdf
/lcd_isim_simulation.wcfg -> lcm2X16 simulation file in ISIM


writed by hussein zahaki mansoor 9604903