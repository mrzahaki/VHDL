-- W  T  A

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package std_mux is
	
component mux 
	generic(
		input_high : integer;
		select_high : integer	
	);
    Port ( inp   	: in  STD_LOGIC_VECTOR (input_high downto 0);     -- inputs
           sel 	: in  STD_LOGIC_VECTOR (select_high downto 0);     -- select input
			  outp   : out STD_LOGIC												-- output
	);                        
end component;

end package std_mux;
package body std_mux is


end package body std_mux;
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std;
use work.std_mux.ALL;

entity mux is
	generic(
		input_high : integer;
		select_high : integer	
	);
    Port ( inp   	: in  STD_LOGIC_VECTOR (input_high downto 0);     -- inputs
           sel 	: in  STD_LOGIC_VECTOR (select_high downto 0);     -- select input
			  outp   : out STD_LOGIC												-- output
	);                        
end mux;

architecture Behavioral of mux is
begin
--
--type data_bus_array is array(7 downto 0) of std_logic_vector (31 downto 0);
--signal din :data_bus_array;
--signal dout :std_logic_vector (31 downto 0);
--signal sel :std_logic_vector (3 downto 0);
--...
outp <= inp(numeric_std.to_integer( numeric_std.unsigned(sel) ));


end Behavioral;
