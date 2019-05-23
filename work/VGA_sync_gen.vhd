library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity VGA_sync_gen is
	port (
		clk : in std_logic;
		rst : in std_logic;
		Hcount : out std_logic_vector(9 downto 0);
		Vcount : out std_logic_vector(9 downto 0);
		Horiz_Sync, Vert_Sync, Video_On : out std_logic);
end VGA_sync_gen;

architecture BHV of VGA_sync_gen is
	signal hcnt, vcnt : unsigned(9 downto 0);
begin
	process( clk, rst )
	begin
		if ( rst = '1' ) then
			hcnt <= (others => '0');
			vcnt <= (others => '0');
		elsif (rising_edge( clk )) then
			hcnt <= hcnt + 1;
			if ( hcnt = H_MAX) then
				hcnt <= (others => '0');
			end if;
			if ( hcnt = H_VERT_INC ) then
				vcnt <= vcnt + 1;
				if ( vcnt = V_MAX) then
					vcnt <= (others => '0');
				end if;
			end if;
		end if;
	end process;
	Hcount <= std_logic_vector( hcnt );
	VCount <= std_logic_vector( vcnt );
	Horiz_Sync <= '0' when ( hcnt >= HSYNC_BEGIN and hcnt <= HSYNC_END ) else '1';
	Vert_Sync <= '0' when ( vcnt >= VSYNC_BEGIN and vcnt <= VSYNC_END ) else '1';
	Video_On <= '1' when ( hcnt <= H_DISPLAY_END and vcnt <= V_DISPLAY_END ) else '0';
end BHV;