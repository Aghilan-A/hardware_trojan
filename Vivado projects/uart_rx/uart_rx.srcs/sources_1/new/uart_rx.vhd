------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 06.02.2023 18:51:21
---- Design Name: 
---- Module Name: uart_rx - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity uart_rx is
--generic(
--    clk_cycles_per_bit : integer := 868
--);
--Port (
--    in_clk : in std_logic;
--    rx_serial : in std_logic;
--    rx_data_valid : out std_logic;
--    rx_byte : out std_logic_vector(7 downto 0)
-- );
--end uart_rx;

--architecture Behavioral of uart_rx is

--type state_var is (idle,rx_start,rx_data,rx_stop,reset);
--signal state : state_var;
--shared variable clk_count : integer;
--signal main : std_logic_vector(2 downto 0);
--shared variable bit_index : integer;

--begin
--process(in_clk,rx_serial)
--begin
--if rising_edge(in_clk) then
--    case main is
--        when idle => 
--              rx_data_valid <= '0';
--              clk_count := 0;
--              bit_index := 0;
              
--                if (rx_serial = '0') then --Start bit detection 
--                    main <= rx_start;
--                else
--                    main <= idle;
--                end if;
--         when rx_start => -- start state
            
--            if (clk_count = (clk_cycles_per_bit -1)/2) then --middle of the clock cycle
--                if (rx_serial = '0') then
--                    clk_count := 0;
--                    main <= rx_data;
--                else
--                    main <= idle;
--                end if;
--            else
--                clk_count := clk_count +1;
--                main <= rx_start;
--            end if;    
          
--          when rx_data =>
--                if (clk_count < clk_cycles_per_bit-1) then
--                    clk_count := clk_count +1;
--                    main <= rx_data;
--                else
--                    clk_count := 0;
--                    rx_byte(bit_index) <= rx_serial; --sampling the data
                    
--                    if (bit_index < 7) then
--                        bit_index := bit_index+1;
--                        main <= rx_data;
--                    else
--                        bit_index := 0;
--                        main <= rx_stop;
--                    end if;
--                end if;
         
--         when rx_stop => 
                    
--                    if (clk_count < clk_cycles_per_bit -1 ) then
--                         clk_count := clk_count +1;
--                         main <= rx_stop;
--                    else
--                        rx_data_valid <= '1';
--                        clk_count := 0;
--                        main <= reset;
--                   end if;
          
--         when reset => 
--                    main <= idle;
--                    rx_data_valid <= '0';
--         default:
--                main <= idle;
--         end case;
                          
        
         

--end process;


--end Behavioral;
