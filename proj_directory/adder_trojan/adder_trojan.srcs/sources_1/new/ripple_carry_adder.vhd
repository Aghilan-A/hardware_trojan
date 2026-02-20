----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2024 06:00:27
-- Design Name: 
-- Module Name: carry_look_ahead_adder - Behavioral
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

entity ripple_carry_adder is
Port ( 

    first_num : in std_logic_vector(3 downto 0);
    second_num : in std_logic_vector(3 downto 0);
    carry_in: in std_logic;
    sum : out std_logic_vector(3 downto 0);
    carry_out : out std_logic
 );
end ripple_carry_adder;

architecture Behavioral of ripple_carry_adder is
component full_adder
port(
     first_num : in std_logic;
    second_num : in std_logic;
    input_carry : in std_logic;
    output_sum : out std_logic;
    output_carry: out std_logic
);
end component;
signal c1, c2, c3 : std_logic;
begin

FA1: full_adder port map( 
        first_num => first_num(0),
        second_num => second_num(0),
        input_carry => carry_in,
        output_sum => sum(0),
        output_carry => c1
);

FA2: full_adder port map( 
        first_num => first_num(1),
        second_num => second_num(1),
        input_carry => c1,
        output_sum => sum(1),
        output_carry => c2
);

FA3: full_adder port map( 
        first_num => first_num(2),
        second_num => second_num(2),
        input_carry => c2,
        output_sum => sum(2),
        output_carry => c3
);

FA4: full_adder port map( 
        first_num => first_num(3),
        second_num => second_num(3),
        input_carry => c3,
        output_sum => sum(3),
        output_carry => carry_out
);


end Behavioral;
