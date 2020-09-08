--in the name of allah





--hussein zahaki
library ieee;
use ieee.std_logic_1164.all;


entity multiplexer4_bit is
	
	port(
		inp :in std_logic_vector(3 downto 0);
		sel:in std_logic_vector(1 downto 0);
		pout:  out std_logic
	);
	
end multiplexer4_bit;
--if statement
architecture if_then_else of multiplexer4_bit is 

begin

	std_process : process (inp,sel)
	begin
		if sel="00" then pout <= inp(0);
			elsif sel="01" then pout <= inp(1);
				elsif sel="10" then pout <= inp(2);
				else pout <= inp(2);
		end if;
	
	end process std_process;


end if_then_else;

--case statement
architecture case_mode of multiplexer4_bit is 

begin
	std_process : process (inp,sel)
	begin
	
		case sel is
			when "00" => pout <= inp(0);
			when "01" => pout <= inp(1);
			when "10" => pout <= inp(2);
			when others => pout <= inp(3);
	
		end case;
		
	end process std_process;

end case_mode;
 
 
--with select mode
architecture with_select of multiplexer4_bit is 

begin
	--unprocess conditional
		with sel select
			pout <=	inp(0)	when "00",  
				inp(1)	when "01", 
				inp(2)	when "10", 
				inp(3)	when others; 

end with_select;

----when else mode
architecture when_else of multiplexer4_bit is 
begin
	--unprocess conditional

			
	pout <=	inp(0)	when sel = "00"	else  
				inp(1)	when sel = "01"	else 
				inp(2)	when sel = "10"	else 
				inp(3); 
	



end when_else;
--end with the name of allah
