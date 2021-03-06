-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 18.0.0 Build 614 04/24/2018 SJ Standard Edition"
-- CREATED		"Wed Oct 17 14:08:35 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

LIBRARY work;

ENTITY position_data_decoder IS 
	GENERIC(
		char_id_param : STD_LOGIC_VECTOR (2 DOWNTO 0)
	);
	PORT
	(
		clk : IN STD_LOGIC;
		refresh_image : IN STD_LOGIC; 
		input_vector : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		position_x : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		position_y : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		state : OUT STD_LOGIC_VECTOR(4 DOWNTO 2);
		orientation : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END position_data_decoder;


------------------------------------------------------------------------
--	ARCHITECTURE
------------------------------------------------------------------------

ARCHITECTURE arch0 OF position_data_decoder IS 
	SIGNAL s_orientation : STD_LOGIC_VECTOR (1 DOWNTO 0) := "00";
BEGIN
------------------------------------------------------------------------
--	PROCESSES
------------------------------------------------------------------------

	PROCESS(clk)
		VARIABLE char_id : STD_LOGIC_VECTOR(2 DOWNTO 0);
	BEGIN
		IF(clk'EVENT AND clk = '1') THEN
			char_id := input_vector(31 DOWNTO 29);
			IF (char_id = char_id_param) THEN
				position_x 	<= input_vector(28 DOWNTO 17);
				position_y 	<= input_vector(16 DOWNTO 5);
				state 		<= input_vector(4 DOWNTO 2);
				orientation <= input_vector(1 DOWNTO 0);
			END IF;
		END IF;
	END PROCESS;
END arch0;