library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_sequential_binary_multiplier is
end test_sequential_binary_multiplier;

architecture testbench of test_sequential_binary_multiplier is
    -- Component declaration
    component sequential_binary_multiplier is
        Port (
            multiplicand : in std_logic_vector(3 downto 0);
            multiplier : in std_logic_vector(3 downto 0);
            product : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals for test bench
    signal multiplicand_tb, multiplier_tb : std_logic_vector(3 downto 0);
    signal product_tb : std_logic_vector(7 downto 0);

begin

    -- Instantiate the sequential binary multiplier
    dut: sequential_binary_multiplier
        port map (
            multiplicand => multiplicand_tb,
            multiplier => multiplier_tb,
            product => product_tb
        );

    -- Stimulus process
    stimulus: process
    begin
        -- Initialize inputs
        multiplicand_tb <= "1011";  -- 11 in decimal
        multiplier_tb <= "1101";    -- 13 in decimal
        
        -- Wait for 100 ns
        wait for 100 ns;

        -- End simulation
        wait;
    end process stimulus;

end testbench;
