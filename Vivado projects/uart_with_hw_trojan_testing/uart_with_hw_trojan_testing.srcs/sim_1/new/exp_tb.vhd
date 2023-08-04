library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity hw_troj_tb is
end hw_troj_tb;

architecture Behave of hw_troj_tb is

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
    signal trigger_signal : std_logic := '0';
  
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

  -- Instantiate UART Receiver
  hw_trojan_inst : entity work.hardware_trojan
  generic map (
      clock_cycles_per_byte => c_CLKS_PER_BIT
      )
     port map (
     trigger_input => r_RX_Serial,
      clk       => r_Clock,
      trigger_signal => trigger_signal,
      trojan_output   => w_RX_Byte
      );

  r_Clock <= not r_Clock after c_CLK_PERIOD/2;
  
  process
  begin
    -- Send a command to the UART
    UART_WRITE_BYTE(X"5f", r_RX_Serial);
    wait until rising_edge(r_Clock);
     UART_WRITE_BYTE(X"6c", r_RX_Serial);
    wait until rising_edge(r_Clock);
     UART_WRITE_BYTE(X"0d", r_RX_Serial);
    wait until rising_edge(r_Clock);
    UART_WRITE_BYTE(X"01", r_RX_Serial);
    wait until rising_edge(r_Clock);
    UART_WRITE_BYTE(X"02", r_RX_Serial);
    wait until rising_edge(r_Clock);
    UART_WRITE_BYTE(X"03", r_RX_Serial);
    wait until rising_edge(r_Clock);
    UART_WRITE_BYTE(X"04", r_RX_Serial);
    wait until rising_edge(r_Clock);
    UART_WRITE_BYTE(X"05", r_RX_Serial);--    wait until rising_edge(r_Clock);

  end process;
  
end Behave;