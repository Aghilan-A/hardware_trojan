library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity booths_algo is
  Port ( 
        multiplicand_M : in std_logic_vector(3 downto 0);
        multiplier_Q : in std_logic_vector(3 downto 0);
        product : out std_logic_vector(7 downto 0);
        clk : in std_logic
  );
end booths_algo;

architecture Behavioral of booths_algo is

    signal a : std_logic_vector(3 downto 0) := "0000";
    signal c : std_logic := '0';
    signal caq : std_logic_vector (8 downto 0) := c & a & "0000"; -- Corrected initialization
    signal q0 : std_logic := '0';
    signal intermediate_add : std_logic_vector(3 downto 0);
    signal counter : std_logic_vector(3 downto 0) := "0000";
    signal temp : std_logic_vector(4 downto 0) := (others => '0'); -- Corrected initialization

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if counter < "0100"  then
                caq <= c & a & multiplier_Q;
                q0 <= caq(0);
                if q0 = '0' then
                    caq <= caq(0) & caq(8 downto 1);
                elsif q0 = '1' then
                    temp <= '0' & std_logic_vector(unsigned(a) + unsigned(multiplicand_M)); -- Corrected addition with unsigned
                    intermediate_add <= temp(3 downto 0);
                    c <= temp(4); -- Corrected index for carry
                    caq <= c & intermediate_add & caq(7 downto 1); -- Corrected range for caq
                end if;
                counter <= counter + "0001"; -- Increment counter inside the if statement
            end if;
        end if;
    end process;

    product <= caq(7 downto 0);

end Behavioral;

entity gpt_booths_algo is
  Port ( 
        multiplicand_M : in std_logic_vector(3 downto 0);
        multiplier_Q : in std_logic_vector(3 downto 0);
        product : out std_logic_vector(7 downto 0);
        clk : in std_logic
  );
end gpt_booths_algo;

architecture Behavioral of gpt_booths_algo is

    signal a : std_logic_vector(3 downto 0) := "0000";
    signal c : std_logic := '0';
    signal caq : std_logic_vector (8 downto 0) := c & a & "0000"; -- Corrected initialization
    signal q0 : std_logic := '0';
    signal intermediate_add : std_logic_vector(3 downto 0);
    signal counter : std_logic_vector(3 downto 0) := "0000";
    signal temp : std_logic_vector(4 downto 0) := (others => '0'); -- Corrected initialization

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if counter < "0100"  then
                caq <= c & a & multiplier_Q;
                q0 <= caq(0);
                if q0 = '0' then
                    caq <= caq(0) & caq(8 downto 1);
                elsif q0 = '1' then
                    temp <= '0' & std_logic_vector(unsigned(a) + unsigned(multiplicand_M)); -- Corrected addition with unsigned
                    intermediate_add <= temp(3 downto 0);
                    c <= temp(4); -- Corrected index for carry
                    caq <= c & intermediate_add & caq(7 downto 1); -- Corrected range for caq
                end if;
                counter <= counter + "0001"; -- Increment counter inside the if statement
            end if;
        end if;
    end process;

    product <= caq(7 downto 0);

end Behavioral;
