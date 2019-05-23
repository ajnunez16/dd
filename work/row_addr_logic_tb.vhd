library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity row_addr_logic_tb is
end row_addr_logic_tb;

architecture TB of row_addr_logic_tb is
	signal vcount : unsigned(9 downto 0);
	signal button : unsigned(3 downto 0);
	signal v_on, r_e : std_logic;
	signal row : std_logic_vector(5 downto 0);
begin
	UUT : entity work.row_addr_logic
		port map (
			Vcount => std_logic_vector(vcount),
			buttons => std_logic_vector(button),
			Video_on => v_on,
			row_en => r_e,
			row_addr => row);
			
	process
	begin
	
	
	
		v_on <= '0';
		button <= "0000";
		vcount <= (others => '0');
		
		wait for 20 ns;
		v_on <= '1';
		
		for i	in 0 to 15 loop
			for j in 0 to V_MAX loop
				button <= to_unsigned( i, 4 );
				vcount <= to_unsigned( j, 10 );
				wait for 10 ns;
			end loop;
		end loop;
		
		wait;
	end process;
	
end TB;