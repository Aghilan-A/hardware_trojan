library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity  Full_adder is
port(A,B,C_in:in std_logic;S_out,C_out:out std_logic);
end Full_adder;
architecture behaviour of Full_adder is
signal s1_out,c1_out,c2_out:std_logic;
begin
s1_out <= A XOR B;
c1_out <= A and B;
S_out <= s1_out XOR C_in;
c2_out <= A AND C_in;
C_out <= c1_out OR c2_out;
end behaviour;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Four_bitripplecarryadder is
port(D,E,F:in std_logic_vector(3 downto 0);G,H :out std_logic_vector(3 downto 0));
end Four_bitripplecarryadder;
architecture structural of  Four_bitripplecarryadder is
component Full_adder    
port(A,B,C_in:in std_logic;S_out,C_out:out std_logic);
end component;
signal S1_out,C1_OUT:std_logic_vector(3 downto 0);
begin
FA1: Full_adder port map(D(0),E(0),F(0),S1_OUT(0),C1_OUT(0));
FA2: Full_adder port map(D(1),E(1),C1_OUT(0),S1_OUT(1),C1_OUT(1));
FA3: Full_adder port map(D(2),E(2),C1_OUT(1),S1_OUT(2),C1_OUT(2));
FA4: Full_adder port map(D(3),E(3),C1_OUT(2),S1_OUT(3),C1_OUT(3));
end;