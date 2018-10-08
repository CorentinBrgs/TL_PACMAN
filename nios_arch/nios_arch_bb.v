
module nios_arch (
	terasic_sram_0_conduit_end_DQ,
	terasic_sram_0_conduit_end_ADDR,
	terasic_sram_0_conduit_end_UB_n,
	terasic_sram_0_conduit_end_LB_n,
	terasic_sram_0_conduit_end_WE_n,
	terasic_sram_0_conduit_end_CE_n,
	terasic_sram_0_conduit_end_OE_n,
	nios2_qsys_0_custom_instruction_master_readra,
	nios2_qsys_0_d_irq_irq);	

	inout	[15:0]	terasic_sram_0_conduit_end_DQ;
	output	[19:0]	terasic_sram_0_conduit_end_ADDR;
	output		terasic_sram_0_conduit_end_UB_n;
	output		terasic_sram_0_conduit_end_LB_n;
	output		terasic_sram_0_conduit_end_WE_n;
	output		terasic_sram_0_conduit_end_CE_n;
	output		terasic_sram_0_conduit_end_OE_n;
	output		nios2_qsys_0_custom_instruction_master_readra;
	input	[31:0]	nios2_qsys_0_d_irq_irq;
endmodule
