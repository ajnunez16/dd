library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  generic (
    width : positive := 32);
  port (
    in1    : in  std_logic_vector(width-1 downto 0);
    in2    : in  std_logic_vector(width-1 downto 0);
    sel    : in  std_logic_vector(2 downto 0);
	 shift  : in std_logic_vector(4 downto 0);
    result : out std_logic_vector(width-1 downto 0));
	 result_hi : out std_logic_vector((width/2) -1 downto 0);
	 branch_taken : out std_logic;
end alu;

architecture BHV of alu is
begin  -- GOOD1

  process(in1, in2, sel, shift)
    variable temp : unsigned(2*width-1 downto 0);
  begin
    case sel is
		-- ADD
      when "000" =>
        output<= unsigned(in1)+unsigned(in2);
		-- SUBTRACT
      when "001" =>
        output<= unsigned(in1)-unsigned(in2);
		--MULT(unsigned)
      when "010" =>
        temp := unsigned(in1) * unsigned(in2);
		  output<=temp(width -1 downto 0);
		--MULT(signed)
      when "011" =>
        temp := signed(in1) * signed(in2);
		  output<=temp;
		  -- AND
		when "100" =>
			output<=in1 and in2;
		-- SHIFT RIGHT(logical)
		when "101" =>
			output<= in1;
		-- SHIFT RIGHT(arithmetic)
		when "101" =>
			output<= in1;
		-- set on < than
		when "110" =>
			if(unsigned(in1) < unsigned(in2)) then
				output <= in1;
			else
				output <= in2;
			end if;
		-- branch taken
		when "111" =>
			ouput<=in1;
      when others => null;		
    end case;

    output <= std_logic_vector(temp);

  end process;
end BHV;