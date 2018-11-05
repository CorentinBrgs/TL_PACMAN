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

ENTITY background_generator IS 
	PORT
	(
		row_x :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		line_y :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
		enable : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		clk :  IN  STD_LOGIC;
		vga_r :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_g :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		vga_b :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END background_generator;

ARCHITECTURE bdf_type OF background_generator IS 
	
	SIGNAL s_wren : STD_LOGIC := '0';
	SIGNAL s_data : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
	SIGNAL s_rdaddress : STD_LOGIC_VECTOR(8 DOWNTO 0) := (OTHERS => '0');
	SIGNAL s_wraddress : STD_LOGIC_VECTOR(8 DOWNTO 0) := (OTHERS => '0');
	SIGNAL memory_out : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');

	SIGNAL bloc_x : STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0'); --24 blocs dans la direction horizontale
	SIGNAL bloc_y : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); --15 blocs dans la direction verticale

	--control signals
	SIGNAL ctrl_read_address : STD_LOGIC := '0';
	SIGNAL ctrl_wait_memory : STD_LOGIC := '0';

	COMPONENT background_memory
		PORT(wren : IN STD_LOGIC;
			 clock : IN STD_LOGIC;
			 data : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			 rdaddress : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
			 wraddress : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
			 q : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
		);
	END COMPONENT;

BEGIN 

	b2v_inst : background_memory
	PORT MAP(
		clock => clk,
		wren => s_wren,
		data => s_data,
		rdaddress => s_rdaddress,
		wraddress => s_wraddress,
		q => memory_out
	);

--	MIRE : PROCESS(clk) --this process is used to see if the display is centered, with one red square 10*10px in each corner of the screen
--	BEGIN
--		s_wren <= '0';
--		IF (clk'EVENT AND clk='1') THEN
--			IF(enable='1') THEN
--				vga_r <= (OTHERS => '1');
--				vga_g <= (OTHERS => '1');
--				vga_b <= (OTHERS => '1');
--				IF (
--						(
--						to_integer(unsigned(row_x)) <= 11 
--						OR 
--						to_integer(unsigned(row_x)) > 1430 
--						)
--					AND (
--						to_integer(unsigned(line_y)) <= 11 
--						OR 
--						to_integer(unsigned(line_y)) > 890 
--						)
--					) THEN
--					vga_g <= (OTHERS => '0');
--					vga_b <= (OTHERS => '0');
--				END IF; 
--			ELSE
--				vga_r <= (OTHERS => '0');
--				vga_g <= (OTHERS => '1');
--				vga_b <= (OTHERS => '1');
--			END IF ;
--
--			IF(reset='1') THEN
--
--			END IF;
--		END IF;
--	END PROCESS ;

	--MIRE2 : PROCESS(clk) --this process is used to see if the row_x and line_y signals are ok.
	--BEGIN
	--	s_wren <= '0';
	--	IF (clk'EVENT AND clk='1') THEN
	--		IF(enable='1') THEN
	--			vga_r <= std_logic_vector (to_unsigned (to_integer(unsigned(row_x)) mod 256, 8));
	--			vga_g <= std_logic_vector (to_unsigned (to_integer(unsigned(line_y)) mod 256, 8));
	--			vga_b <= (OTHERS => '0');
	--		ELSE
	--			vga_r <= (OTHERS => '0');
	--			vga_g <= (OTHERS => '0');
	--			vga_b <= (OTHERS => '1');
	--		END IF ;

	--		IF(reset='1') THEN

	--		END IF;
	--	END IF;
	--END PROCESS ;

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