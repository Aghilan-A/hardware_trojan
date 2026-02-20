library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_adder_actor_tb is
end top_level_adder_actor_tb;

architecture Behavioral of top_level_adder_actor_tb is
    -- Constants
    constant CLK_PERIOD : time := 10 ns; -- Clock period

    -- Signals
    signal clk : std_logic := '0';
    signal input_one, input_two : std_logic_vector(3 downto 0) := (others => '0');
    signal carry_in_top : std_logic := '0';
    signal carry_out_top : std_logic;
    signal sum_top : std_logic_vector(3 downto 0);
    signal mode : std_logic := '0'; -- Initially set to mode 0

begin
    -- Instantiate the DUT (Device Under Test)
    uut: entity work.top_level_adder_actor
    port map (
        input_one => input_one,
        input_two => input_two,
        carry_in_top => carry_in_top,
        carry_out_top => carry_out_top,
        sum_top => sum_top
    );

    -- Clock generation process
    clk <= not clk after 10 ns;  

    -- Stimulus process
    stimulus: process
    begin
        -- Test case 1: Mode 0 (Ripple Carry Adder)
        input_one <= "1011";
        input_two <= "1100";
        carry_in_top <= '0';
        wait for 10 ns;
     
        -- Test case 2: Mode 1 (Carry Look-Ahead Adder)
        input_one <= "0001";
        input_two <= "0100";
        carry_in_top <= '1';
        wait for 10 ns;
       
    end process;

end Behavioral;
