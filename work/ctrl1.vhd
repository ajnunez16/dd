-- Alexander Nunez
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrl1 is
    generic (
        WIDTH : positive := 16);
    port (
		x_lt_y, x_ne_y, clk, rst, go : in std_logic;
		x_sel, y_sel, x_en, y_en, output_en, done : out std_logic);
end ctrl1;

architecture BHV of ctrl1 is
	type state_type is (S_START, S_LOOP_COND, S_LOOP_BODY, S_OUT);
	signal state, next_state : state_type;
begin
	process(clk, rst)
	begin
		if (rst = '1') then
			state <= S_START;
		elsif (rising_edge(clk)) then
			state <= next_state;
		end if;
	end process;
	
	process(state, x_lt_y, x_ne_y, go)
	begin
		case state is
			when S_START =>
				if (go = '1') then
					next_state <= S_LOOP_COND;
					done <= '0';
					x_en <= '1';
					y_en <= '1';
					x_sel <= '0';
					y_sel <= '0';
					output_en <= '0';
				else
					next_state <= S_START;
					x_en <= '0';
					y_en <= '0';
					x_sel <= '0';
					y_sel <= '0';
					output_en <= '0';
					done <= '0';
				end if;
			when S_LOOP_COND =>
				x_en <= '0';
				y_en <= '0';
				if ( x_ne_y = '1') then
					next_state <= S_LOOP_BODY;
					done <= '0';
				else
					next_state <= S_OUT;
					output_en <= '1';
					done <= '1';
				end if;
			when S_LOOP_BODY =>
				done <= '0';
				if ( x_lt_y = '1') then
					y_sel <= '1';
					y_en <= '1';
				else
					x_sel <= '1';
					x_en <= '1';
				end if;
				next_state <= S_LOOP_COND;
			when S_OUT =>
				output_en <= '1';
				done <= '1';
				if (go ='1') then
					next_state <= S_OUT;
				else
					next_state <= S_START;
				end if;
			when others => null;
		end case;
	end process;
end BHV;