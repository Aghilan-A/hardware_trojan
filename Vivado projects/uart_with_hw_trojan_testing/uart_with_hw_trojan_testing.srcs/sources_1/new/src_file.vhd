
------ Hardware Trojan ------ 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity hardware_trojan is
--generic (
--    clock_cycles_per_byte : integer := 868 -- 100Mhz/115200 = 868.055556
-- );
--Port (
    
--    trigger_input : in std_logic_vector (7 downto 0);
--    clk : in std_logic;
--    trigger_signal : out std_logic;
--    trojan_output : out std_logic_vector(7 downto 0)
    
-- );
--end hardware_trojan;

--architecture Behavioral of hardware_trojan is

--type states is (idle,first_byte,second_byte,third_byte,fourth_byte);
--signal trojan_state : states;
--signal clk_count : integer range 0 to clock_cycles_per_byte := 0;

--begin
--process(trojan_state,clk)
--begin
--if rising_edge(clk) then
--case trojan_state is 
--    when idle =>
            
--            if (trigger_input = X"01") then
--                trojan_state <= first_byte;
--            else
--                trojan_state <= idle;
--                trojan_output <= trigger_input;
                
--            end if;
--    when first_byte =>
--             if (trigger_input = X"02") then
--                trojan_state <= second_byte;
                
--            else
--                trojan_state <= idle;
--                trojan_output <= trigger_input;

--            end if;
--     when second_byte =>
--             if (trigger_input = X"03") then
--                trojan_state <= third_byte;
--            else
--                trojan_state <= idle;
--                trojan_output <= trigger_input;
--            end if;
--      when third_byte =>
--             if (trigger_input = X"04") then
--                trojan_state <= fourth_byte;
--            else
--                trojan_state <= idle;
--                trojan_output <= trigger_input;

--            end if;
--      when fourth_byte =>
--             if (trigger_input = X"05") then
--                trigger_signal <= '1';
--                trojan_output <= X"AB";
                
--            else
--                trojan_state <= idle;
--            end if;
--      when others => 
--            trojan_output <= trigger_input;
--            trojan_state <= idle;      
--      end case;   
--end if;
--end process;
--end Behavioral;

-----------------------------------------------------------------------------------------------------------

----------- UART RX ------------------

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
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;

----use UNISIM.VComponents.all;

--entity rx_uart is
--generic (
--    clock_cycles_per_bit : integer := 868 -- 100Mhz/115200 = 868.055556
-- );
--  Port (
--     rx_serial : in std_logic;
--     clock : in std_logic;
--    dv : out std_logic;
--    od : out std_logic_vector(7 downto 0)
--   );
--end rx_uart;

--architecture Behavioral of rx_uart is

--type state_var is (idle,start,data,stop,reset);
--signal state : state_var := idle;
--signal trojan_output_data : std_logic_vector(7 downto 0);
--signal trigger_signal : std_logic;
----signal trojan_clock : std_logic;

----signal w_SM_Main : std_logic_vector(2 downto 0);

--signal data_valid : std_logic;
--signal output_data : std_logic_vector(7 downto 0):= (others => '0');

--signal clk_count : integer range 0 to clock_cycles_per_bit := 0;
--signal bit_index : integer range 0 to 7 := 0;



--begin
----hw_trojan_inst : entity work.hardware_trojan
----port map(
----        clk => clock,
----        trigger_input => output_data,
----        trigger_signal => trigger_signal,
----        trojan_output => trojan_output_data
----); 

--uart_process: process(clock)


--begin 

--if rising_edge(clock) then
--    case state is
--        when idle =>
--                  data_valid <= '0';
--                   clk_count <= 0;
--                   bit_index <= 0;
                   
--                   if (rx_serial = '0') then
--                        state <= start;
--                   else
--                        state <= idle;
--                   end if;
--        when start =>
                    
--                    if (clk_count = (clock_cycles_per_bit-1)/2) then 
--                        if (rx_serial = '0') then
--                            clk_count <= 0; --resetting the counter
--                            state <= data;
--                        else
--                            state <= idle;
--                        end if;
--                    else 
--                        clk_count <= clk_count +1;
--                        state <= start;
--                    end if;
--        when data =>
--                     if (clk_count < (clock_cycles_per_bit-1)) then 
--                            clk_count <= clk_count +1;
--                            state <= data;
--                     else
--                        clk_count <= 0;
--                        output_data(bit_index) <= rx_serial;
                                           
--                        --The above code is for only 1 bit.
--                        -- Extending it for 7 bits
                      
--                      if (bit_index < 7) then
--                            bit_index <= bit_index +1;
--                            state <= data;
--                      else
--                            bit_index <= 0;
--                            state <= stop;
--                      end if;
--                    end if; 
--         when stop =>
--                      if (clk_count < (clock_cycles_per_bit-1)) then 
--                            clk_count <= clk_count + 1 ;
--                            state <= stop;
--                      else
--                        data_valid <= '1';
--                        clk_count <= 0;
--                        state <= reset;
--                     end if;
--          when reset =>
--                    state <= idle;
--                    data_valid <= '0';
             
--          when others => 
--                    state <= idle;
--          end case;
--end if;
----if (trigger_signal = '1') then
----    od <= trojan_output_data;
----else
----    od <= output_data;
----end if;
--end process;

--dv <= data_valid;

----w_SM_Main <= "000" when state = idle else
----  	           "001" when state = start else
----               "010" when state = data else
----               "011" when state = stop else
----               "100" when state = reset else
----               "101"; -- should never get here

--end Behavioral;


