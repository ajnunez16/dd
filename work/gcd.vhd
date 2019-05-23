library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gcd is
    generic (
        WIDTH : positive := 16);
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        go     : in  std_logic;
        done   : out std_logic;
        x      : in  std_logic_vector(WIDTH-1 downto 0);
        y      : in  std_logic_vector(WIDTH-1 downto 0);
        output : out std_logic_vector(WIDTH-1 downto 0));
end gcd;

architecture FSMD of gcd is
	type state_type is (S_START, S_INIT, S_LOOP_COND, S_LOOP_BODY, S_DONE);
	signal state : state_type;
	signal tmpX, tmpY : std_logic_vector(WIDTH-1 downto 0);
begin  -- FSMD
	process(clk, rst)
	begin
		if (rst = '1') then
			output <= (others => '0');
			done <= '0';
			state <= S_START;
		elsif (rising_edge(clk)) then
			case state is 
				when S_START =>
					if (go = '1') then
						state <= S_INIT;
					else
						state <= S_START;
					end if;
				when S_INIT =>
					done <= '0';
					tmpX <= x;
					tmpY <= y;
					state <= S_LOOP_COND;
				when S_LOOP_COND =>
					if (tmpX = tmpY) then
						state <= S_DONE;
					else
						state <= S_LOOP_BODY;
					end if;
				when S_LOOP_BODY =>
					if ( tmpX < tmpY) then
						tmpY <= std_logic_vector(unsigned(tmpY) - unsigned(tmpX));
					else
						tmpX <= std_logic_vector(unsigned(tmpX) - unsigned(tmpY));
					end if;
					state <= S_LOOP_COND;
				when S_DONE =>
					output <= tmpX;
					done <= '1';
					if (go = '0') then
						state <= S_START;
					else
						state <= S_DONE;
					end if;
				when others => null;
			end case;
		end if;
	end process;
end FSMD;

architecture FSM_D1 of gcd is
	signal x_s, y_s, x_e, y_e, lt, ne, o_e : std_logic;
begin  -- FSM_D1
	U_DATA : entity work.datapath1
		generic map (
			WIDTH => WIDTH)
		port map(
			x_sel => x_s,
			y_sel => y_s,
			x_en => x_e,
			y_en => y_e,
			output_en => o_e,
			clk => clk,
			rst => rst,
			x => x,
			y => y,
			x_lt_y => lt,
			x_ne_y => ne,
			output => output);
		
	U_CTRL : entity work.ctrl1 
		generic map (
			WIDTH => WIDTH)
		port map(
			x_lt_y => lt,
			x_ne_y => ne,
			clk => clk,
			rst => rst,
			go => go,
			x_sel => x_s,
			y_sel => y_s,
			x_en => x_e,
			y_en => y_e,
			output_en  => o_e, 
			done => done);
end FSM_D1;

architecture FSM_D2 of gcd is
	signal x_s, y_s, s1_s, s2_s, x_e, y_e, lt, ne, o_e : std_logic;
begin  -- FSM_D2
	U_DATA : entity work.datapath2 
		generic map (
			WIDTH => WIDTH)
		port map(
			x_sel => x_s,
			y_sel => y_s,
			s1_sel => s1_s,
			s2_sel => s2_s,
			x_en => x_e,
			y_en => y_e,
			output_en => o_e,
			clk => clk,
			rst => rst,
			x => x,
			y => y,
			x_lt_y => lt,
			x_ne_y => ne,
			output => output);
		
	U_CTRL : entity work.ctrl2 
		generic map (
			WIDTH => WIDTH)
		port map(
			x_lt_y => lt,
			x_ne_y => ne,
			clk => clk,
			rst => rst,
			go => go,
			x_sel => x_s,
			y_sel => y_s,
			s1_sel => s1_s,
			s2_sel => s2_s,
			x_en => x_e,
			y_en => y_e,
			output_en  => o_e, 
			done => done);
end FSM_D2;


-- EXTRA CREDIT
architecture FSMD2 of gcd is

begin  -- FSMD2



end FSMD2;
