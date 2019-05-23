library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity clk_div is
    generic(clk_in_freq  : natural := 50000000;
            clk_out_freq : natural := 1000);
    port (
        clk_in  : in  std_logic;
        clk_out : out std_logic;
        rst     : in  std_logic);
end clk_div;

architecture div of clk_div is
	constant PER : natural := ((clk_in_freq) / clk_out_freq );
	signal count : natural := 0;
begin
	process(clk_in, rst)
	begin
		if(rst = '1') then
			clk_out <= '0';
			count <=0;
		elsif (rising_edge(clk_in)) then
			if (count < PER) then
				count <= count + 1;
				clk_out <= '0';
			else
				count <= 0;
				clk_out <= '1';
			end if;
		end if;
	end process;
end div;