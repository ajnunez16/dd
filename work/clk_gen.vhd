library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity clk_gen is
    generic (
        ms_period : positive := 1000);          -- amount of ms for button to be
                                        -- pressed before creating clock pulse
    port (
        clk50MHz : in  std_logic;
        rst      : in  std_logic;
        button_n : in  std_logic;
        clk_out  : out std_logic);
end clk_gen;

architecture MIX of clk_gen is
	signal clk1000Hz : std_logic;
	signal count1 : natural;
	constant clk_in_freq : natural := 50000000;
	constant clk_out_freq : natural := 1000;
begin
	U_CLK_DIV : entity work.clk_div
		generic map (
			clk_in_freq => clk_in_freq,
			clk_out_freq => clk_out_freq)
		port map (
			clk_in => clk50MHz,
			rst => rst,
			clk_out =>clk1000Hz);
	process(clk1000Hz, rst)
	begin
		if (rst = '1') then
			count1 <= 0;
			clk_out <= '0';
		elsif(rising_edge(clk1000Hz)) then
			if (button_n = '0') then
				if (count1 = ms_period-1) then
					count1 <= 0;
					clk_out <= '1';
				else
					count1 <= count1 + 1;
					clk_out <= '0';
				end if;
			else
				count1 <= 0;
				clk_out <= '0';
			end if;
		end if;
	end process;
end MIX;