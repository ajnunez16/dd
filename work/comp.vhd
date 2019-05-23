-- Greg Stitt
-- University of Florida
--
-- This file implements a comparator with two different architectures. One
-- assumes the inputs are unsigned and the other assumes signed. Make sure to
-- specify the appropriate architecture when instantiating comp, otherwise the
-- synthesis tool may choose one that you did not intend.
--
-- This is a good example of when it is appropriate to use multiple
-- architectures. 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comp is
  generic (
    width :     positive := 16);
  port (
    in1   : in  std_logic_vector(width-1 downto 0);
    in2   : in  std_logic_vector(width-1 downto 0);
    lt    : out std_logic;
    ne    : out std_logic;
    gt    : out std_logic);
end comp;

architecture UNSIGNED_INPUTS of comp is
begin
  lt <= '1' when unsigned(in1) < unsigned(in2) else '0';
  ne <= '0' when unsigned(in1) = unsigned(in2) else '1';
  gt <= '1' when unsigned(in1) > unsigned(in2) else '0';
end UNSIGNED_INPUTS;

architecture SIGNED_INPUTS of comp is
begin
  lt <= '1' when signed(in1) < signed(in2) else '0';
  ne <= '0' when signed(in1) = signed(in2) else '1';
  gt <= '1' when signed(in1) > signed(in2) else '0';
end SIGNED_INPUTS;
