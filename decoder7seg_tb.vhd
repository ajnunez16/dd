-- Alexander Nunez
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder7seg_tb is
end decoder7seg_tb;

architecture TB of decoder7seg_tb is

	component decoder7seg
		port (
                input : in std_logic_vector(3 downto 0);
                output : out std_logic_vector(6 downto 0));
   end component;
	  
	signal input : std_logic_vector(3 downto 0);
   signal output : std_logic_vector(6 downto 0);
	
begin  -- TB

	U_D7S : entity work.decoder7seg(CASE_STATEMENT)
		port map (
			input => input,
			output => output);
			
	process

	begin
	-- test all input combinations
		for i in 0 to 15 loop
			input <= std_logic_vector(to_unsigned(i,3));
			wait for 10 ns;
			
		end loop; --i
	
		wait;
	
	end process;
	
end TB;