-- Alexander Nunez
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity vga is
    port (
		  clk50MHz : in  std_logic;
		  rst : in  std_logic;
        switch   : in  std_logic_vector(3 downto 0);
		  red : out std_logic_vector(3 downto 0);
		  green : out std_logic_vector(3 downto 0);
		  blue : out std_logic_vector(3 downto 0);
		  h_sync : out std_logic;
		  v_sync : out std_logic
		  );
end vga;

architecture STR of vga is
	
	signal clk : std_logic;
	signal v_on : std_logic;
	signal r_e : std_logic;
	signal c_e : std_logic;
	signal hcnt, vcnt : std_logic_vector(9 downto 0);
	signal row, col : std_logic_vector(6 downto 0);
	signal colors, display : std_logic_vector(11 downto 0);
	signal addr : std_logic_vector(13 downto 0);
	signal enable : std_logic;
	
begin  -- STR

	U_PIX : entity work.pixel_clk port map (
		clk => clk50MHz,
		pixel_clk => clk,
		rst => rst);
		
   U_VGA : entity work.VGA_sync_gen port map (
		clk => clk,
		rst => rst,
		Hcount => hcnt,
		Vcount => vcnt,
		Horiz_Sync => h_sync,
		Vert_Sync => v_sync,
		Video_On => v_on);
		
	U_ROW : entity work.row_addr_logic port map (
		Vcount => vcnt,
		buttons => switch,
		Video_On => v_on,
		row_en => r_e,
		row_addr => row);
	
	U_COL : entity work.col_addr_logic port map (
		Hcount => hcnt,
		buttons => switch,
		Video_On => v_on,
		col_en => c_e,
		col_addr => col);
	
	addr <= row & col;
	
	U_ROM : entity work.vga_rom128_1 port map (
		address => addr,
		clock => clk,
		q => colors);
		
	enable <= r_e and c_e;
		
	U_MUX : entity work.mux2x1 generic map (
			width => 12)
		port map (
			in1 => colors,
			in2 => ( others => '0'),
			sel => enable,
			output => display);
			
	red <= display(11 downto 8);
	green <= display(7 downto 4);
	blue <= display(3 downto 0);
	
end STR;