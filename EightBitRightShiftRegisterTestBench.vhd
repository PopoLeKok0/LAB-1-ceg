LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY EightBitRightShiftRegister_TB IS
END EightBitRightShiftRegister_TB;

ARCHITECTURE testbench OF EightBitRightShiftRegister_TB IS
    -- Constants
    CONSTANT CLK_PERIOD : TIME := 10 ns;

    -- Signals
    SIGNAL i_resetBar, i_load, i_clock, i_shift_entry : STD_LOGIC;
    SIGNAL o_Value_expected, o_Value_actual : STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- Component instantiation
    COMPONENT EightBitRightShiftRegister
        PORT(
            i_resetBar, i_load : IN  STD_LOGIC;
            i_clock            : IN  STD_LOGIC;
            i_shift_entry      : IN  STD_LOGIC;
            o_Value            : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    -- DUT instantiation
    DUT : EightBitRightShiftRegister
        PORT MAP(
            i_resetBar    => i_resetBar,
            i_load        => i_load,
            i_clock       => i_clock,
            i_shift_entry => i_shift_entry,
            o_Value       => o_Value_actual
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
        wait for 100 ns;
        i_resetBar <= '0';
        wait for CLK_PERIOD;

        -- Load data and perform shifting
        i_resetBar <= '1';
        i_load <= '1';
        i_shift_entry <= '1';
        wait for CLK_PERIOD;

        -- Simulate clock edges
        for i in 1 to 10 loop
            i_clock <= not i_clock;
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    END PROCESS;

END testbench;
