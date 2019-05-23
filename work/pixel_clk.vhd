library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity pixel_clk is
    generic(clk_in_freq  : natural := 50000000;
            clk_out_freq : natural := 25000000);
    port (
        clk  : in  std_logic;
        pixel_clk : out std_logic;
        rst     : in  std_logic);
end pixel_clk;

architecture gen of pixel_clk is
	constant PER : natural := ((clk_in_freq) / clk_out_freq );
	signal count : natural := 0;
begin
	process(clk, rst)
	begin
		if(rst = '1') then
			pixel_clk <= '0';
			count <= 0;
		elsif (rising_edge( clk )) then
			if ( count < PER - 1 ) then
				count <= count + 1;
				pixel_clk <= '0';
			else
				count <= 0;
				pixel_clk <= '1';
			end if;
		end if;
	end process;
end gen;