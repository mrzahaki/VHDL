--in the name of allah





---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.config.all;


--sub sign magnitude adder
entity sub_sm_adder is 
port(
	inp0,inp1	:in sm_adder_io_type;--defined in config.vhd
	outp	:out sm_adder_io_type--defined in config.vhd

);
end sub_sm_adder;

architecture structural of sub_sm_adder is

signal adder_out_to_controller: sm_adder_io_type;
signal carry_fromadder, carry_toadder: std_logic;
signal out_to_adder_io: sub_adder_vector;

begin

sm_adder_controller( To_sub_adder_vector(inp0, inp1), adder_out_to_controller, carry_fromadder, carry_toadder, out_to_adder_io, outp);
FA88:sub_adder port map(out_to_adder_io, carry_toadder, carry_fromadder, adder_out_to_controller);



end structural;

-----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.config.all;



--sub adder component
entity sub_adder is 
	port(
		inp :in sub_adder_vector; --input
		carry_in: in std_logic;
		carry_out: out std_logic; 
		outp :out sm_adder_io_type --output;
	);

end sub_adder;

architecture adder8_strct of sub_adder is

	--component definition
	component fulladder
		port(
			a, b, cin : in std_logic; --inputs
			cout, sum : out std_logic --outputs
		);
	end component;
	
	--signal definition with one useless signall
	signal carrySig : sm_adder_io_type;--default 8 downto 1

begin
	--note carrySig(sm_adder_io_width) = carry input because if carry out = 1 overflow occured and the result is posetive
		FA99:fulladder port map(inp(1)(1), inp(2)(1), carry_in	, carrySig(1), outp(1)  );
	
	GEN0:for i in 1 to (sm_adder_io_width-1) generate
			
			FA111:fulladder port map(inp(1)(i + 1), inp(2)(i + 1), carrySig(i), carrySig(i +1), outp(i + 1)  );
	
	end generate;
	
--	FA1:	fulladder port map	(inp(1)(2), inp(2)(2), carrySig(1), carrySig(2), s(2)  );
--	FA2:	fulladder port map	(inp(1)(2), inp(2)(3), carrySig(2), carrySig(3), s(3)  );
--	FA3:	fulladder port map	(inp(1)(3), inp(2)(4), carrySig(3), carrySig(4), s(4)  );
--	FA4:	fulladder port map	(inp(1)(4), inp(2)(5), carrySig(4), carrySig(5), s(5)  );
--	FA5:	fulladder port map	(inp(1)(5), inp(2)(6), carrySig(5), carrySig(6), s(6)  );
--	FA6:	fulladder port map	(inp(1)(6), inp(2)(7), carrySig(6), carrySig(7), s(7)  );
--	FA7:	fulladder port map	(inp(1)(7), inp(2)(8), carrySig(7), co			 , s(8)  );

	carry_out <= carrySig( sm_adder_io_width );
	
end adder8_strct;
--end special 8std_logic full adder entity

-------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

--start full adder entity
entity fulladder is
	port(
		a, b, cin : in std_logic; --inputs
		cout, sum : out std_logic --outputs
	);
end fulladder;

architecture adder_strct of fulladder is

	--signal definition
	signal after_xor : std_logic;

begin

	after_xor <= a xor b;
	sum <= after_xor xor cin;
	cout <= (a and b) or (cin and after_xor);

end adder_strct;
--end full adder entity



 --END WITH THE NAME OF ALLAH