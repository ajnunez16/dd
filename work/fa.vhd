library ieee;
use ieee.std_logic_1164.all;

-- DO NOT CHANGE ANYTHING IN THE ENTITY

entity fa is
  port (
    input1    : in  std_logic;
    input2    : in  std_logic;
    carry_in  : in  std_logic;
    sum       : out std_logic;
    carry_out : out std_logic);
end fa;

-- DEFINE THE FULL ADDER HERE

architecture BHV of fa is
begin 
  process(input1, input2, carry_in)
  begin
	sum <= (input1 XOR input2) XOR carry_in;
	carry_out <= (input2 and carry_in) or (input1 and carry_in) or (input1 and input2);
	end process;
  
end BHV;
