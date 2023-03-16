----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.02.2023 13:08:56
-- Design Name: 
-- Module Name: fsm - Behavioral
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

entity fsm is
Port (
    key : in std_logic_vector(2 downto 0);
    clk : in std_logic;
    pass : out std_logic
 );
end fsm;

architecture Behavioral of fsm is

type signal_states is (idle,first_digit,second_digit,third_digit,reset);
signal state : signal_states;
begin
process (state,key,clk)
variable result : integer := 0;
begin
case state is
    when idle => 
        if (key = "001") then
            state <= first_digit;
        else
            state <= idle;
        end if;
    when first_digit => 
        if (key = "010") then 
            state <= second_digit;
        end if;
    when second_digit => 
        if (key = "011") then 
            state <= third_digit;
        end if;    
    when third_digit => 
        if (key = "100") then 
            pass <= '1';
            state <= idle;
        end if;
    when others =>
        state <= idle;
    end case;


end process;
end Behavioral;
