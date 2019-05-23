library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity row_addr_logic is
	port (
		Vcount : in std_logic_vector(9 downto 0);
		buttons : in std_logic_vector(3 downto 0);
		Video_On : in std_logic;
		row_en : out std_logic;
		row_addr : out std_logic_vector(6 downto 0)
	);
end row_addr_logic;

architecture BHV of row_addr_logic is
	signal Vcnt : unsigned(9 downto 0);
begin
	process(buttons, Vcount, Video_On )
	begin
		row_addr <= "0000000";
		if( Video_On = '1') then
			if( buttons(3) = '1' or buttons(2) = '1' ) then
			--top left or top right
				if( unsigned(Vcount) < to_unsigned(128, 10) ) then
					row_addr <= std_logic_vector(unsigned(Vcount(6 downto 0)));
					row_en <= '1';
				else
					row_addr <= (others => '0');
					row_en <= '0';
				end if;
			elsif( buttons(1) = '1' or buttons(0) = '1' ) then
			--bottom left or bottom right
				if( unsigned(Vcount) > to_unsigned(350, 10) ) then
					vcnt <= unsigned(Vcount)-to_unsigned(350, 10);
					row_addr <= std_logic_vector(vcnt(6 downto 0));
					row_en <= '1';
				else
					row_addr <= (others => '0');
					row_en <= '0';
				end if;
			else
			--center
				if( unsigned(Vcount) > to_unsigned(174, 10) and unsigned(Vcount) < to_unsigned(304, 10) ) then
					vcnt <= unsigned(Vcount)-to_unsigned(174, 10);
					row_addr <= std_logic_vector(vcnt(6 downto 0));
					row_en <= '1';
				else
					row_addr <= (others => '0');
					row_en <= '0';
				end if;
			end if;
			else
				row_addr <= (others => '0');
				row_en <= '0';
		end if;
	end process;
end BHV;