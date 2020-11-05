--in the name of allah
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all; 
use ieee.MATH_REAL.all; 

use work.std_arith.all;
use work.std_type.all;

package std_delay is

--TYPE integer_vector	is array(NATURAL range<>) of INTEGER;
--TYPE boolean_vector	is array(NATURAL range<>) of BOOLEAN;--vhdl 2008




FUNCTION delay_ms(  CONSTANT clk_freq : INTEGER; clk_count : INTEGER; delay: INTEGER  ) RETURN BOOLEAN ;
FUNCTION delay_us(CONSTANT clk_freq : INTEGER; clk_count : INTEGER; delay: INTEGER  ) RETURN BOOLEAN ;
FUNCTION udelay_machine_serial(CONSTANT clk_freq : NATURAL; clk_count : NATURAL; delays: integer_vector  ) RETURN boolean_vector;
FUNCTION mdelay_machine_parallel(CONSTANT clk_freq : NATURAL; clk_count : NATURAL; delays: integer_vector  ) RETURN boolean_vector;
end package std_delay;
PACKAGE BODY std_delay IS

-----------------------------------------------------

-----------------------------------------------------
FUNCTION delay_ms(  CONSTANT clk_freq : INTEGER; clk_count : INTEGER; delay: INTEGER  ) RETURN BOOLEAN is
begin
	--seprating INTEGER and real part
	return clk_count < (delay *  INTEGER(real(clk_freq)/1.0e3));		--(delay* clk/1000)/clk = delay(ms)

END FUNCTION;
-- ------------------------------------------------------------------------------
FUNCTION delay_us(CONSTANT clk_freq : INTEGER; clk_count : INTEGER; delay: INTEGER  ) RETURN BOOLEAN is

begin

	--seprating INTEGER and real part
	return clk_count < (delay *  INTEGER(real(clk_freq)/1.0e6));		--(delay* clk/1000)/clk = delay(ms)

END FUNCTION;
-- ------------------------------------------------------------------------------
--micro second delay generator machine
FUNCTION udelay_machine_serial(CONSTANT clk_freq : NATURAL; clk_count : NATURAL; delays: integer_vector  ) RETURN boolean_vector is
 variable ret_vect :boolean_vector(delays'range);
 CONSTANT delay_vector :integer_vector(delays'range) := accumulate(delays);
begin
	
	l0:for i in delays'low to delays'high loop
		ret_vect(i) :=  delay_us(clk_freq, clk_count, delay_vector(i));		
	END loop l0;
	
return ret_vect;

END FUNCTION;
-- ------------------------------------------------------------------------------
--micro second delay generator machine
--on elapse time this function set true output while others are false
--this function needs an pre_reterned_vector that is an backed up instance of event on reterned value 
FUNCTION mdelay_machine_parallel(CONSTANT clk_freq : NATURAL; clk_count : NATURAL; delays: integer_vector ) RETURN boolean_vector is
 variable unsorted_vect, ret_vect :boolean_vector(delays'range) := (others=>false);
 CONSTANT delay_vector :integer_vector(delays'range) := normal_sort(delays);
 CONSTANT sorted_vector :integer_vector(delays'range) := sorted_index(delays);
 
 variable tmp :integer range 0 to delays'length := 0 ;
begin
	
	l0:for i in delays'low to delays'high loop
		unsorted_vect(i) := not  delay_ms(clk_freq, clk_count, delay_vector(i));		
	END loop l0;

	l1:for i in unsorted_vect'low to unsorted_vect'high loop
			exit when not unsorted_vect(i);
			tmp:= tmp+1;
	END loop l1;

	--accurate output and map on sorted index
	l2:for i in unsorted_vect'low to unsorted_vect'high loop
				
			if( i < tmp )  then
				ret_vect(sorted_vector(i)) := false;				
			else 
				ret_vect(sorted_vector(i)) := unsorted_vect(i);
			end if;
			-- if(unsorted_vect(i)) then tmp := false; end if;
	END loop l2;
	
	
	return ret_vect;

END FUNCTION;

END PACKAGE BODY std_delay;
