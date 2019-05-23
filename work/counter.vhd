-- Greg Stitt
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	port (
		clk, rst, up_n, load_n    : in  std_logic;
		input : in std_logic_vector(3 downto 0);
      output : out std_logic_vector(3 downto 0));
end counter;

architecture BHV_UNSIGNED of counter is
    -- use a 4 bit unsigned instead of an integer.
	signal count : unsigned(3 downto 0);
    
begin
   process(clk, rst)
   begin
		if (rst = '1') then
			count <= "0000";
      elsif (rising_edge(clk)) then
			if(load_n = '0') then
				count <= unsigned(input);
         elsif (up_n = '0') then
				count <= count + 1;
         else
            count <= count - 1;
         end if;
		end if;
	end process;

    output <= std_logic_vector(count);
       
end BHV_UNSIGNED;


