library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

entity col_addr_logic is
	port (
		Hcount : in std_logic_vector(9 downto 0);
		buttons : in std_logic_vector(3 downto 0);
		Video_On : in std_logic;
		col_en : out std_logic;
		col_addr : out std_logic_vector(6 downto 0)
	);
end col_addr_logic;

architecture BHV of col_addr_logic is
begin
	process(buttons, Hcount, Video_On)
	begin
		col_addr <= "0000000";
		if( Video_On = '1') then
			if( buttons(3) = '1' or buttons(1) = '1' ) then
			--top left or bottom left
				if( unsigned(Hcount) < to_unsigned(128, 10) ) then
					col_addr <= std_logic_vector(unsigned(Hcount(6 downto 0)));
					col_en <= '1';
				else
					col_addr <= (others => '0');
					col_en <= '0';
				end if;
			elsif( buttons(2) = '1' or buttons(0) = '1' ) then
			--top right or bottom right
				if( unsigned(Hcount) > to_unsigned(510, 10) ) then
					col_addr <= std_logic_vector(unsigned(Hcount(6 downto 0)));
					col_en <= '1';
				else
					col_addr <= (others => '0');
					col_en <= '0';
				end if;
			else
			--center
				if( unsigned(Hcount) > to_unsigned(254, 10) and unsigned(Hcount) < to_unsigned(384, 10) ) then
					col_addr <= std_logic_vector(unsigned(Hcount(6 downto 0)));
					col_en <= '1';
				else
					col_addr <= (others => '0');
					col_en <= '0';
				end if;
			end if;
		else
			col_addr <= (others => '0');
			col_en <= '0';
		end if;
	end process;
end BHV;