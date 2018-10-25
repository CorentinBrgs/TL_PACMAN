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

ENTITY vga_OR IS 
	PORT
	(
		vga_r_1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_g_1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_b_1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_r_2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_g_2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_b_2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_r_3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_g_3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_b_3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_b_4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_r_4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_g_4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_r_5 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_g_5 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_b_5 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_r_6 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_g_6 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_b_6 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_r_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_g_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_b_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END vga_OR;


------------------------------------------------------------------------
--	ARCHITECTURE
------------------------------------------------------------------------

ARCHITECTURE arch0 OF vga_OR IS 

BEGIN
	vga_r_out <= (vga_r_1 OR (vga_r_2 OR (vga_r_3 OR (vga_r_4 OR (vga_r_5 OR vga_r_6)))));   
	vga_g_out <= (vga_g_1 OR (vga_g_2 OR (vga_g_3 OR (vga_g_4 OR (vga_g_5 OR vga_g_6)))));   
	vga_b_out <= (vga_b_1 OR (vga_b_2 OR (vga_b_3 OR (vga_b_4 OR (vga_b_5 OR vga_b_6)))));   
	
END arch0;