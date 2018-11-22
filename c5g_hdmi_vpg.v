
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module C5G_HDMI_VPG(

	//////////// CLOCK //////////
	CLOCK_125_p,
	CLOCK_50_B5B,
	CLOCK_50_B6A,
	CLOCK_50_B7A,
	CLOCK_50_B8A,

	//////////// LED //////////
	LEDG,
	LEDR,

	//////////// KEY //////////
	CPU_RESET_n,
	KEY,

	//////////// SW //////////
	SW,

	//////////// SEG7 //////////
	HEX0,
	HEX1,

	//////////// HDMI-TX //////////
	HDMI_TX_CLK,
	HDMI_TX_D,
	HDMI_TX_DE,
	HDMI_TX_HS,
	HDMI_TX_INT,
	HDMI_TX_VS,

	//////////// ADC SPI //////////
	ADC_CONVST,
	ADC_SCK,
	ADC_SDI,
	ADC_SDO,

	//////////// Audio //////////
	AUD_ADCDAT,
	AUD_ADCLRCK,
	AUD_BCLK,
	AUD_DACDAT,
	AUD_DACLRCK,
	AUD_XCK,

	//////////// I2C for Audio/HDMI-TX/Si5338/HSMC //////////
	I2C_SCL,
	I2C_SDA,

	//////////// SDCARD //////////
	SD_CLK,
	SD_CMD,
	SD_DAT,

	//////////// Uart to USB //////////
	UART_RX,
	UART_TX,

	//////////// SRAM //////////
	SRAM_A,
	SRAM_CE_n,
	SRAM_D,
	SRAM_LB_n,
	SRAM_OE_n,
	SRAM_UB_n,
	SRAM_WE_n,

//	//////////// LPDDR2 //////////
//	DDR2LP_CA,
//	DDR2LP_CK_n,
//	DDR2LP_CK_p,
//	DDR2LP_CKE,
//	DDR2LP_CS_n,
//	DDR2LP_DM,
//	DDR2LP_DQ,
//	DDR2LP_DQS_n,
//	DDR2LP_DQS_p,
//	DDR2LP_OCT_RZQ 
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input 		          		CLOCK_125_p;
input 		          		CLOCK_50_B5B;
input 		          		CLOCK_50_B6A;
input 		          		CLOCK_50_B7A;
input 		          		CLOCK_50_B8A;

//////////// LED //////////
output		     [7:0]		LEDG;
output		     [9:0]		LEDR;

//////////// KEY //////////
input 		          		CPU_RESET_n;
input 		     [3:0]		KEY;

//////////// SW //////////
input 		     [9:0]		SW;

//////////// SEG7 //////////
output		     [6:0]		HEX0;
output		     [6:0]		HEX1;

//////////// HDMI-TX //////////
output		          		HDMI_TX_CLK;
output		    [23:0]		HDMI_TX_D;
output		          		HDMI_TX_DE;
output		          		HDMI_TX_HS;
input 		          		HDMI_TX_INT;
output		          		HDMI_TX_VS;

//////////// ADC SPI //////////
output		          		ADC_CONVST;
output		          		ADC_SCK;
output		          		ADC_SDI;
input 		          		ADC_SDO;

//////////// Audio //////////
input 		          		AUD_ADCDAT;
inout 		          		AUD_ADCLRCK;
inout 		          		AUD_BCLK;
output		          		AUD_DACDAT;
inout 		          		AUD_DACLRCK;
output		          		AUD_XCK;

//////////// I2C for Audio/HDMI-TX/Si5338/HSMC //////////
output		          		I2C_SCL;
inout 		          		I2C_SDA;

//////////// SDCARD //////////
output		          		SD_CLK;
inout 		          		SD_CMD;
inout 		     [3:0]		SD_DAT;

//////////// Uart to USB //////////
input 		          		UART_RX;
output		          		UART_TX;

//////////// SRAM //////////
output		    [17:0]		SRAM_A;
output		          		SRAM_CE_n;
inout 		    [15:0]		SRAM_D;
output		          		SRAM_LB_n;
output		          		SRAM_OE_n;
output		          		SRAM_UB_n;
output		          		SRAM_WE_n;

//////////// LPDDR2 //////////
//output		     [9:0]		DDR2LP_CA;
//output		          		DDR2LP_CK_n;
//output		          		DDR2LP_CK_p;
//output		     [1:0]		DDR2LP_CKE;
//output		     [1:0]		DDR2LP_CS_n;
//output		     [3:0]		DDR2LP_DM;
//inout 		    [31:0]		DDR2LP_DQ;
//inout 		     [3:0]		DDR2LP_DQS_n;
//inout 		     [3:0]		DDR2LP_DQS_p;
//input 		          		DDR2LP_OCT_RZQ;


//=======================================================
//  REG/WIRE declarations
//=======================================================

wire        reset_n;
wire        pll_1200k;
reg  [12:0] counter_1200k;
reg         en_150;
wire        vpg_mode_change;
wire [3:0]	vpg_mode;
//wire        loopback_mode;
//wire        edid_writing;
//Video Pattern Generator
wire [3:0]	vpg_disp_mode;
wire        vpg_pclk;
wire        vpg_de, vpg_hs, vpg_vs;
wire [23:0]	vpg_data;

wire [31:0] position_table_data;
wire        refresh_image;
wire [31:0] background_data;
wire [4:0]  background_wr;

//parallelizer outputs signals
wire [11:0] paral_data_pos;
wire [1:0] 	paral_wraddress_pos;
wire 		paral_wren_pos;
wire        position_memory_updated;

//=======================================================
//  Sub-module
//=======================================================
//system clock
sys_pll u_sys_pll (
	.refclk(CLOCK_50_B7A),
	.rst(!SW[1]),
	.outclk_0(pll_1200k), // 1200K
	.locked(reset_n) );

//video pattern resolution select
vpg_mode u_vpg_mode (
	.reset_n(reset_n),
	.clk(pll_1200k),
	.clk_en(en_150),
	.mode_button(SW[0]),
	.vpg_mode_change(vpg_mode_change),
	.vpg_mode(vpg_mode) );

//pattern generator
vpg	u_vpg (
	.clk_50(CLOCK_50_B7A),
	.reset_n(reset_n),
	.mode(vpg_mode),
	.mode_change(vpg_mode_change),
	.disp_color(`COLOR_RGB444),       
	.vpg_pclk(vpg_pclk),
	.vpg_de(vpg_de),
	.vpg_hs(vpg_hs),
	.vpg_vs(vpg_vs),
	.vpg_r(vpg_data[23:16]),
	.vpg_g(vpg_data[15:8]),
	.vpg_b(vpg_data[7:0]), 
	.position_data(position_table_data),
	.refresh_image(refresh_image),
	.background_data(background_data),
	.background_wraddress(background_wr[3:0]),
	.background_wren(background_wr[4])
);
	
assign HDMI_TX_CLK = vpg_pclk;
assign HDMI_TX_D   = vpg_data;
assign HDMI_TX_DE  = vpg_de;
assign HDMI_TX_HS  = vpg_hs;
assign HDMI_TX_VS  = vpg_vs;

//=======================================================
//  Structural coding
//=======================================================

//LED indication
assign LEDR = ~vpg_mode; // leds are turn on for loopback mode		

always@(posedge pll_1200k or negedge reset_n)
begin
	if (!reset_n)
	begin
	  counter_1200k <= 13'b0;
		en_150 <= 1'b0; //frequency divider
	end
  else
  begin
    counter_1200k <= counter_1200k + 13'b1;
    en_150 <= &counter_1200k;
  end	
end


////////////////////////////////////////
// QSYS


    HDMI_QSYS u0 (
        .clk_clk                            (CLOCK_50_B7A),                            //                         clk.clk
        .reset_reset_n                      (reset_n),                      //                       reset.reset_n
        .led_external_connection_export     (LEDG),     //     led_external_connection.export
        .i2c_sda_external_connection_export (I2C_SDA), // i2c_sda_external_connection.export
        .i2c_scl_external_connection_export (I2C_SCL),  // i2c_scl_external_connection.export
        .hdmi_tx_int_n_external_connection_export  (~HDMI_TX_INT),   // hdmi_tx_int_n_external_connection.export
        .position_table_export(position_table_data),
        .refresh_image_export(refresh_image),
        .background_data_export(background_data),
        .left_button_export(KEY[3]),
        .up_button_export(KEY[2]),
        .down_button_export(KEY[1]),
        .right_button_export(KEY[0]),
		.background_wr_export(background_wr)
    );


endmodule
