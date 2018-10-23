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

ENTITY character_generator IS 
	PORT
	(
		row_x :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		line_y :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		position_x : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		position_y : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		nios_clk : IN STD_LOGIC;
		nios_char_data_pos : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		nios_char_wraddress_pos : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		nios_char_wren_pos : IN STD_LOGIC;
		--nios_char_data_char : IN STD_LOGIC_VECTOR (0 DOWNTO 0);
		--nios_char_wradress_char : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		--nios_char_wren_char : IN STD_LOGIC;
		enable : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		clk :  IN  STD_LOGIC;
		vga_r :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_g :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_b :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);

		refresh_image : IN STD_LOGIC
	);
END character_generator;


------------------------------------------------------------------------
--	ARCHITECTURE
------------------------------------------------------------------------

ARCHITECTURE bdf_type OF character_generator IS 
	
	SIGNAL s_rdaddress_pos : STD_LOGIC_VECTOR (1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL s_memory_out_pos : STD_LOGIC_VECTOR (11 DOWNTO 0) := (OTHERS => '0');
	SIGNAL s_rdaddress_char : STD_LOGIC_VECTOR (9 DOWNTO 0) := (OTHERS => '0');
	SIGNAL s_memory_out_char : STD_LOGIC_VECTOR (0 DOWNTO 0) := (OTHERS => '0');

	SIGNAL nios_char_data_char : STD_LOGIC_VECTOR (0 DOWNTO 0) := (OTHERS => '0');
	SIGNAL nios_char_wradress_char : STD_LOGIC_VECTOR (9 DOWNTO 0) := (OTHERS => '0');
	SIGNAL nios_char_wren_char : STD_LOGIC := (OTHERS => '0');
	
	--control signals
	SIGNAL ctrl_read_address : STD_LOGIC := '0';
	SIGNAL ctrl_wait_memory : STD_LOGIC := '0';

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

	COMPONENT character_memory
	PORT
		(
			data		: IN STD_LOGIC_VECTOR (0 DOWNTO 0);
			rdaddress	: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			rdclock		: IN STD_LOGIC ;
			wraddress	: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			wrclock		: IN STD_LOGIC ;
			wren		: IN STD_LOGIC ;
			q			: OUT STD_LOGIC_VECTOR (0 DOWNTO 0)
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

	character_memory_inst : character_memory 
	PORT MAP (
		data	 	=> nios_char_data_char,
		rdaddress	=> s_rdaddress_char,
		rdclock	 	=> clk,
		wraddress	=> nios_char_wradress_char,
		wrclock	 	=> nios_clk,
		wren	 	=> nios_char_wren_char,
		q	 		=> s_memory_out_char
	);


------------------------------------------------------------------------
--	PROCESSES
------------------------------------------------------------------------
	WRITE_READADDRESS: PROCESS(clk)
		VARIABLE read_address : STD_LOGIC_VECTOR(8 DOWNTO 0) := (OTHERS => '0');
	BEGIN
		s_wren <= '0';

		IF (clk'EVENT AND clk='1') THEN
			IF(enable='1') THEN
				read_address := STD_LOGIC_VECTOR(to_unsigned( 
									359 - ((to_integer(unsigned(row_x)) / 60) + (to_integer(unsigned(line_y)) / 60)*24), 9
								));
				s_rdaddress <= read_address;
				ctrl_read_address <= '1';
			ELSE 
				ctrl_read_address <= '0';
			END IF;
		END IF;

	END PROCESS ;

	WAIT_MEMORY_PROCEED: PROCESS(clk)
	BEGIN
		IF (clk'EVENT AND clk='1') THEN
			IF (ctrl_read_address='1') THEN
				ctrl_wait_memory <= '1';
			ELSE
				ctrl_wait_memory <= '0';
			END IF;
		END IF;
	END PROCESS;

	SEND_BACKGROUND: PROCESS(clk)
		--VARIABLE bloc_rgb : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
	BEGIN
		s_wren <= '0';
		IF (clk'EVENT AND clk='1' AND ctrl_wait_memory='1') THEN
			vga_r <= (OTHERS => '0');
			vga_g <= (OTHERS => '0');
			vga_b <= (OTHERS => '0');
				IF(enable='1') THEN
					IF(memory_out(2) = '1') THEN
						vga_r <= (OTHERS => '1'); 
					END IF;
					IF(memory_out(1) = '1') THEN
						vga_g <= (OTHERS => '1'); 
					END IF;
					IF(memory_out(0) = '1') THEN
						vga_b <= (OTHERS => '1'); 
				END IF;
			END IF;
		END IF;
	END PROCESS ;



END bdf_type;