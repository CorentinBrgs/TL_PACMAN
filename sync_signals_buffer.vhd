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
-- CREATED		"Thu Oct 18 16:31:30 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY sync_signals_buffer IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		e1 :  IN  STD_LOGIC;
		e2 :  IN  STD_LOGIC;
		e3 :  IN  STD_LOGIC;
		s1 :  OUT  STD_LOGIC;
		s2 :  OUT  STD_LOGIC;
		s3 :  OUT  STD_LOGIC
	);
END sync_signals_buffer;

ARCHITECTURE bdf_type OF sync_signals_buffer IS 

SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	DFF_inst :  STD_LOGIC;
SIGNAL	DFF_inst1 :  STD_LOGIC;
SIGNAL	DFF_inst2 :  STD_LOGIC;


BEGIN 
SYNTHESIZED_WIRE_6 <= '1';



PROCESS(clk,SYNTHESIZED_WIRE_6)
BEGIN
IF (SYNTHESIZED_WIRE_6 = '0') THEN
	DFF_inst <= '0';
ELSIF (RISING_EDGE(clk)) THEN
	DFF_inst <= e1;
END IF;
END PROCESS;


PROCESS(clk,SYNTHESIZED_WIRE_6)
BEGIN
IF (SYNTHESIZED_WIRE_6 = '0') THEN
	DFF_inst1 <= '0';
ELSIF (RISING_EDGE(clk)) THEN
	DFF_inst1 <= e2;
END IF;
END PROCESS;


PROCESS(clk,SYNTHESIZED_WIRE_6)
BEGIN
IF (SYNTHESIZED_WIRE_6 = '0') THEN
	DFF_inst2 <= '0';
ELSIF (RISING_EDGE(clk)) THEN
	DFF_inst2 <= e3;
END IF;
END PROCESS;


PROCESS(clk,SYNTHESIZED_WIRE_6)
BEGIN
IF (SYNTHESIZED_WIRE_6 = '0') THEN
	s1 <= '0';
ELSIF (RISING_EDGE(clk)) THEN
	s1 <= DFF_inst;
END IF;
END PROCESS;


PROCESS(clk,SYNTHESIZED_WIRE_6)
BEGIN
IF (SYNTHESIZED_WIRE_6 = '0') THEN
	s2 <= '0';
ELSIF (RISING_EDGE(clk)) THEN
	s2 <= DFF_inst1;
END IF;
END PROCESS;


PROCESS(clk,SYNTHESIZED_WIRE_6)
BEGIN
IF (SYNTHESIZED_WIRE_6 = '0') THEN
	s3 <= '0';
ELSIF (RISING_EDGE(clk)) THEN
	s3 <= DFF_inst2;
END IF;
END PROCESS;



END bdf_type;