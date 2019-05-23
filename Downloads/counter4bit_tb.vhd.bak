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
    signal up     : std_logic := '1';
    signal output : std_logic_vector(3 downto 0);

    signal done : std_logic := '0';
    
begin

    -- Change the architecture to test the different implementations
    UUT : entity work.counter4bit(BHV_INT_BAD1)
        port map (
            clk    => clk,
            rst    => rst,
            up     => up,
            output => output);

    -- create the clock (and not done ensure that the simulation will finish)
    clk <= not clk and not done after 10 ns;

    -- toggle the up input every 500 ns;
    up <= not up and not done after 500 ns;

    -- stop the simulation after 5000 ns;
    done <= '1' after 5000 ns;
    
    process
    begin
        -- reset the counter for 4 cycles
        rst <= '1';
        for i in 0 to 3 loop
            wait until rising_edge(clk);
        end loop;

        rst <= '0';
        wait until rising_edge(clk);

        -- wait until done is asserted
        wait;
               
    end process;
    
    
end TB;

