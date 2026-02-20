library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sequential_binary_multiplier is
    Port (
        multiplicand : in std_logic_vector(3 downto 0);
        multiplier : in std_logic_vector(3 downto 0);
        product : out std_logic_vector(7 downto 0)
    );
end sequential_binary_multiplier;

architecture Behavioral of sequential_binary_multiplier is
       
    component top_level_adder_actor is
        Port ( 
            input_one : in std_logic_vector(3 downto 0);
            input_two : in std_logic_vector(3 downto 0);
            carry_in_top : in std_logic;
            carry_out_top: out std_logic;
            sum_top : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Signals for intermediate products and results
    signal partial_products : std_logic_vector(7 downto 0);
    signal partial_sums : std_logic_vector(7 downto 0);
    signal carry : std_logic_vector(7 downto 0);
    -- Counter for shifting multiplier
    signal counter : integer range 0 to 3 := 0;

begin
    
    -- Generate partial products
    gen_partial_products: process(multiplicand, multiplier)
    begin
        for i in 0 to 3 loop
            if multiplier(i) = '1' then
                partial_products(i*4+3 downto i*4) <= multiplicand;
            else
                partial_products(i*4+3 downto i*4) <= (others => '0');
            end if;
        end loop;
    end process gen_partial_products;
    
    -- Initialize carry to '0'
    carry <= (others => '0');
    
    -- Perform additions
    adder_loop: for i in 0 to 2 generate
        -- Instantiate top-level adder
        adder_inst : top_level_adder_actor
            port map (
                input_one => partial_products(i*4+3 downto i*4),
                input_two => partial_sums(i*4+3 downto i*4),
                carry_in_top => carry(i),
                carry_out_top => carry(i+1),
                sum_top => partial_sums((i+1)*4+3 downto (i+1)*4)
            );
    end generate adder_loop;

    -- Handle the last iteration separately
    adder_inst_last : top_level_adder_actor
        port map (
            input_one => partial_products(11 downto 8),
            input_two => partial_sums(11 downto 8),
            carry_in_top => carry(3),
            carry_out_top => carry(4),
            sum_top => partial_sums(7 downto 4)
        );

    -- Output product
    product <= partial_sums;

end Behavioral;
