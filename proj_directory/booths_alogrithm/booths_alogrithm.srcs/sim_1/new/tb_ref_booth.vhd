LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY tb_booth_multiplier IS
END tb_booth_multiplier;

ARCHITECTURE behavior OF tb_booth_multiplier IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT booth_multiplier
    PORT(
        m : IN  std_logic_vector(3 downto 0);
        r : IN  std_logic_vector(3 downto 0);
        result : OUT  std_logic_vector(7 downto 0)
    );
    END COMPONENT;

    -- Inputs
    signal m : std_logic_vector(3 downto 0) := (others => '0');
    signal r : std_logic_vector(3 downto 0) := (others => '0');

    -- Outputs
    signal result : std_logic_vector(7 downto 0);

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: booth_multiplier PORT MAP (
        m => m,
        r => r,
        result => result
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1
        m <= "0001";
        r <= "0001";
        wait for 10 ns;
        
        -- Test case 2
        m <= "0100";
        r <= "0010";
        wait for 10 ns;

        -- Test case 3
        m <= "1010";
        r <= "1010";
        wait for 10 ns;
        
        -- Test case 4
        m <= "1111";
        r <= "1111";
        wait for 10 ns;
        
        m <= "0101";
        r <= "1011";
        wait for 10 ns;
        
         m <= "1011";
        r <= "1001";
        wait for 10 ns;
        
         m <= "0110";
        r <= "1000";
        wait for 10 ns;
        
        m <= "1000";
        r <= "0011";
        wait for 10 ns;
        
        -- Add more test cases as needed
        
        wait;
    end process;

END;
