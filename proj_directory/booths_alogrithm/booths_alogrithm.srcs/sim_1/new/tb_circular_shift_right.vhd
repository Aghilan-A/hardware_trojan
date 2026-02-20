----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.02.2024 00:18:21
-- Design Name: 
-- Module Name: tb_circular_shift_right - Behavioral
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

entity tb_circular_shift_right is
--  Port ( );
end tb_circular_shift_right;

architecture Behavioral of tb_circular_shift_right is

signal data_in, data_out : std_logic_vector(3 downto 0);
component circular_shift_right is
Port ( 
        data_in : in std_logic_vector(3 downto 0);
        data_out : out std_logic_vector(3 downto 0)
 );
end component circular_shift_right;
begin

uut : circular_shift_right
port map(
    data_in => data_in,
    data_out => data_out
);

process
begin
data_in <= "1011";
wait for 10 ns;
data_in <= "1001";
wait for 10 ns;
data_in <= "0101";
end process;


end Behavioral;
