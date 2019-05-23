library ieee;
use ieee.std_logic_1164.all;

entity gray2_tb is
end gray2_tb;

architecture TB of gray2_tb is
	signal clk, rst, en : std_logic := '0';
	signal output : std_logic_vector(3 downto 0);
begin
	U_GRAY1 : entity work.gray2
		port map (
			clk => clk,
			rst => rst,
			en => en,
			output => output);
			
	clk <= not clk after 5 ns;
	
	process
	begin
		rst <= '1';
		en <= '0';
		for i in 0 to 15 loop
			wait until clk'event and clk = '1';
		end loop;	--i
		
		rst <= '0';
		wait until clk'event and clk = '1';
		
		for i in 0 to 1000 loop
			for j in 0 to 15 loop
				en <= '1';
				wait until clk'event and clk = '1';
			end loop;	--j
			
			en <= '0';
			wait until clk'event and clk = '1';
		end loop;	--i
	end process;
end TB;