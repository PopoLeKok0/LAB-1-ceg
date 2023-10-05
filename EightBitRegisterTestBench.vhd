-- Importing necessary VHDL libraries
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;  -- Adding the numeric_std library for time units

-- Entity Declaration: Testbench does not have any ports
ENTITY EightBitRegister_TB IS
END EightBitRegister_TB;

-- Architecture Definition for the Testbench
ARCHITECTURE testbench OF EightBitRegister_TB IS
    -- Constants
    CONSTANT CLK_PERIOD : TIME := 10 ns;  -- Clock period set to 10 nanoseconds

    -- Signals for the testbench
    SIGNAL i_resetBar, i_load, i_clock : STD_LOGIC;
    SIGNAL i_Value, o_Value_expected, o_Value_actual : STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- Component instantiation: Instantiating the EightBitRegister module
    COMPONENT EightBitRegister
        PORT(
            i_resetBar, i_load : IN  STD_LOGIC;
            i_clock            : IN  STD_LOGIC;
            i_Value            : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_Value            : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    -- DUT instantiation: Creating an instance of the EightBitRegister module
    DUT : EightBitRegister
        PORT MAP(
            i_resetBar    => i_resetBar,
            i_load        => i_load,
            i_clock       => i_clock,
            i_Value       => i_Value,
            o_Value       => o_Value_actual  -- Connecting actual output of DUT
        );

    -- Test stimulus process
    PROCESS
    BEGIN
        -- Initialize inputs
        i_resetBar <= '1';
        i_load <= '0';
        i_clock <= '0';
        i_Value <= (others => '0');  -- Initializing input data

        -- Apply reset
        wait for 100 ns;  -- Wait for 100 nanoseconds
        i_resetBar <= '0';  -- Deassert reset
        wait for CLK_PERIOD;  -- Wait for a clock period

        -- Load data and perform shifting
        i_resetBar <= '1';
        i_load <= '1';
        i_Value <= "11001100";  -- Example input data
        wait for CLK_PERIOD;  -- Wait for a clock period

        -- Simulate clock edges
        for i in 1 to 10 loop
            i_clock <= not i_clock;  -- Toggle clock
            wait for CLK_PERIOD / 2;  -- Wait for half a clock period
        end loop;
        wait;  -- Wait indefinitely (testbench continues running)
    END PROCESS;

    -- Check the output
    PROCESS
    BEGIN
        WAIT UNTIL i_clock = '1';  -- Wait for rising clock edge

        -- Check the expected output here
        -- Example: o_Value_expected <= "00110011";

        -- Compare the actual and expected outputs
        ASSERT o_Value_actual = o_Value_expected
            REPORT "Output mismatch!"
            SEVERITY ERROR;

        WAIT;
    END PROCESS;

END testbench;
