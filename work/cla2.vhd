-- Alexander Nunez
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;

entity cla2 is
	port (
			x, y : in  std_logic_vector(1 downto 0);
			cin  : in  std_logic;
			s    : out std_logic_vector(1 downto 0);
			cout, bp, bg : out std_logic);
end cla2;

architecture BHV of cla2 is
	signal carry, g0, p0, g1, p1 : std_logic;
begin
	process(x, y, cin)
		begin
			g0 <= x(0) and y(0);
			p0 <= x(0) or y(0);
			carry <= g0 or (p0 and cin);
			s(0) <=	cin XOR x(0) XOR y(0);
			p1 <= x(1) or y(1);
			g1 <= x(1) and y(1);
			s(1) <= carry XOR y(1) xor x(1);
			cout <= (carry and p1) or g1;
			bp <= p1 and p0;
			bg <= g1 or (p1 and g0);
	end process;
end BHV;