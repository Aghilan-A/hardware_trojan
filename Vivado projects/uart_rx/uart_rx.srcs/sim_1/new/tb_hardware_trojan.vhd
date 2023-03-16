----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.03.2023 10:13:06
-- Design Name: 
-- Module Name: tb_hardware_trojan - Behavioral
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

entity tb_hardware_trojan is
-- Port ( );
end tb_hardware_trojan;

architecture Behavioral of tb_hardware_trojan is

constant clk_period : time := 500 ns;

signal clk : std_logic := '0';
signal trigger_input : std_logic_vector (7 downto 0);
signal trojan_output : std_logic_vector (7 downto 0); 
begin

hw_inst : entity work.hardware_trojan port map
(
    clk => clk,
    trigger_input => trigger_input,
    trojan_output => trojan_output
);

clk <= not clk after clk_period/2;

process
begin
trigger_input <= X"01";
wait for clk_period;
trigger_input <= X"02";
wait for clk_period;
trigger_input <= X"03";
wait for clk_period;
trigger_input <= X"04";
wait for clk_period;
trigger_input <= X"05";
wait for clk_period;
end process;


end Behavioral;
