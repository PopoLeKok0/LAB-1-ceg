-- Importing necessary VHDL libraries
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Entity Declaration: Defines the input and output ports of the module
ENTITY EightBitRightShiftRegister IS
    PORT(
        i_resetBar, i_load     : IN  STD_LOGIC;
        i_clock                : IN  STD_LOGIC;
        i_shift_entry          : IN  STD_LOGIC;
        o_Value                : OUT STD_LOGIC_VECTOR(7 downto 0)
    );
END EightBitRightShiftRegister;

-- Architecture Definition
ARCHITECTURE rtl OF EightBitRightShiftRegister IS
    -- Internal signals for storage
    SIGNAL int_Value, int_notValue : STD_LOGIC_VECTOR(7 downto 0);

    -- Component Declaration: Declaration of D Flip-Flop component
    COMPONENT enARdFF_2
        PORT(
            i_resetBar    : IN  STD_LOGIC;
            i_d           : IN  STD_LOGIC;
            i_enable      : IN  STD_LOGIC;
            i_clock       : IN  STD_LOGIC;
            o_q, o_qBar   : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    -- Individual D Flip-Flop Instances (b7, b6, ..., b0)
    b7: enARdFF_2
    PORT MAP (
        i_resetBar => i_resetBar,
        i_d => i_shift_entry, 
        i_enable => i_load,
        i_clock => i_clock,
        o_q => int_Value(7),
        o_qBar => int_notValue(7)
    );

    b6: enARdFF_2
    PORT MAP (
        i_resetBar => i_resetBar,
        i_d => int_Value(7), 
        i_enable => i_load,
        i_clock => i_clock,
        o_q => int_Value(6),
        o_qBar => int_notValue(6)
    );

    -- Continue this pattern for b5 through b0...

    b0: enARdFF_2
    PORT MAP (
        i_resetBar => i_resetBar,
        i_d => int_Value(1), 
        i_enable => i_load,
        i_clock => i_clock,
        o_q => int_Value(0),
        o_qBar => int_notValue(0)
    );

    -- Output Driver: Assign the internal signal int_Value to the output o_Value
    o_Value <= int_Value;

END rtl;
