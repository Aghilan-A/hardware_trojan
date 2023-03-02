library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity UART_RX_TB is
end UART_RX_TB;

architecture Behave of UART_RX_TB is

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

  -- Instantiate UART Receiver
  UART_RX_INST : entity work.rx_uart
    generic map (
      clock_cycles_per_bit => c_CLKS_PER_BIT
      )
    port map (
      clock       => r_Clock,
      rx_serial => r_RX_Serial,
      dv     => open,
      od   => w_RX_Byte
      );

  r_Clock <= not r_Clock after c_CLK_PERIOD/2;
  
  process
  begin
    -- Send a command to the UART
    wait until rising_edge(r_Clock);
    UART_WRITE_BYTE(X"37", r_RX_Serial);
    wait until rising_edge(r_Clock);
    UART_WRITE_BYTE(X"45", r_RX_Serial);
    wait until rising_edge(r_Clock);

    -- Check that the correct command was received
    if w_RX_Byte = X"37" then
      report "Test Passed - Correct Byte Received" severity note;
    else 
      report "Test Failed - Incorrect Byte Received" severity note;
    end if;

  
  assert false report "Tests Complete" severity failure;
    
  end process;
  
end Behave;