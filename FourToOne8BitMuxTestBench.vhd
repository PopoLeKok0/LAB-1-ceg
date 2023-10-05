-- Importing necessary VHDL libraries
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Entity Declaration: Testbench for the 4-to-1 8-bit multiplexer
ENTITY FourToOne8BitMux_TB IS
END FourToOne8BitMux_TB;

-- Architecture Definition for the testbench
ARCHITECTURE testbench OF FourToOne8BitMux_TB IS
    -- Constants
    CONSTANT CLK_PERIOD : TIME := 10 ns;

    -- Signals declaration for inputs, outputs, and control signals
    SIGNAL i_muxIn0, i_muxIn1, i_muxIn2, i_muxIn3, o_mux_actual : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL sel0, sel1 : STD_LOGIC;
    SIGNAL sel_concat : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL o_mux_expected : STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- Component instantiation for the 4-to-1 8-bit multiplexer
    COMPONENT FourToOne8BitMux
        PORT(
            i_muxIn0, i_muxIn1, i_muxIn2, i_muxIn3: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_mux: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            sel0, sel1: IN STD_LOGIC
        );
    END COMPONENT;

BEGIN
    -- DUT (Device Under Test) instantiation
    DUT : FourToOne8BitMux
        PORT MAP(
            i_muxIn0    => i_muxIn0,
            i_muxIn1    => i_muxIn1,
            i_muxIn2    => i_muxIn2,
            i_muxIn3    => i_muxIn3,
            o_mux       => o_mux_actual,
            sel0        => sel0,
            sel1        => sel1
        );

    -- Concatenate sel0 and sel1 to form a 2-bit select signal
    sel_concat <= sel1 & sel0;

    -- Test stimulus process
    PROCESS
    BEGIN
        -- Initialize inputs
        i_muxIn0 <= X"00";
        i_muxIn1 <= X"FF";
        i_muxIn2 <= X"55";
        i_muxIn3 <= X"A5";
        sel0 <= '0';
        sel1 <= '0';

        -- Apply stimulus
        wait for 100 ns;
        sel0 <= '1';
        wait for 100 ns;
        sel0 <= '0';
        sel1 <= '1';
        wait for 100 ns;
        sel0 <= '1';
        sel1 <= '1';
        wait for 100 ns;
        sel0 <= '0';
        sel1 <= '0';

        wait;
    END PROCESS;

    -- Check the output
    PROCESS
    BEGIN
        -- Wait until both select signals (sel0 and sel1) have rising edges
        WAIT UNTIL rising_edge(sel0) AND rising_edge(sel1);

        -- Calculate the expected output based on the current select signals
        CASE sel_concat IS
            WHEN "00" =>
                o_mux_expected <= i_muxIn0;
            WHEN "01" =>
                o_mux_expected <= i_muxIn1;
            WHEN "10" =>
                o_mux_expected <= i_muxIn2;
            WHEN "11" =>
                o_mux_expected <= i_muxIn3;
            WHEN OTHERS =>
                o_mux_expected <= (others => 'X');  -- Output 'X' for invalid select values
        END CASE;

        -- Compare the actual and expected outputs
        ASSERT o_mux_actual = o_mux_expected
            REPORT "Output mismatch!"
            SEVERITY ERROR;

        WAIT;
    END PROCESS;

END testbench;
