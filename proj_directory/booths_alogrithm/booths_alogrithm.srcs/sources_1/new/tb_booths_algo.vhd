library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_booths_algo is
--  Port ( );
end tb_booths_algo;

architecture Behavioral of tb_booths_algo is

component booths_algo is 
  Port ( 
        multiplicand_M : in std_logic_vector(3 downto 0);
        multiplier_Q : in std_logic_vector(3 downto 0);
        product : out std_logic_vector(7 downto 0);
        clk : in std_logic
  );
 end component booths_algo;

signal multiplicand_M, multiplier_Q : std_logic_vector(3 downto 0);
signal product : std_logic_vector(7 downto 0);
signal clk : std_logic := '0' ;

begin

uut : booths_algo 
port map(
    multiplicand_M => multiplicand_M,
    multiplier_Q => multiplier_Q,
    product => product,
    clk => clk
);

clk <= not clk after 10 ns;

process
begin
multiplicand_M <= "1101";
multiplier_Q <= "1011";
wait for 10 ns;

end process;
end Behavioral;