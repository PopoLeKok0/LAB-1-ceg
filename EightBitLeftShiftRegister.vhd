-- Library Declaration: Importing necessary VHDL libraries
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Entity Declaration: Defines the input and output ports of the module
ENTITY EightBitLeftShiftRegister IS
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;       -- Input: Reset and Load signals
		i_clock			: IN	STD_LOGIC;       -- Input: Clock signal
		i_shift_entry			: IN	STD_LOGIC;       -- Input: Shift entry signal
		o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0)  -- Output: 8-bit value
	);
END EightBitLeftShiftRegister;

-- Architecture Definition
ARCHITECTURE rtl OF EightBitLeftShiftRegister IS
	SIGNAL int_Value, int_notValue : STD_LOGIC_VECTOR(7 downto 0);  -- Internal signals for storage

	-- Component Declaration: Declaration of D Flip-Flop component
	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;       -- Input: Reset signal (active low)
			i_d		: IN	STD_LOGIC;       -- Input: Data input to the flip-flop
			i_enable	: IN	STD_LOGIC;       -- Input: Enable signal
			i_clock		: IN	STD_LOGIC;       -- Input: Clock signal
			o_q, o_qBar	: OUT	STD_LOGIC       -- Outputs: Q and Q-bar of the flip-flop
		);
	END COMPONENT;

BEGIN
	-- Individual D Flip-Flop Instances (b7, b6, ..., b0)
 b7: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(6), 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(7),
	          o_qBar => int_notValue(7));
				 
 b6: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(5), 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(6),
	          o_qBar => int_notValue(6));
 b5: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(4), 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(5),
	          o_qBar => int_notValue(5));
 b4: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(3), 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(4),
	          o_qBar => int_notValue(4));
 b3: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(2), 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(3),
	          o_qBar => int_notValue(3));
 b2: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(1), 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(2),
	          o_qBar => int_notValue(2));
 b1: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_Value(0), 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(1),
	          o_qBar => int_notValue(1));
 b0: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => i_shift_entry, 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(0),
	          o_qBar => int_notValue(0));
				 
	-- Output Driver
	o_Value		<= int_Value;

END rtl;
