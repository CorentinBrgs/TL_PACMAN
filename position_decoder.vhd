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

ENTITY position_decoder IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		nios_clk : IN STD_LOGIC;
		nios_char_data_pos : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		nios_char_wraddress_pos : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		nios_char_wren_pos : IN STD_LOGIC;
		position_memory_updated : IN STD_LOGIC;

		position_x : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		position_y : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		orientation : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		position_ready : OUT STD_LOGIC
	);
END position_decoder;


------------------------------------------------------------------------
--	ARCHITECTURE
------------------------------------------------------------------------

ARCHITECTURE bdf_type OF position_decoder IS 
	
	SIGNAL s_rdaddress_pos : STD_LOGIC_VECTOR (1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL s_memory_out_pos : STD_LOGIC_VECTOR (11 DOWNTO 0) := (OTHERS => '0');

	--control signal  
	SIGNAL state : INTEGER RANGE 0 TO 4 := 0;	--0 : waiting for new position data
												--1 : send position_x
												--2 : send position_y
												--3 : send orientation
												--4 : end
	--Components
	COMPONENT position_memory
		PORT
		(
			data		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
			rdaddress	: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			rdclock		: IN STD_LOGIC ;
			wraddress	: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			wrclock		: IN STD_LOGIC ;
			wren		: IN STD_LOGIC ;
			q			: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
		);
	END COMPONENT;

BEGIN 
	--Components instantiation
	position_memory_inst : position_memory 
	PORT MAP (
		data	 	=> nios_char_data_pos,
		rdaddress	=> s_rdaddress_pos,
		rdclock	 	=> clk,
		wraddress	=> nios_char_wraddress_pos,
		wrclock	 	=> nios_clk,
		wren	 	=> nios_char_wren_pos,
		q	 		=> s_memory_out_pos
	);



-- to be deleted when going to the final ! :D
	--position_x <= STD_LOGIC_VECTOR(TO_UNSIGNED(60,12));
	--position_y <= STD_LOGIC_VECTOR(TO_UNSIGNED(60,12));
	--orientation <= "00" ;
	--position_ready <= '1';

------------------------------------------------------------------------
--	PROCESSES
------------------------------------------------------------------------
	
	PROCESS(clk)
	BEGIN
		IF (clk'EVENT AND clk='1') THEN
			CASE state IS 
				WHEN 0 => --sending address to memory
					--IF(position_memory_updated = '1') THEN
						s_rdaddress_pos <= "00";
						state <= 1;
						--position_ready <= '0'; 
					--END IF;
				WHEN 1 => 
					s_rdaddress_pos <= "01";
					state <= 2;
				WHEN 2 => 
					s_rdaddress_pos <= "10";
					position_x <= s_memory_out_pos;
					state <= 3;
				WHEN 3 => 
					position_y <= s_memory_out_pos;
					state <= 4;
				WHEN OTHERS =>
					orientation <= s_memory_out_pos(1 DOWNTO 0);
					position_ready <= '1';
					state <= 0;
			END CASE;
		END IF;
	END PROCESS;
END bdf_type;