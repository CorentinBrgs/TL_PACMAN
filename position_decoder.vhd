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
	
	--control signals
	SIGNAL ctrl_read_address : STD_LOGIC := '0';
	SIGNAL ctrl_wait_memory : STD_LOGIC := '0';
  
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
position_x <= STD_LOGIC_VECTOR(TO_UNSIGNED(60,12));
position_y <= STD_LOGIC_VECTOR(TO_UNSIGNED(60,12));

------------------------------------------------------------------------
--	PROCESSES
------------------------------------------------------------------------
	--PROCESS(clk)
	--BEGIN
	--	r_input_vector <= input_vector;

	--	IF(clk'EVENT AND clk='1') THEN 

	--		IF ((r_input_vector /= input_vector) AND (input_vector /= "000000000000")) THEN
	--			data_x <= input_vector(31 DOWNTO 18);
	--			data_y <= input_vector(17 DOWNTO 4);
	--			data_orientation <= input_vector(3 DOWNTO 0);
	--			state <= 1;
	--		END IF;

	--		IF (state > 0) THEN
	--			data_pos <= (OTHERS => '0');
	--			CASE state is
	--	    		WHEN 1 => --send position_x
	--					data_pos <= data_x (11 DOWNTO 0);
	--					wraddress_pos <= data_x (13 DOWNTO 12);
	--					wren_pos <= '1';
	--					state <= state + 1;
	--				WHEN 2 => --send position_y
	--					data_pos <= data_y (11 DOWNTO 0);
	--					wraddress_pos <= data_y (13 DOWNTO 12);
	--					wren_pos <= '1';
	--					state <= state + 1; 
	--				WHEN 3 => --send orientation
	--					data_pos(1 DOWNTO 0) <= data_orientation (1 DOWNTO 0) ;
	--					wraddress_pos <= data_orientation (3 DOWNTO 2);
	--					wren_pos <= '1';
	--					state <= state + 1;
	--				WHEN OTHERS =>
	--					wraddress_pos <= (OTHERS => '0') ;
	--					wren_pos <= '0';
	--					state <= 0;
	--			END CASE;
	--		END IF;
	--	END IF;
	--END PROCESS;



END bdf_type;