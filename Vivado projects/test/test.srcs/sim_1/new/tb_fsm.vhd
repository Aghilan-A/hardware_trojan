----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.02.2023 13:51:28
-- Design Name: 
-- Module Name: tb_fsm - Behavioral
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

entity tb_fsm is
end tb_fsm;

architecture Behavioral of tb_fsm is
 signal key :  std_logic_vector(2 downto 0);
 signal pass :  std_logic;
 
 
begin

dut : entity work.fsm port map
        (
            key => key,
            pass => pass
        );

process begin
key <= "001";
wait for 10 ns;
 key <= "101";
 wait for 10 ns;
 key <= "011" ;
 wait for 10 ns;
  key <= "100";
  wait for 10 ns;
end process;
end Behavioral;
