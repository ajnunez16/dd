-- Alexander Nunez
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;

entity cgen2 is
	port (
		c0, p0, g0, p1, g1 : in std_logic;
		c1, c2, bp, bg : out std_logic);
	end cgen2;
	
architecture BHV of cgen2 is
begin
	process(c0, p0, g0, p1, g1)
	begin
		c1 <= g0 or (p0 and c0);
		c2 <= g1 or (p1 and g0) or (p1 and p0 and c0);
		bp <= p1 and p0;
		bg <= g1 or (p1 and g0);
	end process;
end BHV;