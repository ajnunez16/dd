-- Greg Stitt
-- University of Florida
--
-- This is a top level entity for bit_diff that can be used to synthesize
-- different architectures.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
  generic (
    width  :     positive := 16);
  port (
    clk    : in  std_logic;
    rst    : in  std_logic;
    go     : in  std_logic;
    input  : in  std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width-1 downto 0);
    done   : out std_logic);
end top_level;

architecture STR of top_level is
begin  

  -- change the architecture name to synthesize each version
  
  U_BIT_DIFF : entity work.bit_diff(FSMD_2P)
    generic map (
      width => width)
    port map (
      clk    => clk,
      rst    => rst,
      go     => go,
      input  => input,
      output => output,
      done   => done);

end STR;
