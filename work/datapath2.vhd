-- Alexander Nunez
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath2 is
    generic (
        WIDTH : positive := 16);
    port (
		  x_sel, y_sel, s1_sel, s2_sel, x_en, y_en, output_en, clk, rst : in std_logic;
        x      : in  std_logic_vector(WIDTH-1 downto 0);
        y      : in  std_logic_vector(WIDTH-1 downto 0);
		  x_lt_y, x_ne_y : out std_logic;
        output : out std_logic_vector(WIDTH-1 downto 0));
end datapath2;

architecture STR of datapath2 is
	signal m1_out, m2_out, m3_out, m4_out, s_out, r1_out, r2_out : std_logic_vector(WIDTH-1 downto 0);
begin

	U_MUX1 : entity work.mux2x1 
		generic map (
			WIDTH => WIDTH)
		port map(
			sel => x_sel,
			in2 => x,
			in1 => s_out,
			output => m1_out);

	U_MUX2 : entity work.mux2x1 
		generic map (
			WIDTH => WIDTH)
		port map(
			sel => y_sel,
			in2 => y,
			in1 => s_out,
			output => m2_out);
			
	U_MUX3 : entity work.mux2x1 
		generic map (
			WIDTH => WIDTH)
		port map(
			sel => s1_sel,
			in2 => r1_out,
			in1 => r2_out,
			output => m3_out);

	U_MUX4 : entity work.mux2x1 
		generic map (
			WIDTH => WIDTH)
		port map(
			sel => s2_sel,
			in2 => r1_out,
			in1 => r2_out,
			output => m4_out);

	U_REG1 : entity work.reg 
		generic map (
			WIDTH => WIDTH)
		port map(
			clk => clk,
			rst => rst,
			load => x_en,
			input => m1_out,
			output =>r1_out);
			
	U_REG2 : entity work.reg 
		generic map (
			WIDTH => WIDTH)
		port map(
			clk => clk,
			rst => rst,
			load => y_en,
			input => m2_out,
			output =>r2_out);
	
	U_REG3 : entity work.reg 
		generic map (
			WIDTH => WIDTH)
		port map(
			clk => clk,
			rst => rst,
			load => output_en,
			input => r1_out,
			output => output);
	
			
	U_SUB1 : entity work.sub 
		generic map (
			WIDTH => WIDTH)
		port map(
			in1 => m3_out,
			in2 => m4_out,
			output => s_out);
			
			
	U_COMP : entity work.comp 
		generic map (
			WIDTH => WIDTH)
		port map(
			in1 => r1_out,
			in2 => r2_out,
			lt => x_lt_y,
			ne => x_ne_y);
end STR;