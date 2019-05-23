library ieee;

   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
	
	
entity alu_ns is
     generic (
           WIDTH : positive := 16
		); 
	port (
			input1 : in std_logic_vector(WIDTH-1 downto 0); 
			input2 : in std_logic_vector(WIDTH-1 downto 0); 
			sel : in std_logic_vector(3 downto 0);
			output : out std_logic_vector(WIDTH-1 downto 0); 
			overflow : out std_logic);
   end alu_ns;
	
architecture BHV of alu_ns is
begin

	process(input1, input2, sel)
		variable temp_add: std_logic_vector(WIDTH downto 0);
		variable temp_mult: std_logic_vector(WIDTH*2-1 downto 0);
	begin
	
		overflow <= '0';
		case sel is
			when "0000" =>
				-- ADD
				temp_add := std_logic_vector(unsigned('0' & input1) + unsigned('0' & input2));
				overflow <= temp_add(WIDTH);
				output <= temp_add(WIDTH-1 downto 0);
			when "0001" =>
				-- SUB
				output <= std_logic_vector(unsigned(input1) - unsigned(input2));
			when "0010" =>
				-- MULT
				temp_mult := std_logic_vector(unsigned(input1) * unsigned(input2));
				output <= temp_mult(WIDTH-1 downto 0);
				if (temp_mult(2*WIDTH-1 downto WIDTH) > std_logic_vector(to_unsigned(0,WIDTH))) then
					overflow <= '1';
				end if;
				
			when "0011" =>
				-- AND
				output <= input1 AND input2;
				
			when "0100" =>
				-- OR
				output <= input1 OR input2;
				
			when "0101" =>
				-- XOR
				output <= input1 XOR input2;
				
			when "0110" =>
				-- NOR
				output <= input1 NOR input2;
				
			when "0111" =>
				-- NOT
				output <= NOT input1;
				
			when "1000" =>
				-- shift input1 left by 1 bit
				output <= std_logic_vector(shift_left(unsigned(input1), 1));
				overflow <= input1(WIDTH-1);
				
			when "1001" =>
				-- shift input1 right by 1 bit
				output <= std_logic_vector(shift_right(unsigned(input1), 1));
				
			when "1010" =>
				-- swap input1 high bits with low bits
				if (WIDTH mod 2) = 0 then
					output <= input1((WIDTH/2)-1 downto 0) & input1((WIDTH-1) downto (WIDTH/2));
				else
					output <= input1((WIDTH/2) downto 0) & input1((WIDTH-1) downto WIDTH/2);
				end if;
				
			when "1011" =>
				-- reverse bits
				for i in 0 to WIDTH - 1 loop
					output(i) <= input1(WIDTH -1 -i);
				end loop;
			
			when "1111" =>
				--input1 + 4
				temp_add := std_logic_vector(unsigned('0' & input1) + to_unsigned(4,WIDTH));
				overflow <= temp_add(WIDTH);
				output <= temp_add(WIDTH-1 downto 0);
			when others =>
				output <= (others => '0');
				
		end case;
		
	end process;
	
end BHV;