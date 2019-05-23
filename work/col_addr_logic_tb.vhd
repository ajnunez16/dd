library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity col_addr_logic_tb is
end col_addr_logic_tb;

architecture TB of col_addr_logic_tb is
	signal hcount : unsigned(9 downto 0);
	signal button : unsigned(3 downto 0);
	signal v_on, c_e : std_logic;
	signal col : std_logic_vector(5 downto 0);
begin
	UUT : entity work.col_addr_logic
		port map (
			Hcount => std_logic_vector(hcount),
			buttons => std_logic_vector(button),
			Video_on => v_on,
			col_en => c_e,
			col_addr => col);
			
	process
	begin
	
		v_on <= '0';
		button <= "0000";
		hcount <= (others => '0');
		
		wait for 20 ns;
		v_on <= '1';
		
		for i	in 0 to 15 loop
			for j in 0 to H_MAX loop
				button <= to_unsigned( i, 4 );
				hcount <= to_unsigned( j, 10 );
				wait for 10 ns;
			end loop;
		end loop;
		
		wait;
	end process;
	
end TB;