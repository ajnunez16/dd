-- Greg Stitt
-- University of Florida

-- The following testbench generates inputs for the counter4bit entity. Make
-- sure to change the architecture that is instantiated to test each
-- implementation. 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity counter4bit_tb is
end counter4bit_tb;


architecture TB of counter4bit_tb is
    signal clk    : std_logic := '0';
    signal rst    : std_logic := '0';
    signal up_n     : std_logic := '1';
	 signal load_n     : std_logic := '1';
	 signal load : std_logic_vector( 3 downto 0) := "0000";
    signal output : std_logic_vector(3 downto 0);
    signal done : std_logic := '0';
    
begin

    -- Change the architecture to test the different implementations
    UUT : entity work.counter4bit
        port map (
            clk    => clk,
            rst    => rst,
            up_n     => up_n,
				load_n => load_n,
				load => load,
            output => output);

    -- create the clock (and not done ensure that the simulation will finish)
    clk <= not clk and not done after 10 ns;

    -- toggle the up input every 500 ns;
    up_n <= not up_n and not done after 500 ns;

	 -- toggle the load input every 500 ns;
    load_n <= not load_n and not done after 1500 ns;
	 
    -- stop the simulation after 5000 ns;
    done <= '1' after 5000 ns;
    
    process
    begin
		  load <= "1010";
        -- reset the counter for 4 cycles
        rst <= '1';
        for i in 0 to 3 loop
            wait until rising_edge(clk);
        end loop;
			
		  load <= "0101";
        rst <= '0';
        wait until rising_edge(clk);

        -- wait until done is asserted
        wait;
               
    end process;
    
    
end TB;

