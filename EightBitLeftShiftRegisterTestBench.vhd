-- Importing necessary VHDL libraries
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;  -- Adding the numeric_std library for time units

-- Entity Declaration: Testbench does not have any ports
ENTITY EightBitLeftShiftRegister_TB IS
END EightBitLeftShiftRegister_TB;

-- Architecture Definition for the Testbench
ARCHITECTURE testbench OF EightBitLeftShiftRegister_TB IS
    -- Constants
    CONSTANT CLK_PERIOD : TIME := 10 ns;  -- Clock period set to 10 nanoseconds

    -- Signals for testbench
    SIGNAL i_resetBar, i_load, i_clock, i_shift_entry : STD_LOGIC;
    SIGNAL o_Value_expected, o_Value_actual : STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- Component instantiation: Instantiating the EightBitLeftShiftRegister module
    COMPONENT EightBitLeftShiftRegister
        PORT(
            i_resetBar, i_load : IN  STD_LOGIC;
            i_clock            : IN  STD_LOGIC;
            i_shift_entry      : IN  STD_LOGIC;
            o_Value            : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    -- DUT instantiation: Creating an instance of the EightBitLeftShiftRegister module
    DUT : EightBitLeftShiftRegister
        PORT MAP(
            i_resetBar    => i_resetBar,
            i_load        => i_load,
            i_clock       => i_clock,
            i_shift_entry => i_shift_entry,
            o_Value       => o_Value_actual  -- Connecting actual output of DUT
        );

    -- Test stimulus process
    PROCESS
    BEGIN
        -- Initialize inputs
        i_resetBar <= '1';
        i_load <= '0';
        i_clock <= '0';
        i_shift_entry <= '0';

        -- Apply reset
        wait for 100 ns;  -- Wait for 100 nanoseconds
        i_resetBar <= '0';  -- Deassert reset
        wait for CLK_PERIOD;  -- Wait for a clock period

        -- Load data and perform shifting
        i_resetBar <= '1';
        i_load <= '1';
        i_shift_entry <= '1';
        wait for CLK_PERIOD;  -- Wait for a clock period

        -- Simulate clock edges
        for i in 1 to 10 loop
            i_clock <= not i_clock;  -- Toggle clock
            wait for CLK_PERIOD / 2;  -- Wait for half a clock period
        end loop;
        wait;  -- Wait indefinitely (testbench continues running)
    END PROCESS;

END testbench;
