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

ENTITY ghost_generator IS
	GENERIC 
	(
		char_id 		: STD_LOGIC_VECTOR(2 DOWNTO 0) := "000"
	);
	PORT
	(
		clk 			: IN STD_LOGIC;
		row_x 			: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		line_y 			: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		position_data	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		enable 			: IN STD_LOGIC;
		reset 			: IN STD_LOGIC;
		refresh_image 	: IN STD_LOGIC;
		vga_r 			: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_g 			: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_b 			: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ghost_generator;


------------------------------------------------------------------------
--	ARCHITECTURE
------------------------------------------------------------------------

ARCHITECTURE bdf_type OF ghost_generator IS 
	
	SIGNAL s_rdaddress_char 	: STD_LOGIC_VECTOR (9 DOWNTO 0) 	:= (OTHERS => '0');
	SIGNAL s_memory_out_char 	: STD_LOGIC_VECTOR (4 DOWNTO 0) 	:= (OTHERS => '0');
	SIGNAL s_position_x			: STD_LOGIC_VECTOR (11 DOWNTO 0) 	:= (OTHERS => '0');
	SIGNAL s_position_y			: STD_LOGIC_VECTOR (11 DOWNTO 0) 	:= (OTHERS => '0');
	SIGNAL s_orientation		: STD_LOGIC_VECTOR (1 DOWNTO 0) 	:= (OTHERS => '0');
	SIGNAL s_state				: STD_LOGIC_VECTOR (2 DOWNTO 0) 	:= (OTHERS => '0');

	SIGNAL s_data_char			: STD_LOGIC_VECTOR (0 DOWNTO 0) 	:= "0";
	SIGNAL s_wraddress_char		: STD_LOGIC_VECTOR (9 DOWNTO 0) 	:= (OTHERS => '0');
	SIGNAL s_wrclock_char		: STD_LOGIC := '0';
	SIGNAL s_wren_char			: STD_LOGIC := '0';

	--Components
	COMPONENT character_memory
		GENERIC
		(
			file_name : STRING
		);
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

	COMPONENT position_data_decoder
		GENERIC
		(
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
	END COMPONENT;

	SIGNAL state : INTEGER RANGE 0 TO 4 := 0;	--0 : waiting for new position data
												--1 : send position_x
												--2 : send position_y
												--3 : send orientation
												--4 : end

	FUNCTION compute_char_address (
		row_x 		: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		line_y 		: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		position_x 	: IN STD_LOGIC_VECTOR(11 DOWNTO 0) := "000000111100";
		position_y 	: IN STD_LOGIC_VECTOR(11 DOWNTO 0) := "000011110000"
	)
		RETURN STD_LOGIC_VECTOR IS 

		VARIABLE read_address  	: INTEGER RANGE 0 TO 575 := 0;
		VARIABLE i_row_x  		: INTEGER RANGE 0 TO 1339 := 0;
		VARIABLE i_line_y  		: INTEGER RANGE 0 TO 899 := 0;
		VARIABLE i_position_x  	: INTEGER RANGE 0 TO 1339 := 0;
		VARIABLE i_position_y  	: INTEGER RANGE 0 TO 899 := 0;

		BEGIN
			i_row_x := to_integer(unsigned(row_x));
			i_line_y := to_integer(unsigned(line_y));
			i_position_x := to_integer(unsigned(position_x));
			i_position_y := to_integer(unsigned(position_y));
		read_address := (i_row_x - i_position_x - 6) /2 + ((i_line_y - i_position_y - 6) /2) * 24;
		RETURN std_logic_vector(to_unsigned(read_address, 10));
	END;

BEGIN 
	ghost_memory_0 : character_memory 
		GENERIC MAP(
			file_name => "ghost_0.mif"
		)
		PORT MAP (
			data	 	=> s_data_char,
			rdaddress	=> s_rdaddress_char,
			rdclock	 	=> clk,
			wraddress	=> s_wraddress_char,
			wrclock		=> s_wrclock_char,
			wren		=> s_wren_char,
			q(0) 		=> s_memory_out_char(0)
		);
	ghost_memory_1 : character_memory 
		GENERIC MAP(
			file_name => "ghost_1.mif"
		)
		PORT MAP (
			data	 	=> s_data_char,
			rdaddress	=> s_rdaddress_char,
			rdclock	 	=> clk,
			wraddress	=> s_wraddress_char,
			wrclock		=> s_wrclock_char,
			wren		=> s_wren_char,
			q(0) 		=> s_memory_out_char(1)
		);
	ghost_memory_2 : character_memory 
		GENERIC MAP(
			file_name => "ghost_2.mif"
		)
		PORT MAP (
			data	 	=> s_data_char,
			rdaddress	=> s_rdaddress_char,
			rdclock	 	=> clk,
			wraddress	=> s_wraddress_char,
			wrclock		=> s_wrclock_char,
			wren		=> s_wren_char,
			q(0) 		=> s_memory_out_char(2)
		);
	ghost_memory_3 : character_memory 
		GENERIC MAP(
			file_name => "ghost_3.mif"
		)
		PORT MAP (
			data	 	=> s_data_char,
			rdaddress	=> s_rdaddress_char,
			rdclock	 	=> clk,
			wraddress	=> s_wraddress_char,
			wrclock		=> s_wrclock_char,
			wren		=> s_wren_char,
			q(0) 		=> s_memory_out_char(3)
		);

	ghost_data_decoder : position_data_decoder
		GENERIC MAP 
		(
			char_id_param 	=> "000"	
		)
		PORT MAP 
		(
			clk 			=> clk,
			refresh_image 	=> refresh_image,
			input_vector 	=> position_data,
			position_x 		=> s_position_x,
			position_y 		=> s_position_y,
			state 			=> s_state,
			orientation 	=> s_orientation
		);


------------------------------------------------------------------------
--	PROCESSES
------------------------------------------------------------------------
	
	DISPLAY : PROCESS(clk)
		VARIABLE read_address : INTEGER RANGE 0 TO 575 := 0;
		VARIABLE i_row_x : INTEGER RANGE 0 TO 1339 := 0;
		VARIABLE i_line_y : INTEGER RANGE 0 TO 899 := 0;
		VARIABLE i_position_x : INTEGER RANGE 0 TO 1339 := 0;
		VARIABLE i_position_y : INTEGER RANGE 0 TO 899 := 0;
		VARIABLE i_orientation := INTEGER RANGE 0 TO 3 := 0;
		VARIABLE display_character : BOOLEAN := FALSE;

	BEGIN
		i_row_x := to_integer(unsigned(row_x));
		i_line_y := to_integer(unsigned(line_y));
		i_position_x := to_integer(unsigned(s_position_x));
		i_position_y := to_integer(unsigned(s_position_y));
		i_orientation := to_integer(unsigned(s_orientation));

		display_character := 	(i_row_x - i_position_x >= 6) AND (i_row_x - i_position_x < 54)
		 						AND 
		 						(i_line_y - i_position_y >= 6) AND (i_line_y - i_position_y < 54);


		IF (clk'EVENT AND clk='1') THEN
			CASE state IS 
				WHEN 0 => --sending address to memory
					IF(display_character) THEN
						s_rdaddress_char <= compute_char_address(row_x, line_y, s_position_x, s_position_y);
						state <= 1;
					ELSE 
						vga_r <= (OTHERS => '0');
						vga_g <= (OTHERS => '0');
						vga_b <= (OTHERS => '0');
					END IF;
				WHEN 1 => --wait memory proceed
						s_rdaddress_char <= compute_char_address(row_x, line_y, s_position_x, s_position_y);
						state <= 2;
				WHEN 2 => --state 2 : normal procedure
					IF(display_character) THEN
						s_rdaddress_char <= compute_char_address(row_x, line_y, s_position_x, s_position_y);
						IF(s_memory_out_char(i_orientation) = '1') THEN
							vga_r <= (OTHERS => '1');
							vga_g <= (OTHERS => '1');
							vga_b <= (OTHERS => '0');
						ELSE 
							vga_r <= (OTHERS => '0');
							vga_g <= (OTHERS => '0');
							vga_b <= (OTHERS => '0');
						END IF;
					ELSE 
						IF(s_memory_out_char(i_orientation) = '1') THEN
							vga_r <= (OTHERS => '1');
							vga_g <= (OTHERS => '1');
							vga_b <= (OTHERS => '0');
						ELSE 
							vga_r <= (OTHERS => '0');
							vga_g <= (OTHERS => '0');
							vga_b <= (OTHERS => '0');
						END IF;
						state <= 3;
					END IF;
				WHEN OTHERS => --state 3 : finish display
					IF (s_memory_out_char(i_orientation) = '1') THEN
						vga_r <= (OTHERS => '1');
						vga_g <= (OTHERS => '1');
						vga_b <= (OTHERS => '0');
					ELSE 
						vga_r <= (OTHERS => '0');
						vga_g <= (OTHERS => '0');
						vga_b <= (OTHERS => '0');
					END IF;
					state <= 0;
			END CASE;
		END IF;
	END PROCESS ;

END bdf_type;