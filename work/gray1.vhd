library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gray1 is
	port (
		clk, rst, en : in std_logic;
		output : out std_logic_vector(3 downto 0));
end gray1;

architecture FSM of gray1 is
	type state_type is (STATE_0, STATE_1, STATE_2, STATE_3, STATE_4, STATE_5, STATE_6, STATE_7, STATE_8, STATE_9, STATE_A, STATE_B, STATE_C, STATE_D, STATE_E, STATE_F);
		signal state: state_type;
	begin
		process(clk, rst)
		begin
			if (rst = '1') then
				output <= "0000";
				state <= STATE_0;
			elsif(clk'event and clk = '1') then
				case state is
					when STATE_0 =>
						output <= "0000";
						if (en = '1') then
							state <= STATE_1;
						end if;
					when STATE_1 =>
						output <= "0001";
						if (en = '1') then
							state <= STATE_3;
						end if;
					when STATE_3 =>
						output <= "0011";
						if (en = '1') then
							state <= STATE_2;
						end if;
					when STATE_2 =>
						output <= "0010";
						if (en = '1') then
							state <= STATE_6;
						end if;
					when STATE_6 =>
						output <= "0110";
						if (en = '1') then
							state <= STATE_7;
						end if;
					when STATE_7 =>
						output <= "0111";
						if (en = '1') then
							state <= STATE_5;
						end if;
					when STATE_5 =>
						output <= "0101";
						if (en = '1') then
							state <= STATE_4;
						end if;
					when STATE_4 =>
						output <= "0100";
						if (en = '1') then
							state <= STATE_C;
						end if;
					when STATE_C =>
						output <= "1100";
						if (en = '1') then
							state <= STATE_D;
						end if;
					when STATE_D =>
						output <= "1101";
						if (en = '1') then
							state <= STATE_F;
						end if;
					when STATE_F =>
						output <= "1111";
						if (en = '1') then
							state <= STATE_E;
						end if;
					when STATE_E =>
						output <= "1110";
						if (en = '1') then
							state <= STATE_A;
						end if;
					when STATE_A =>
						output <= "1010";
						if (en = '1') then
							state <= STATE_B;
						end if;
					when STATE_B =>
						output <= "1011";
						if (en = '1') then
							state <= STATE_9;
						end if;
					when STATE_9 =>
						output <= "1001";
						if (en = '1') then
							state <= STATE_8;
						end if;
					when STATE_8 =>
						output <= "1000";
						if (en = '1') then
							state <= STATE_0;
						end if;
					when others => null;
				end case;
			end if;
		end process;
end FSM;