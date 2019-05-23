-- Alexander Nunez
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;

entity cla4 is
	port (
			x, y : in  std_logic_vector(3 downto 0);
			cin  : in  std_logic;
			s    : out std_logic_vector(3 downto 0);
			cout, bp, bg : out std_logic);
end cla4;

architecture STR of cla4 is
	signal cla1_c, cla1_p, cla1_g, cla2_p, cla2_g, cgen_c : std_logic;
begin
	
	U_CLA1 : entity work.cla2 port map (
			x => x(1 downto 0),
			y => y(1 downto 0),
			cin => cin,
			s => s(1 downto 0),
			cout => cla1_c,
			bp => cla1_p,
			bg => cla1_g
	);
	
	U_CLA2 : entity work.cla2 port map (
			x => x(3 downto 2),
			y => y(3 downto 2),
			cin => cgen_c,
			s => s(3 downto 2),
			bp => cla2_p,
			bg => cla2_g
	);
	
	U_CGEN : entity work.cgen2 port map (
			c0 => cla1_c,
			g0 => cla1_g,
			p0 => cla1_p,
			p1 => cla2_p,
			g1 => cla2_g,
			c1 => cgen_c,
			bp => bp,
			bg => bg,
			c2 => cout
	);
		
end STR;