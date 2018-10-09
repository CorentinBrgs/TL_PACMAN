# Copyright (C) 2018  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details.

# Quartus Prime: Generate Tcl File for Project
# File: PACMAN.tcl
# Generated on: Tue Oct 09 16:42:34 2018

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "PACMAN"]} {
		puts "Project PACMAN is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists PACMAN]} {
		project_open -revision C5G_HDMI_VPG PACMAN
	} else {
		project_new -revision C5G_HDMI_VPG PACMAN
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone V"
	set_global_assignment -name DEVICE 5CGXFC5C6F27C7
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 12.0
	set_global_assignment -name LAST_QUARTUS_VERSION "18.1.0 Lite Edition"
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "17:05:59 JULY 05,2013"
	set_global_assignment -name DEVICE_FILTER_PACKAGE FBGA
	set_global_assignment -name DEVICE_FILTER_PIN_COUNT 672
	set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 8_H6
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "2.5 V"
	set_global_assignment -name QIP_FILE HDMI_QSYS/synthesis/HDMI_QSYS.qip
	set_global_assignment -name VERILOG_FILE vpg_source/pll_controller.v
	set_global_assignment -name VERILOG_FILE vpg_source/vpg.v
	set_global_assignment -name VERILOG_FILE vpg_source/vpg_mode.v
	set_global_assignment -name VERILOG_FILE vpg_source/vga_generator.v
	set_global_assignment -name SDC_FILE C5G_HDMI_VPG.SDC
	set_global_assignment -name QIP_FILE sys_pll.qip
	set_global_assignment -name SIP_FILE sys_pll.sip
	set_global_assignment -name QIP_FILE vpg_source/pll.qip
	set_global_assignment -name SIP_FILE vpg_source/pll.sip
	set_global_assignment -name QIP_FILE vpg_source/pll_reconfig.qip
	set_global_assignment -name SIP_FILE vpg_source/pll_reconfig.sip
	set_global_assignment -name SDC_FILE C5G_HDMI_VPG.sdc
	set_location_assignment PIN_U12 -to CLOCK_125_p
	set_instance_assignment -name IO_STANDARD LVDS -to CLOCK_125_p
	set_location_assignment PIN_R20 -to CLOCK_50_B5B
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK_50_B5B
	set_location_assignment PIN_N20 -to CLOCK_50_B6A
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK_50_B6A
	set_location_assignment PIN_H12 -to CLOCK_50_B7A
	set_instance_assignment -name IO_STANDARD "2.5 V" -to CLOCK_50_B7A
	set_location_assignment PIN_M10 -to CLOCK_50_B8A
	set_instance_assignment -name IO_STANDARD "2.5 V" -to CLOCK_50_B8A
	set_location_assignment PIN_L7 -to LEDG[0]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[0]
	set_location_assignment PIN_K6 -to LEDG[1]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[1]
	set_location_assignment PIN_D8 -to LEDG[2]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[2]
	set_location_assignment PIN_E9 -to LEDG[3]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[3]
	set_location_assignment PIN_A5 -to LEDG[4]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[4]
	set_location_assignment PIN_B6 -to LEDG[5]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[5]
	set_location_assignment PIN_H8 -to LEDG[6]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[6]
	set_location_assignment PIN_H9 -to LEDG[7]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[7]
	set_location_assignment PIN_F7 -to LEDR[0]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[0]
	set_location_assignment PIN_F6 -to LEDR[1]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[1]
	set_location_assignment PIN_G6 -to LEDR[2]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[2]
	set_location_assignment PIN_G7 -to LEDR[3]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[3]
	set_location_assignment PIN_J8 -to LEDR[4]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[4]
	set_location_assignment PIN_J7 -to LEDR[5]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[5]
	set_location_assignment PIN_K10 -to LEDR[6]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[6]
	set_location_assignment PIN_K8 -to LEDR[7]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[7]
	set_location_assignment PIN_H7 -to LEDR[8]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[8]
	set_location_assignment PIN_J10 -to LEDR[9]
	set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[9]
	set_location_assignment PIN_P11 -to KEY[0]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to KEY[0]
	set_location_assignment PIN_P12 -to KEY[1]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to KEY[1]
	set_location_assignment PIN_Y15 -to KEY[2]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to KEY[2]
	set_location_assignment PIN_Y16 -to KEY[3]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to KEY[3]
	set_location_assignment PIN_AB24 -to CPU_RESET_n
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CPU_RESET_n
	set_location_assignment PIN_AC9 -to SW[0]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[0]
	set_location_assignment PIN_AE10 -to SW[1]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[1]
	set_location_assignment PIN_AD13 -to SW[2]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[2]
	set_location_assignment PIN_AC8 -to SW[3]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[3]
	set_location_assignment PIN_W11 -to SW[4]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[4]
	set_location_assignment PIN_AB10 -to SW[5]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[5]
	set_location_assignment PIN_V10 -to SW[6]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[6]
	set_location_assignment PIN_AC10 -to SW[7]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[7]
	set_location_assignment PIN_Y11 -to SW[8]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[8]
	set_location_assignment PIN_AE19 -to SW[9]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to SW[9]
	set_location_assignment PIN_V19 -to HEX0[0]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[0]
	set_location_assignment PIN_V18 -to HEX0[1]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[1]
	set_location_assignment PIN_V17 -to HEX0[2]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[2]
	set_location_assignment PIN_W18 -to HEX0[3]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[3]
	set_location_assignment PIN_Y20 -to HEX0[4]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[4]
	set_location_assignment PIN_Y19 -to HEX0[5]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[5]
	set_location_assignment PIN_Y18 -to HEX0[6]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX0[6]
	set_location_assignment PIN_AA18 -to HEX1[0]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[0]
	set_location_assignment PIN_AD26 -to HEX1[1]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[1]
	set_location_assignment PIN_AB19 -to HEX1[2]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[2]
	set_location_assignment PIN_AE26 -to HEX1[3]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[3]
	set_location_assignment PIN_AE25 -to HEX1[4]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[4]
	set_location_assignment PIN_AC19 -to HEX1[5]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[5]
	set_location_assignment PIN_AF24 -to HEX1[6]
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HEX1[6]
	set_location_assignment PIN_U26 -to HDMI_TX_HS
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_HS
	set_location_assignment PIN_U25 -to HDMI_TX_VS
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_VS
	set_location_assignment PIN_Y25 -to HDMI_TX_CLK
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_CLK
	set_location_assignment PIN_Y26 -to HDMI_TX_DE
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_DE
	set_location_assignment PIN_T12 -to HDMI_TX_INT
	set_instance_assignment -name IO_STANDARD "1.2 V" -to HDMI_TX_INT
	set_location_assignment PIN_V23 -to HDMI_TX_D[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[0]
	set_location_assignment PIN_AA26 -to HDMI_TX_D[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[1]
	set_location_assignment PIN_W25 -to HDMI_TX_D[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[2]
	set_location_assignment PIN_W26 -to HDMI_TX_D[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[3]
	set_location_assignment PIN_V24 -to HDMI_TX_D[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[4]
	set_location_assignment PIN_V25 -to HDMI_TX_D[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[5]
	set_location_assignment PIN_U24 -to HDMI_TX_D[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[6]
	set_location_assignment PIN_T23 -to HDMI_TX_D[7]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[7]
	set_location_assignment PIN_T24 -to HDMI_TX_D[8]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[8]
	set_location_assignment PIN_T26 -to HDMI_TX_D[9]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[9]
	set_location_assignment PIN_R23 -to HDMI_TX_D[10]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[10]
	set_location_assignment PIN_R25 -to HDMI_TX_D[11]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[11]
	set_location_assignment PIN_P22 -to HDMI_TX_D[12]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[12]
	set_location_assignment PIN_P23 -to HDMI_TX_D[13]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[13]
	set_location_assignment PIN_N25 -to HDMI_TX_D[14]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[14]
	set_location_assignment PIN_P26 -to HDMI_TX_D[15]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[15]
	set_location_assignment PIN_P21 -to HDMI_TX_D[16]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[16]
	set_location_assignment PIN_R24 -to HDMI_TX_D[17]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[17]
	set_location_assignment PIN_R26 -to HDMI_TX_D[18]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[18]
	set_location_assignment PIN_AB26 -to HDMI_TX_D[19]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[19]
	set_location_assignment PIN_AA24 -to HDMI_TX_D[20]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[20]
	set_location_assignment PIN_AB25 -to HDMI_TX_D[21]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[21]
	set_location_assignment PIN_AC25 -to HDMI_TX_D[22]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[22]
	set_location_assignment PIN_AD25 -to HDMI_TX_D[23]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HDMI_TX_D[23]
	set_location_assignment PIN_AB22 -to ADC_CONVST
	set_instance_assignment -name IO_STANDARD "1.2 V" -to ADC_CONVST
	set_location_assignment PIN_AA21 -to ADC_SCK
	set_instance_assignment -name IO_STANDARD "1.2 V" -to ADC_SCK
	set_location_assignment PIN_Y10 -to ADC_SDI
	set_instance_assignment -name IO_STANDARD "1.2 V" -to ADC_SDI
	set_location_assignment PIN_W10 -to ADC_SDO
	set_instance_assignment -name IO_STANDARD "1.2 V" -to ADC_SDO
	set_location_assignment PIN_C7 -to AUD_ADCLRCK
	set_instance_assignment -name IO_STANDARD "2.5 V" -to AUD_ADCLRCK
	set_location_assignment PIN_D7 -to AUD_ADCDAT
	set_instance_assignment -name IO_STANDARD "2.5 V" -to AUD_ADCDAT
	set_location_assignment PIN_G10 -to AUD_DACLRCK
	set_instance_assignment -name IO_STANDARD "2.5 V" -to AUD_DACLRCK
	set_location_assignment PIN_H10 -to AUD_DACDAT
	set_instance_assignment -name IO_STANDARD "2.5 V" -to AUD_DACDAT
	set_location_assignment PIN_D6 -to AUD_XCK
	set_instance_assignment -name IO_STANDARD "2.5 V" -to AUD_XCK
	set_location_assignment PIN_E6 -to AUD_BCLK
	set_instance_assignment -name IO_STANDARD "2.5 V" -to AUD_BCLK
	set_location_assignment PIN_B7 -to I2C_SCL
	set_instance_assignment -name IO_STANDARD "2.5 V" -to I2C_SCL
	set_location_assignment PIN_G11 -to I2C_SDA
	set_instance_assignment -name IO_STANDARD "2.5 V" -to I2C_SDA
	set_location_assignment PIN_W8 -to SD_CMD
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_CMD
	set_location_assignment PIN_AB6 -to SD_CLK
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_CLK
	set_location_assignment PIN_U7 -to SD_DAT[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_DAT[0]
	set_location_assignment PIN_T7 -to SD_DAT[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_DAT[1]
	set_location_assignment PIN_V8 -to SD_DAT[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_DAT[2]
	set_location_assignment PIN_T8 -to SD_DAT[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_DAT[3]
	set_location_assignment PIN_L9 -to UART_TX
	set_instance_assignment -name IO_STANDARD "2.5 V" -to UART_TX
	set_location_assignment PIN_M9 -to UART_RX
	set_instance_assignment -name IO_STANDARD "2.5 V" -to UART_RX
	set_location_assignment PIN_B25 -to SRAM_A[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[0]
	set_location_assignment PIN_B26 -to SRAM_A[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[1]
	set_location_assignment PIN_H19 -to SRAM_A[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[2]
	set_location_assignment PIN_H20 -to SRAM_A[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[3]
	set_location_assignment PIN_D25 -to SRAM_A[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[4]
	set_location_assignment PIN_C25 -to SRAM_A[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[5]
	set_location_assignment PIN_J20 -to SRAM_A[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[6]
	set_location_assignment PIN_J21 -to SRAM_A[7]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[7]
	set_location_assignment PIN_D22 -to SRAM_A[8]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[8]
	set_location_assignment PIN_E23 -to SRAM_A[9]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[9]
	set_location_assignment PIN_G20 -to SRAM_A[10]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[10]
	set_location_assignment PIN_F21 -to SRAM_A[11]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[11]
	set_location_assignment PIN_E21 -to SRAM_A[12]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[12]
	set_location_assignment PIN_F22 -to SRAM_A[13]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[13]
	set_location_assignment PIN_J25 -to SRAM_A[14]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[14]
	set_location_assignment PIN_J26 -to SRAM_A[15]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[15]
	set_location_assignment PIN_N24 -to SRAM_A[16]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[16]
	set_location_assignment PIN_M24 -to SRAM_A[17]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_A[17]
	set_location_assignment PIN_E24 -to SRAM_D[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[0]
	set_location_assignment PIN_E25 -to SRAM_D[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[1]
	set_location_assignment PIN_K24 -to SRAM_D[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[2]
	set_location_assignment PIN_K23 -to SRAM_D[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[3]
	set_location_assignment PIN_F24 -to SRAM_D[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[4]
	set_location_assignment PIN_G24 -to SRAM_D[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[5]
	set_location_assignment PIN_L23 -to SRAM_D[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[6]
	set_location_assignment PIN_L24 -to SRAM_D[7]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[7]
	set_location_assignment PIN_H23 -to SRAM_D[8]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[8]
	set_location_assignment PIN_H24 -to SRAM_D[9]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[9]
	set_location_assignment PIN_H22 -to SRAM_D[10]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[10]
	set_location_assignment PIN_J23 -to SRAM_D[11]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[11]
	set_location_assignment PIN_F23 -to SRAM_D[12]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[12]
	set_location_assignment PIN_G22 -to SRAM_D[13]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[13]
	set_location_assignment PIN_L22 -to SRAM_D[14]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[14]
	set_location_assignment PIN_K21 -to SRAM_D[15]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_D[15]
	set_location_assignment PIN_M25 -to SRAM_UB_n
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_UB_n
	set_location_assignment PIN_H25 -to SRAM_LB_n
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_LB_n
	set_location_assignment PIN_N23 -to SRAM_CE_n
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_CE_n
	set_location_assignment PIN_M22 -to SRAM_OE_n
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_OE_n
	set_location_assignment PIN_G25 -to SRAM_WE_n
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_WE_n
	set_location_assignment PIN_N10 -to DDR2LP_CK_p
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V HSUL" -to DDR2LP_CK_p
	set_location_assignment PIN_P10 -to DDR2LP_CK_n
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V HSUL" -to DDR2LP_CK_n
	set_location_assignment PIN_V13 -to DDR2LP_DQS_p[0]
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V HSUL" -to DDR2LP_DQS_p[0]
	set_location_assignment PIN_W13 -to DDR2LP_DQS_n[0]
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V HSUL" -to DDR2LP_DQS_n[0]
	set_location_assignment PIN_U14 -to DDR2LP_DQS_p[1]
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V HSUL" -to DDR2LP_DQS_p[1]
	set_location_assignment PIN_V14 -to DDR2LP_DQS_n[1]
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V HSUL" -to DDR2LP_DQS_n[1]
	set_location_assignment PIN_V15 -to DDR2LP_DQS_p[2]
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V HSUL" -to DDR2LP_DQS_p[2]
	set_location_assignment PIN_W15 -to DDR2LP_DQS_n[2]
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V HSUL" -to DDR2LP_DQS_n[2]
	set_location_assignment PIN_W16 -to DDR2LP_DQS_p[3]
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V HSUL" -to DDR2LP_DQS_p[3]
	set_location_assignment PIN_W17 -to DDR2LP_DQS_n[3]
	set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.2-V HSUL" -to DDR2LP_DQS_n[3]
	set_location_assignment PIN_AF14 -to DDR2LP_CKE[0]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CKE[0]
	set_location_assignment PIN_AE13 -to DDR2LP_CKE[1]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CKE[1]
	set_location_assignment PIN_R11 -to DDR2LP_CS_n[0]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CS_n[0]
	set_location_assignment PIN_T11 -to DDR2LP_CS_n[1]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CS_n[1]
	set_location_assignment PIN_AF11 -to DDR2LP_DM[0]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DM[0]
	set_location_assignment PIN_AE18 -to DDR2LP_DM[1]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DM[1]
	set_location_assignment PIN_AE20 -to DDR2LP_DM[2]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DM[2]
	set_location_assignment PIN_AE24 -to DDR2LP_DM[3]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DM[3]
	set_location_assignment PIN_AE11 -to DDR2LP_OCT_RZQ
	set_instance_assignment -name IO_STANDARD "1.2 V" -to DDR2LP_OCT_RZQ
	set_location_assignment PIN_AA14 -to DDR2LP_DQ[0]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[0]
	set_location_assignment PIN_Y14 -to DDR2LP_DQ[1]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[1]
	set_location_assignment PIN_AD11 -to DDR2LP_DQ[2]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[2]
	set_location_assignment PIN_AD12 -to DDR2LP_DQ[3]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[3]
	set_location_assignment PIN_Y13 -to DDR2LP_DQ[4]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[4]
	set_location_assignment PIN_W12 -to DDR2LP_DQ[5]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[5]
	set_location_assignment PIN_AD10 -to DDR2LP_DQ[6]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[6]
	set_location_assignment PIN_AF12 -to DDR2LP_DQ[7]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[7]
	set_location_assignment PIN_AC15 -to DDR2LP_DQ[8]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[8]
	set_location_assignment PIN_AB15 -to DDR2LP_DQ[9]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[9]
	set_location_assignment PIN_AC14 -to DDR2LP_DQ[10]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[10]
	set_location_assignment PIN_AF13 -to DDR2LP_DQ[11]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[11]
	set_location_assignment PIN_AB16 -to DDR2LP_DQ[12]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[12]
	set_location_assignment PIN_AA16 -to DDR2LP_DQ[13]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[13]
	set_location_assignment PIN_AE14 -to DDR2LP_DQ[14]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[14]
	set_location_assignment PIN_AF18 -to DDR2LP_DQ[15]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[15]
	set_location_assignment PIN_AD16 -to DDR2LP_DQ[16]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[16]
	set_location_assignment PIN_AD17 -to DDR2LP_DQ[17]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[17]
	set_location_assignment PIN_AC18 -to DDR2LP_DQ[18]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[18]
	set_location_assignment PIN_AF19 -to DDR2LP_DQ[19]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[19]
	set_location_assignment PIN_AC17 -to DDR2LP_DQ[20]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[20]
	set_location_assignment PIN_AB17 -to DDR2LP_DQ[21]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[21]
	set_location_assignment PIN_AF21 -to DDR2LP_DQ[22]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[22]
	set_location_assignment PIN_AE21 -to DDR2LP_DQ[23]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[23]
	set_location_assignment PIN_AE15 -to DDR2LP_DQ[24]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[24]
	set_location_assignment PIN_AE16 -to DDR2LP_DQ[25]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[25]
	set_location_assignment PIN_AC20 -to DDR2LP_DQ[26]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[26]
	set_location_assignment PIN_AD21 -to DDR2LP_DQ[27]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[27]
	set_location_assignment PIN_AF16 -to DDR2LP_DQ[28]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[28]
	set_location_assignment PIN_AF17 -to DDR2LP_DQ[29]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[29]
	set_location_assignment PIN_AD23 -to DDR2LP_DQ[30]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[30]
	set_location_assignment PIN_AF23 -to DDR2LP_DQ[31]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_DQ[31]
	set_location_assignment PIN_AE6 -to DDR2LP_CA[0]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CA[0]
	set_location_assignment PIN_AF6 -to DDR2LP_CA[1]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CA[1]
	set_location_assignment PIN_AF7 -to DDR2LP_CA[2]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CA[2]
	set_location_assignment PIN_AF8 -to DDR2LP_CA[3]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CA[3]
	set_location_assignment PIN_U10 -to DDR2LP_CA[4]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CA[4]
	set_location_assignment PIN_U11 -to DDR2LP_CA[5]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CA[5]
	set_location_assignment PIN_AE9 -to DDR2LP_CA[6]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CA[6]
	set_location_assignment PIN_AF9 -to DDR2LP_CA[7]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CA[7]
	set_location_assignment PIN_AB12 -to DDR2LP_CA[8]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CA[8]
	set_location_assignment PIN_AB11 -to DDR2LP_CA[9]
	set_instance_assignment -name IO_STANDARD "1.2-V HSUL" -to DDR2LP_CA[9]
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
