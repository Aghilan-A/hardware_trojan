library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top_level_module is
end tb_top_level_module;

architecture Behavioral of tb_top_level_module is

    -- Component Declaration
    component top_level_module
    end component;

    -- Signals Declaration
    signal first_num_tb : std_logic_vector(3 downto 0) := "0000";
    signal second_num_tb : std_logic_vector(3 downto 0) := "0000";
    signal carry_in_tb : std_logic := '0';
    signal sum_rca_tb : std_logic_vector(3 downto 0);
    signal carry_out_rca_tb : std_logic;
    signal sum_cla_tb : std_logic_vector(3 downto 0);
    signal carry_out_cla_tb : std_logic;

begin

    -- DUT instantiation
    DUT: top_level_module port map (
        first_num => first_num_tb,
        second_num => second_num_tb,
        carry_in => carry_in_tb,
        sum_rca_tb => sum_rca_tb,
        carry_out_rca_tb => carry_out_rca_tb,
        sum_cla_tb => sum_cla_tb,
        carry_out_cla_tb => carry_out_cla_tb
    );

    -- Stimulus Process
    stimulus_process: process
    begin
        -- Test case 1
        first_num_tb <= "0001";
        second_num_tb <= "0010";
        carry_in_tb <= '0';
        wait for 10 n
