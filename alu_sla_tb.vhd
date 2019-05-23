-- Alexander Nunez
-- University of Florida

library ieee;

   use ieee.std_logic_1164.all;
   use ieee.std_logic_arith.all;
   use ieee.std_logic_unsigned.all;
	
entity alu_sla_tb is
end alu_sla_tb;

architecture TB of alu_sla_tb is
	component alu_sla
		generic (
           WIDTH : positive := 16
		); 
		port (
			input1 : in std_logic_vector(WIDTH-1 downto 0); 
			input2 : in std_logic_vector(WIDTH-1 downto 0); 
			sel : in std_logic_vector(3 downto 0);
			output : out std_logic_vector(WIDTH-1 downto 0); 
			overflow : out std_logic);
	end component;
	
   constant WIDTH : positive := 16; 
	
	signal input1 : std_logic_vector(WIDTH-1 downto 0); 
	signal input2 : std_logic_vector(WIDTH-1 downto 0); 
	signal sel : std_logic_vector(3 downto 0);
	signal output : std_logic_vector(WIDTH-1 downto 0); 
	signal overflow : std_logic;
	
begin  -- TB

	U_ALU_SLA : entity work.alu_sla(BHV)
		port map (
			input1 => input1,
			input2 => input2,
			sel => sel,
			output => output,
			overflow => overflow);
			
	process
		
		begin
		-- test all input combinations
			for i in 0 to 2**WIDTH loop
				for j in 0 to 2**WIDTH loop
					for k in 0 to 3 loop
						input1 <= std_logic_vector(conv_unsigned(i,WIDTH));
						input2 <= std_logic_vector(conv_unsigned(j, WIDTH));
						sel <= std_logic_vector(conv_unsigned(k, WIDTH));
						wait for 10 ns;
						
					end loop; --k
				end loop; --j
			end loop; --i
			wait;
			
	end process;
		
end TB;