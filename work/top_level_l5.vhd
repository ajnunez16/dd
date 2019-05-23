-- Alexander Nunez
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;

entity top_level is
    port (
		  clk50MHz : in  std_logic;
        switch   : in  std_logic_vector(9 downto 0);
        button   : in  std_logic_vector(1 downto 0);
        led0     : out std_logic_vector(6 downto 0);
        led0_dp  : out std_logic;
        led1     : out std_logic_vector(6 downto 0);
        led1_dp  : out std_logic;
        led2     : out std_logic_vector(6 downto 0);
        led2_dp  : out std_logic;
        led3     : out std_logic_vector(6 downto 0);
        led3_dp  : out std_logic;
        led4     : out std_logic_vector(6 downto 0);
        led4_dp  : out std_logic;
        led5     : out std_logic_vector(6 downto 0);
        led5_dp  : out std_logic
        );
end top_level;

architecture STR of top_level is

    component decoder7seg
        port (
            input  : in  std_logic_vector(3 downto 0);
            output : out std_logic_vector(6 downto 0));
    end component;

	 component gcd
			generic (
			WIDTH : positive);
			port (
		  clk    : in  std_logic;
        rst    : in  std_logic;
        go     : in  std_logic;
        done   : out std_logic;
        x      : in  std_logic_vector(WIDTH-1 downto 0);
        y      : in  std_logic_vector(WIDTH-1 downto 0);
        output : out std_logic_vector(WIDTH-1 downto 0));
	end component;
    
	 constant C0              : std_logic_vector(3 downto 0) := (others => '0');
	 signal out1, out2, out3, out4, out5, out6 : std_logic_vector(3 downto 0);
	 signal dp5, dp3, dp1 : std_logic;

begin  -- STR

    U_GCD1 : entity work.gcd(FSMD)
		generic map (
			WIDTH => 8)
		port map(
			clk => clk50MHz,
			rst => not button(1),
			go => button(0),
			done => dp5,
			x => "000" & switch(9 downto 5),
			y => "000" & switch(4 downto 0),
			output(7 downto 4) => out1,
			output(3 downto 0) => out2);
	
    U_GCD2 : entity work.gcd(FSM_D1)
		generic map (
			WIDTH => 8)
		port map(
			clk => clk50MHz,
			rst => not button(1),
			go => button(0),
			done => dp3,
			x => "000" & switch(9 downto 5),
			y => "000" & switch(4 downto 0),
			output(7 downto 4) => out3,
			output(3 downto 0) => out4);
			
	U_GCD3 : entity work.gcd(FSM_D2)
		generic map (
			WIDTH => 8)
		port map(
			clk => clk50MHz,
			rst => not button(1),
			go => button(0),
			done => dp1,
			x => "000" & switch(9 downto 5),
			y => "000" & switch(4 downto 0),
			output(7 downto 4) => out5,
			output(3 downto 0) => out6);
			
	 U_LED5 : work.decoder7seg port map (
        input  => out1,
        output => led5);

    U_LED4 : work.decoder7seg port map (
        input  => out2,
        output => led4);
		  
	 U_LED3 : work.decoder7seg port map (
        input  => out3,
        output => led3);
		  
	 U_LED2 : work.decoder7seg port map (
        input  => out4,
        output => led2);
    
    U_LED1 : work.decoder7seg port map (
        input  => out5,
        output => led1);

    U_LED0 : work.decoder7seg port map (
        input  => out6,
        output => led0);
		  
	 led5_dp <= dp5;
    led4_dp <= '1';
    led3_dp <= dp3;
    led2_dp <= '1';
    led1_dp <= dp1;
    led0_dp <= '1';

end STR;