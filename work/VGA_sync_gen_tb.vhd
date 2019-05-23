library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity VGA_sync_gen_tb is
end VGA_sync_gen_tb;

architecture TB of VGA_sync_gen_tb is
	signal clk : std_logic := '0';
	signal rst : std_logic := '0';
	signal Hcount, Vcount : std_logic_vector(9 downto 0);
	signal Horiz_Sync, Vert_Sync, Video_On : std_logic;
begin
	
	UUT : entity work.VGA_sync_gen
		port map (
			clk => clk,
			rst => rst,
			Hcount => Hcount,
			Vcount => Vcount,
			Horiz_Sync => Horiz_Sync,
			Vert_Sync => Vert_Sync,
			Video_On => Video_on);
	
	clk <= not clk after 10 ns;

	process
		variable before_time, after_time : time;
	begin
	
		rst <= '1';
		wait for 200 ns;
		rst <= '0';
	
		wait until unsigned(Vcount) = to_unsigned( VSYNC_BEGIN, 10 ) for 3 ms;
		before_time := now;
		wait until unsigned(Vcount) = to_unsigned( VSYNC_END, 10 ) for 3 ms;
		after_time := now;
		report "Vert_Sync time is " & time'image(after_time-before_time);
		
		assert(unsigned(Hcount) = to_unsigned( H_MAX, 10 ) + 2) report "Hcount passed H_MAX." severity warning;
		assert(unsigned(Vcount) = to_unsigned( V_MAX, 10 ) + 2) report "Vcount passed V_MAX." severity warning;
		assert( ( unsigned(Hcount) < to_unsigned( HSYNC_BEGIN, 10 ) -2 or unsigned(Hcount) > to_unsigned( HSYNC_END, 10 ) +2) and Horiz_Sync = '0' )  report "Horiz_Sync should be 1" severity warning;
		assert( Vert_Sync = '0' and ( unsigned(Vcount) < to_unsigned( VSYNC_BEGIN, 10 ) -2 or unsigned(Vcount) > to_unsigned( VSYNC_END, 10 ) +2) ) report "Vert_Sync should be 1" severity warning;
		assert( Video_On <= '1' and unsigned(Hcount) > to_unsigned( H_DISPLAY_END, 10) +2) report "Video_on should be 0." severity warning;
		
		wait;
		
	end process;
end TB;