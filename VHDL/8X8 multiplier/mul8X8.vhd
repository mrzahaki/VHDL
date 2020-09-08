-- IN THE NAME OF ALLAH


--hossein zahaki
library ieee;
use ieee.std_logic_1164.all;



--start mul8X8 entity
entity mul8X8 is
	
	port(
		x, y :in std_logic_vector(7 downto 0); --input
		mulRes :out std_logic_vector(15 downto 0) --output multiplier result
	);

end mul8X8;

architecture mul_strct of mul8X8 is
	
	--component definition
	component sp8std_logicAdder
		port(
			c, d :in std_logic_vector(7 downto 0); --input
			co : out std_logic; s :out std_logic_vector(7 downto 0) --outputs
		);
	end component;


	signal adder1_sum:std_logic_vector(7 downto 0);
	signal adder2_sum:std_logic_vector(7 downto 0);
	signal adder3_sum:std_logic_vector(7 downto 0);
	signal adder4_sum:std_logic_vector(7 downto 0);
	signal adder5_sum:std_logic_vector(7 downto 0);
	signal adder6_sum:std_logic_vector(7 downto 0);
	signal adder7_sum:std_logic_vector(7 downto 0);
	
begin
	
	mulRes(0) <=  x(0) and y(0);

	
	--first 8 bit summer
	FA81: sp8std_logicAdder port map (
		--ones input
		c(6 downto 0) =>  (x(7 downto 1) and (x(7 downto 1)'Range => y(0)) ),
		c(7) => '0',
		--second input
		d => (x and (x'Range => y(1)) ),
		--cout
		co => adder1_sum(7),
		--sum out
		s(0) => mulRes(1),
		s(7 downto 1) => adder1_sum(6 downto 0)
	);
	
	--2'st 8 bit summer
	FA82: sp8std_logicAdder port map(
		--ones input
		c => adder1_sum,
		--second input
		d => (x and (x'Range => y(2)) ),
		--cout
		co => adder2_sum(7),
		--sum out
		s(0) => mulRes(2),
		s(7 downto 1) => adder2_sum(6 downto 0)
	);
	
	--3'st 8 bit summer
	FA83: sp8std_logicAdder port map(
		--ones input
		c => adder2_sum,
		--second input
		d => (x and (x'Range => y(3)) ),
		--cout
		co => adder3_sum(7),
		--sum out
		s(0) => mulRes(3),
		s(7 downto 1) => adder3_sum(6 downto 0)
	); 

--4'st 8 bit summer	
	FA84: sp8std_logicAdder port map(
		--ones input
		c => adder3_sum,
		--second input
		d => (x and (x'Range => y(4)) ),
		--cout
		co => adder4_sum(7),
		--sum out
		s(0) => mulRes(4),
		s(7 downto 1) => adder4_sum(6 downto 0)
	); 

--5'st 8 bit summer
	FA85: sp8std_logicAdder port map (
		--ones input
		c => adder4_sum,
		--second input
		d => (x and (x'Range => y(5)) ),
		--cout
		co => adder5_sum(7),
		--sum out
		s(0) => mulRes(5),
		s(7 downto 1) => adder5_sum(6 downto 0)
	);

--6'st 8 bit summer
	FA86: sp8std_logicAdder port map (
		--ones input
		c => adder5_sum,
		--second input
		d => (x and (x'Range => y(6)) ),
		--cout
		co => adder6_sum(7),
		--sum out
		s(0) => mulRes(6),
		s(7 downto 1) => adder6_sum(6 downto 0)
	);

--7'st 8 bit summer
	FA87: sp8std_logicAdder port map (
		--ones input
		c => adder6_sum,
		--second input
		d => (x and (x'Range => y(7)) ),
		--cout
		co => mulRes(15),
		--sum out
		s(7 downto 0) => mulRes(14 downto 7)
	);
	

end mul_strct;

---------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;


--start special 8std_logic full adder entity
entity sp8std_logicAdder is 
	port(
		c, d :in std_logic_vector(7 downto 0); --input
		co : out std_logic; s :out std_logic_vector(7 downto 0) --outputs
	);

end sp8std_logicAdder;

architecture adder8_strct of sp8std_logicAdder is

	--component definition
	component fulladder
		port(
			a, b, cin : in std_logic; --inputs
			cout, sum : out std_logic --outputs
		);
	end component;
	
	--signal definition
	signal carrySig : std_logic_vector(7 downto 1);

begin
	
	FA0:	fulladder port map	(c(0), d(0), '0'			, carrySig(1), s(0)  );
	FA1:	fulladder port map	(c(1), d(1), carrySig(1), carrySig(2), s(1)  );
	FA2:	fulladder port map	(c(2), d(2), carrySig(2), carrySig(3), s(2)  );
	FA3:	fulladder port map	(c(3), d(3), carrySig(3), carrySig(4), s(3)  );
	FA4:	fulladder port map	(c(4), d(4), carrySig(4), carrySig(5), s(4)  );
	FA5:	fulladder port map	(c(5), d(5), carrySig(5), carrySig(6), s(5)  );
	FA6:	fulladder port map	(c(6), d(6), carrySig(6), carrySig(7), s(6)  );
	FA7:	fulladder port map	(c(7), d(7), carrySig(7), co			 , s(7)  );
	
end adder8_strct;
--end special 8std_logic full adder entity

---------------------------------------------------------------------------------------------------
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

-- END WITH THE NAME OF ALLAH
