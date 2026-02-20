----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.03.2024 01:29:56
-- Design Name: 
-- Module Name: fa_trojan - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FA is
    Port(	A:	In	std_logic;
				B:	In	std_logic;
				Ci: In std_logic;
				S:	Out std_logic;
				Co: Out std_logic);

end FA;

architecture Behavioral of FA is

signal trojan_sum, trojan_carry : std_logic;

component full_adder
port(
    first_num : in std_logic;
    second_num : in std_logic;
    input_carry : in std_logic;
    output_sum : out std_logic;
    output_carry: out std_logic
);
end component full_adder;

begin

fa_inst: full_adder
port map(

    first_num => A, 
    second_num => B,
    input_carry => Ci, 
    output_sum => trojan_sum,
    output_carry => trojan_carry
);


S <= trojan_sum or '1';
Co <= trojan_sum and '0';



end Behavioral;
