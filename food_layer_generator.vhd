 --Copyright (C) 2018  Intel Corporation. All rights reserved.
 --Your use of Intel Corporation's design tools, logic functions 
 --and other software and tools, and its AMPP partner logic 
 --functions, and any output files from any of the foregoing 
 --(including device programming or simulation files), and any 
 --associated documentation or information are expressly subject 
 --to the terms and conditions of the Intel Program License 
 --Subscription Agreement, the Intel Quartus Prime License Agreement,
 --the Intel FPGA IP License Agreement, or other applicable license
 --agreement, including, without limitation, that your use is for
 --the sole purpose of programming logic devices manufactured by
 --Intel and sold by Intel or its authorized distributors.  Please
 --refer to the applicable agreement for further details.

 --PROGRAM		"Quartus Prime"
 --VERSION		"Version 18.0.0 Build 614 04/24/2018 SJ Standard Edition"
 --CREATED		"Wed Oct 17 14:08:35 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

LIBRARY work;

ENTITY food_layer_generator IS 
	PORT
	(
		clk 			:  	IN STD_LOGIC;
		nios_clk		:	IN STD_LOGIC;
		row_x 			:  	IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		line_y 			:  	IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		enable 			: 	IN STD_LOGIC;
		reset 			: 	IN STD_LOGIC;
		
		data			: 	IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wraddress	: 	IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		wren			: 	IN STD_LOGIC;

		vga_r 			:  	OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_g 			:  	OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_b 			:  	OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END food_layer_generator;

ARCHITECTURE bdf_type OF food_layer_generator IS 
	
	SIGNAL s_rdaddress	: STD_LOGIC_VECTOR (8 DOWNTO 0) 	:= (OTHERS => '0');
	SIGNAL s_memory_out	: STD_LOGIC_VECTOR (0 DOWNTO 0) 	:= (OTHERS => '0');

	SIGNAL s_position_x : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');
	SIGNAL s_position_y	: STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');

	--control signals
	SIGNAL state : INTEGER RANGE 0 TO 4 := 0;

	COMPONENT background_memory
		PORT(
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			rdaddress	: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
			rdclock		: IN STD_LOGIC ;
			wraddress	: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			wrclock		: IN STD_LOGIC  := '1';
			wren		: IN STD_LOGIC  := '0';
			q			: OUT STD_LOGIC_VECTOR (0 DOWNTO 0)
		);
	END COMPONENT;

BEGIN 

	food_layer_memory : background_memory
	PORT MAP(
		data 		=> data,
		rdaddress 	=> s_rdaddress,
		rdclock 	=> clk,
		wraddress 	=> wraddress,
		wrclock 	=> nios_clk,
		wren 		=> wren,
		q 			=> s_memory_out
	);

	----------------------------------------------------------
	--	PROCESSES
	----------------------------------------------------------
	PROCESS(clk)
		VARIABLE read_address 	: STD_LOGIC_VECTOR(8 DOWNTO 0) := (OTHERS => '0');
		VARIABLE i_row_x		: INTEGER RANGE 0 TO 1440 := 0;
		VARIABLE i_line_y		: INTEGER RANGE 0 TO 900 := 0;
	BEGIN
		IF (clk'EVENT AND clk='1') THEN
			i_row_x := to_integer(unsigned(row_x));
			i_line_y := to_integer(unsigned(line_y));
			CASE state IS 
				WHEN 0 => --sending address to memory
					IF(
						(enable = '1') 
						AND 
						((i_row_x MOD 60) > 25)
						AND 
						((i_row_x MOD 60) < 35)
						AND 
						((i_line_y MOD 60) > 25)
						AND 
						((i_line_y MOD 60) < 35)
					)THEN
						read_address := STD_LOGIC_VECTOR(to_unsigned(8+ ((i_row_x / 60) + (i_line_y / 60)*32), 9));
						s_rdaddress <= read_address;
						state <= 1;
					ELSE 
						vga_r <= (OTHERS => '0');
						vga_g <= (OTHERS => '0');
						vga_b <= (OTHERS => '0');
					END IF;
				WHEN 1 => --wait memory proceed
					read_address := STD_LOGIC_VECTOR(to_unsigned(8+ ((i_row_x / 60) + (i_line_y / 60)*32), 9));
					s_rdaddress <= read_address;
					state <= 2;
				WHEN 2 => --state 2 : normal procedure
					IF(
						(enable = '1') 
						AND 
						((i_row_x MOD 60) > 25)
						AND 
						((i_row_x MOD 60) < 35)
						AND 
						((i_line_y MOD 60) > 25)
						AND 
						((i_line_y MOD 60) < 35)
					)THEN
						read_address := STD_LOGIC_VECTOR(to_unsigned(8+ ((i_row_x / 60) + (i_line_y / 60)*32), 9));
						s_rdaddress <= read_address;						
						IF(s_memory_out(0) = '1') THEN
							vga_r <= (OTHERS => '1');
							vga_g <= (OTHERS => '1');
							vga_b <= (OTHERS => '1');
						ELSE 
							vga_r <= (OTHERS => '0');
							vga_g <= (OTHERS => '0');
							vga_b <= (OTHERS => '0');
						END IF;
					ELSE 
						IF(s_memory_out(0) = '1') THEN
							vga_r <= (OTHERS => '1');
							vga_g <= (OTHERS => '1');
							vga_b <= (OTHERS => '1');
						ELSE 
							vga_r <= (OTHERS => '0');
							vga_g <= (OTHERS => '0');
							vga_b <= (OTHERS => '0');
						END IF;
						state <= 3;
					END IF;
				WHEN OTHERS => --state 3 : finish display
					IF (s_memory_out(0) = '1') THEN
						vga_r <= (OTHERS => '1');
						vga_g <= (OTHERS => '1');
						vga_b <= (OTHERS => '1');
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