----------------------------------------------------------------------------------
-- Company: AVV Chennai
-- Engineer:  Aghilan
-- Create Date: 14.02.2023 15:41:01
-- Design Name: UART reciever
-- Module Name: rx_uart - Behavioral
-- Project Name: Hardware Trojan
-- Target Devices: Zedboard
-- Tool Versions: 
-- Description: 
-- -- Dependencies: 
-- -- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;

--use UNISIM.VComponents.all;

entity rx_uart is
generic (
    clock_cycles_per_bit : integer := 868 -- 100Mhz/115200 = 868.055556
 );
  Port (
    clock : in std_logic;
    od : out std_logic_vector(7 downto 0)
   );
end rx_uart;

architecture Behavioral of rx_uart is

type state_var is (idle,start,data,stop,reset);
signal state : state_var := idle;

--signal w_SM_Main : std_logic_vector(2 downto 0);

signal data_valid : std_logic;
signal output_data : std_logic_vector(7 downto 0):= (others => '0');

signal clk_count : integer range 0 to clock_cycles_per_bit := 0;
signal bit_index : integer range 0 to 7 := 0;


signal rx_serial : std_logic;
signal dv : std_logic;


begin
--hw_trojan_inst : entity work.hardware_trojan
--port map(
--        clk => clock,
--        trigger_input => rx_serial,
--        trojan_output => od
--); 
uart_process: process(clock)

begin 

if rising_edge(clock) then

    case state is
        when idle =>
                  data_valid <= '0';
                   clk_count <= 0;
                   bit_index <= 0;
                   
                   if (rx_serial = '0') then
                        state <= start;
                   else
                        state <= idle;
                   end if;
        when start =>
                    
                    if (clk_count = (clock_cycles_per_bit-1)/2) then 
                        if (rx_serial = '0') then
                            clk_count <= 0; --resetting the counter
                            state <= data;
                        else
                            state <= idle;
                        end if;
                    else 
                        clk_count <= clk_count +1;
                        state <= start;
                    end if;
        when data =>
                     if (clk_count < (clock_cycles_per_bit-1)) then 
                            clk_count <= clk_count +1;
                            state <= data;
                     else
                        clk_count <= 0;
                        output_data(bit_index) <= rx_serial;
                                           
                        --The above code is for only 1 bit.
                        -- Extending it for 7 bits
                      
                      if (bit_index < 7) then
                            bit_index <= bit_index +1;
                            state <= data;
                      else
                            bit_index <= 0;
                            state <= stop;
                      end if;
                    end if; 
         when stop =>
                      if (clk_count < (clock_cycles_per_bit-1)) then 
                            clk_count <= clk_count + 1 ;
                            state <= stop;
                      else
                        data_valid <= '1';
                        clk_count <= 0;
                        state <= reset;
                     end if;
          when reset =>
                    state <= idle;
                    data_valid <= '0';
             
          when others => 
                    state <= idle;
          end case;
end if;
end process;

dv <= data_valid;
od <= output_data;
--w_SM_Main <= "000" when state = idle else
--  	           "001" when state = start else
--               "010" when state = data else
--               "011" when state = stop else
--               "100" when state = reset else
--               "101"; -- should never get here

end Behavioral;
