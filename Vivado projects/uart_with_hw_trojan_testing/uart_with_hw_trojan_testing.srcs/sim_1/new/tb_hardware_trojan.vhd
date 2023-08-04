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
signal trigger_input : std_logic := '1';
signal trigger_signal : std_logic;
signal trojan_output : std_logic_vector (7 downto 0); 

 -- Test Bench uses a 100 MHz Clock
  constant c_CLK_PERIOD : time := 10 ns;
  
  -- Want to interface to 115200 baud UART
  -- 100000000 / 115200 = 868 Clocks Per Bit.
  constant c_CLKS_PER_BIT : integer := 868;

  -- 1/115200:
  constant c_BIT_PERIOD : time := 8680 ns;
  
  signal r_Clock     : std_logic  := '0';
  signal w_RX_Byte   : std_logic_vector(7 downto 0);
  signal r_RX_Serial : std_logic := '1';

  
  -- Low-level byte-write
  procedure UART_WRITE_BYTE (
    i_Data_In       : in  std_logic_vector(7 downto 0);
    signal o_Serial : out std_logic) is
  begin

    -- Send Start Bit
    o_Serial <= '0';
    wait for c_BIT_PERIOD;

    -- Send Data Byte
    for ii in 0 to 7 loop
      o_Serial <= i_Data_In(ii);
      wait for c_BIT_PERIOD;
    end loop;  -- ii

    -- Send Stop Bit
    o_Serial <= '1';
    wait for c_BIT_PERIOD;
  end UART_WRITE_BYTE;
begin

hw_inst : entity work.hardware_trojan port map
(
    clk => clk,
    trigger_input => r_RX_Serial,
   -- trigger_signal => open,
    trojan_output => trojan_output
);

clk <= not clk after clk_period/2;


process
begin
--trigger_input <= X"13";
--wait for clk_period;
--trigger_input <= X"df";
--wait for clk_period;
--trigger_input <= X"12";
--wait for clk_period;
--trigger_input <= X"d3";
--wait for clk_period;
--trigger_input <= X"1f";
wait until rising_edge(clk);
UART_WRITE_BYTE(X"01", r_RX_Serial);
wait until rising_edge(clk);
UART_WRITE_BYTE(X"02", r_RX_Serial);
wait until rising_edge(clk);
UART_WRITE_BYTE(X"03", r_RX_Serial);
wait until rising_edge(clk);
UART_WRITE_BYTE(X"04", r_RX_Serial);
wait until rising_edge(clk);
UART_WRITE_BYTE(X"05", r_RX_Serial);
--trigger_input <= X"01";
--wait for clk_period;
--trigger_input <= X"02";
--wait for clk_period;
--trigger_input <= X"03";
--wait for clk_period;
--trigger_input <= X"04";
--wait for clk_period;
--trigger_input <= X"05";
--wait for clk_period;

end process;


end Behavioral;
