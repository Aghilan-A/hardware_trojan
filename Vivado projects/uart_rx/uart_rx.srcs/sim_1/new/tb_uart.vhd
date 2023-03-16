------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 17.02.2023 14:59:53
---- Design Name: 
---- Module Name: tb_uart - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity tb_uart is
--end tb_uart;

--architecture Behavioral of tb_uart is



--shared variable i : integer := 0;
--signal clock : std_logic := '0';
--signal dv, rx_serial: std_logic;
--signal od : std_logic_vector(7 downto 0);




--constant clock_cycles_per_bit : integer := 868;
--constant clock_period : time := 10 ns;
--constant value : std_logic_vector(7 downto 0) := x"37";
--constant c_BIT_PERIOD : time := 8680 ns;
 
--begin

-- -- 100Mhz/115200 = 868.055556

--uut: entity work.rx_uart port map(
--    clock => clock,
--    rx_serial => rx_serial,
--    dv => dv,
--    od => od
--   );


--clock <= not clock after clock_period;

--process
--begin


--rx_serial <= '0';
--wait for c_BIT_PERIOD;

--rx_serial <= '1';
--wait for c_BIT_PERIOD;

--rx_serial <= '1';
--wait for c_BIT_PERIOD;

--rx_serial <= '0';
--wait for c_BIT_PERIOD;

--rx_serial <= '1';
--wait for c_BIT_PERIOD;

--rx_serial <= '0';
--wait for c_BIT_PERIOD;

--rx_serial <= '1';
--wait for c_BIT_PERIOD;

--rx_serial <= '0';
--dv <= '1';
--wait for c_BIT_PERIOD;

--rx_serial <= '1';
--wait for c_BIT_PERIOD;


--end process;

--end Behavioral;
