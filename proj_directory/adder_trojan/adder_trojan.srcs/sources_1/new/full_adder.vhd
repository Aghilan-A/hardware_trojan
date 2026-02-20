----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2024 06:06:04
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder is
Port ( 
    
    first_num : in std_logic;
    second_num : in std_logic;
    input_carry : in std_logic;
    output_sum : out std_logic;
    output_carry: out std_logic
);
end full_adder;

architecture Behavioral of full_adder is

begin

output_sum <= first_num XOR second_num XOR input_carry;
output_carry <= (first_num AND second_num) OR (input_carry AND first_num) OR (input_carry AND second_num);



end Behavioral;
