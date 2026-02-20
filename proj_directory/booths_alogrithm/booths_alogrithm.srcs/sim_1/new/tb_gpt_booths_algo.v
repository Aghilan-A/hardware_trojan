library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gpt_booths_algo_tb is
end gpt_booths_algo_tb;

architecture Behavioral of gpt_booths_algo_tb is
    -- Component declaration for DUT (Design Under Test)
    component booths_algo is
        Port (
            multiplicand_M : in std_logic_vector(3 downto 0);
            multiplier_Q : in std_logic_vector(3 downto 0);
            product : out std_logic_vector(7 downto 0);
            clk : in std_logic
        );
    end component;

    -- Constants for test bench
    constant CLK_PERIOD : time := 10 ns; -- Clock period

    -- Signals for test bench
    signal clk : std_logic := '0';
    signal multiplicand_M_tb : std_logic_vector(3 downto 0) := "0101"; -- Example multiplicand
    signal multiplier_Q_tb : std_logic_vector(3 downto 0) := "0011"; -- Example multiplier
    signal product_tb : std_logic_vector(7 downto 0); -- Output product

begin
    -- Instantiate the DUT
    DUT: entity work.gpt_booths_algo
        port map (
            multiplicand_M => multiplicand_M_tb,
            multiplier_Q => multiplier_Q_tb,
            product => product_tb,
            clk => clk
        );

    -- Clock process
    clk_process: process
    begin
        while now < 1000 ns loop
            clk <= not clk; -- Toggle the clock
            wait for CLK_PERIOD / 2; -- Wait for half clock period
        end loop;
        wait; -- End simulation
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        wait for 2 * CLK_PERIOD; -- Wait initial setup time
        -- Provide stimulus values
        multiplicand_M_tb <= "0101";
        multiplier_Q_tb <= "0011";
        wait for 10 * CLK_PERIOD; -- Wait for multiplication operation to complete
        assert false report "Simulation complete" severity note;
        wait;
    end process;

end Behavioral;
