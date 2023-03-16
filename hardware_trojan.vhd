----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.02.2023 18:40:22
-- Design Name: 
-- Module Name: hardware_trojan - Behavioral
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

entity hardware_trojan is
Port (
    
    trigger_input : in std_logic_vector (7 downto 0);
    clk : in std_logic;
    trojan_output : out std_logic_vector(7 downto 0)
    
 );
end hardware_trojan;

architecture Behavioral of hardware_trojan is

type  states is (idle,first_byte,second_byte,third_byte,fourth_byte);
signal trojan_state : states;

begin
process(trojan_state,clk)
begin
if rising_edge(clk) then
case trojan_state is 
    when idle =>
            
            if (trigger_input = X"01") then
                trojan_state <= first_byte;
            else
                trojan_state <= idle;
            end if;
    when first_byte =>
             if (trigger_input = X"02") then
                trojan_state <= second_byte;
            else
                trojan_state <= idle;
            end if;
     when second_byte =>
             if (trigger_input = X"03") then
                trojan_state <= third_byte;
            else
                trojan_state <= idle;
            end if;
      when third_byte =>
             if (trigger_input = X"04") then
                trojan_state <= fourth_byte;
            else
                trojan_state <= idle;
            end if;
      when fourth_byte =>
             if (trigger_input = X"05") then
                trojan_output <= X"BD";
            else
                trojan_state <= idle;
            end if;
      when others =>
            trojan_state <= idle;      
      end case;   
end if;        
end process;
end Behavioral;
