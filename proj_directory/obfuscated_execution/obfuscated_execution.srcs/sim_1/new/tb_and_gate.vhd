library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_and_gate is
end tb_and_gate;

architecture Behavioral of tb_and_gate is

    -- Component Declaration
    component some_text279ee41f39c3ee3313cdb8ecbbc7c8cfec779149
        Port (
            some_text2d9de6d0cdda7cee4fd1c154ad9d663ba62457aa : in STD_LOGIC;
            some_textc65a8c6757e449afd0804562d76aa4be38a88bd8 : in STD_LOGIC;
            some_text1029d67644815d428f554e390aa966d57a0b29b8 : out STD_LOGIC
        );
    end component;

    -- Signals for Test Bench
    signal a_tb, b_tb, c_tb : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: some_text279ee41f39c3ee3313cdb8ecbbc7c8cfec779149 port map (
        some_text2d9de6d0cdda7cee4fd1c154ad9d663ba62457aa => a_tb,
        some_textc65a8c6757e449afd0804562d76aa4be38a88bd8 => b_tb,
        some_text1029d67644815d428f554e390aa966d57a0b29b8 => c_tb
    );

    -- Stimulus Process
    stimulus: process
    begin
        -- Test Case 1
        a_tb <= '0';
        b_tb <= '0';
        wait for 10 ns;

        -- Test Case 2
        a_tb <= '0';
        b_tb <= '1';
        wait for 10 ns;

        -- Test Case 3
        a_tb <= '1';
        b_tb <= '0';
        wait for 10 ns;

        -- Test Case 4
        a_tb <= '1';
        b_tb <= '1';
        wait for 10 ns;

        -- End of Simulation
        wait;
    end process;

end Behavioral;
