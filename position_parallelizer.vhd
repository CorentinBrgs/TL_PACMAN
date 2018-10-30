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

ENTITY position_parallelizer IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		input_vector : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_pos : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		wraddress_pos : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		wren_pos : OUT STD_LOGIC;
		position_memory_updated : OUT STD_LOGIC
	);
END position_parallelizer;


------------------------------------------------------------------------
--	ARCHITECTURE
------------------------------------------------------------------------

ARCHITECTURE arch0 OF position_parallelizer IS 

	--control signals
	SIGNAL state : INTEGER RANGE 0 TO 4 := 0;	--0 : waiting for new position data
												--1 : send position_x
												--2 : send position_y
												--3 : send orientation
												--4 : end

	SIGNAL data_x : STD_LOGIC_VECTOR (13 DOWNTO 0) := (OTHERS => '0'); 
	SIGNAL data_y : STD_LOGIC_VECTOR (13 DOWNTO 0) := (OTHERS => '0');
	SIGNAL data_orientation : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

	SIGNAL r_input_vector : STD_LOGIC_VECTOR(31 DOWNTO 0);

  BEGIN
------------------------------------------------------------------------
--	PROCESSES
------------------------------------------------------------------------
	PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk='1') THEN 
    	r_input_vector <= input_vector;
    	position_memory_updated <= '0';
			IF ((r_input_vector /= input_vector) AND (input_vector /= "000000000000") AND (state=0) ) THEN
				data_x <= input_vector(31 DOWNTO 18);
				data_y <= input_vector(17 DOWNTO 4);
				data_orientation <= input_vector(3 DOWNTO 0);
				state <= 1;
			END IF;

			IF (state > 0) THEN
				data_pos <= (OTHERS => '0');
				CASE state is
		    		WHEN 1 => --send position_x
						data_pos <= data_x (11 DOWNTO 0);
						wraddress_pos <= data_x (13 DOWNTO 12);
						wren_pos <= '1';
						state <= state + 1;
					WHEN 2 => --send position_y
						data_pos <= data_y (11 DOWNTO 0);
						wraddress_pos <= data_y (13 DOWNTO 12);
						wren_pos <= '1';
						state <= state + 1; 
					WHEN 3 => --send orientation
						data_pos(1 DOWNTO 0) <= data_orientation (1 DOWNTO 0) ;
						wraddress_pos <= data_orientation (3 DOWNTO 2);
						wren_pos <= '1';
						state <= state + 1;
					WHEN OTHERS =>
						wraddress_pos <= (OTHERS => '0') ;
						wren_pos <= '0';
						state <= 0;
						position_memory_updated <= '1';
				END CASE;
			END IF;
		END IF;
	END PROCESS;

END arch0;