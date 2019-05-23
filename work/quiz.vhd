-- Greg Stitt
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity quiz is
	port (
		clk, rst   : in  std_logic;
      output : out std_logic_vector(3 downto 0));
end quiz;

architecture BHV_UNSIGNED of quiz is
    -- use a 4 bit unsigned instead of an integer.
	signal up : std_logic:='1';
	signal count : unsigned(3 downto 0);
begin
   process(clk, rst)
   begin
		if (rst = '1') then
			count <= "0000";
      elsif (rising_edge(clk)) then
			if (up = '1') then
				count <= count + 1;
				if (count = "1110") then
					up <= '0';
				end if;
         else
            count <= count - 1;
				if (count = "0001") then
					up <= '1';
				end if;
         end if;
		end if;
	end process;
	

    output <= std_logic_vector(count);
       
end BHV_UNSIGNED;


