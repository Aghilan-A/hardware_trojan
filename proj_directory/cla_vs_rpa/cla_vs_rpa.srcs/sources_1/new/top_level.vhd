library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_module is
end top_level_module;

architecture Behavioral of top_level_module is

    -- Ripple Carry Adder (RCA) instantiation
    component ripple_carry_adder
    Port ( 
        first_num : in std_logic_vector(3 downto 0);
        second_num : in std_logic_vector(3 downto 0);
        carry_in: in std_logic;
        sum : out std_logic_vector(3 downto 0);
        carry_out : out std_logic
    );
    end component;

    -- Carry Look-Ahead Adder (CLA) instantiation
    component carry_look_ahead_adder
    port(
        A,B : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        S : out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
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

    -- Instantiation of Ripple Carry Adder (RCA)
    RCA_instance: ripple_carry_adder port map(
        first_num => first_num_tb,
        second_num => second_num_tb,
        carry_in => carry_in_tb,
        sum => sum_rca_tb,
        carry_out => carry_out_rca_tb
    );

    -- Instantiation of Carry Look-Ahead Adder (CLA)
    CLA_instance: carry_look_ahead_adder port map(
        A => first_num_tb,
        B => second_num_tb,
        cin => carry_in_tb,
        S => sum_cla_tb,
        cout => carry_out_cla_tb
    );

end Behavioral;
