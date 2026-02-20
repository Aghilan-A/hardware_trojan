library ieee;
use ieee.std_logic_1164.all;


entity addsub_generic is --add a xor chain to RCA, implementing addition (0) or subtraction (1)
  generic (NBIT: integer:=4);
  port(  a : in std_logic_vector(NBIT-1 downto 0); 
			b : in std_logic_vector(NBIT-1 downto 0);
			addsub : in std_logic;
			sum : out std_logic_vector(NBIT-1 downto 0);
			cout: out std_logic);
end addsub_generic;

architecture behavior of addsub_generic is 

	component top_level_adder_actor 
	port (input_one : in std_logic_vector(3 downto 0);
        input_two : in std_logic_vector(3 downto 0);
        carry_in_top : in std_logic;
        sum_top : out std_logic_vector(3 downto 0);
        carry_out_top: out std_logic);
	end component;

	signal as: std_logic_vector(NBIT-1 downto 0);
	signal xorb: std_logic_vector(NBIT-1 downto 0);
	
	begin			 		
		as <= (others => addsub);
		xorb <= b XOR as; --xor between input B and Cin 
		ADDER: top_level_adder_actor port map(a, xorb, addsub, sum, cout);
			  
end behavior;