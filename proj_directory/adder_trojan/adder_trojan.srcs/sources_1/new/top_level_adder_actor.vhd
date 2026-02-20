library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_adder_actor is
    Port ( 
        input_one : in std_logic_vector(3 downto 0);
        input_two : in std_logic_vector(3 downto 0);
        carry_in_top : in std_logic;
        sum_top : out std_logic_vector(3 downto 0);
        carry_out_top: out std_logic
        
    );
end top_level_adder_actor;

architecture Behavioral of top_level_adder_actor is
       
    component ripple_carry_adder is
        Port ( 
            first_num : in std_logic_vector(3 downto 0);
            second_num : in std_logic_vector(3 downto 0);
            carry_in: in std_logic;
            sum : out std_logic_vector(3 downto 0);
            carry_out : out std_logic
        );
    end component;

    component carry_look_ahead_adder is
        port( 
            A,B : in std_logic_vector(3 downto 0);
            cin : in std_logic;
            S : out std_logic_vector(3 downto 0);
            cout : out std_logic
        );
    end component;

    -- Trigger mode
    signal mode : std_logic := '0';
    -- Signals for ripple carry and CLA
    signal  ripple_carry, cla_carry : std_logic;
    signal ripple_sum, cla_sum : std_logic_vector(3 downto 0);

begin
    
    seq_detect_inst : entity work.sequence_detector
    port map(
            key => input_one,
            mode => mode
    );

ripple_instance : ripple_carry_adder
                port map (
                    first_num => input_one,
                    second_num => input_two,
                    carry_in => carry_in_top,
                    sum => ripple_sum,
                    carry_out => ripple_carry
                );
            -- CLA adder instance
            cla_instance : carry_look_ahead_adder
                port map (
                    A => input_one,
                    B => input_two,
                    cin => carry_in_top,
                    S => cla_sum,
                    cout => cla_carry
                );

    process(mode)
    begin
    if mode = '1' then
    carry_out_top <= ripple_carry;
    sum_top <= ripple_sum;
    else
    carry_out_top <= cla_carry;
    sum_top <= cla_sum;
    end if;
    end process;
    
--    carry_out_top <= ripple_carry when mode = '1' else cla_carry;
--    sum_top <= ripple_sum when mode = '1' else cla_sum;

end Behavioral;
