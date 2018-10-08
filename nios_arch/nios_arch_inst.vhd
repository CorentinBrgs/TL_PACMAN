	component nios_arch is
		port (
			terasic_sram_0_conduit_end_DQ                 : inout std_logic_vector(15 downto 0) := (others => 'X'); -- DQ
			terasic_sram_0_conduit_end_ADDR               : out   std_logic_vector(19 downto 0);                    -- ADDR
			terasic_sram_0_conduit_end_UB_n               : out   std_logic;                                        -- UB_n
			terasic_sram_0_conduit_end_LB_n               : out   std_logic;                                        -- LB_n
			terasic_sram_0_conduit_end_WE_n               : out   std_logic;                                        -- WE_n
			terasic_sram_0_conduit_end_CE_n               : out   std_logic;                                        -- CE_n
			terasic_sram_0_conduit_end_OE_n               : out   std_logic;                                        -- OE_n
			nios2_qsys_0_custom_instruction_master_readra : out   std_logic;                                        -- readra
			nios2_qsys_0_d_irq_irq                        : in    std_logic_vector(31 downto 0) := (others => 'X')  -- irq
		);
	end component nios_arch;

	u0 : component nios_arch
		port map (
			terasic_sram_0_conduit_end_DQ                 => CONNECTED_TO_terasic_sram_0_conduit_end_DQ,                 --             terasic_sram_0_conduit_end.DQ
			terasic_sram_0_conduit_end_ADDR               => CONNECTED_TO_terasic_sram_0_conduit_end_ADDR,               --                                       .ADDR
			terasic_sram_0_conduit_end_UB_n               => CONNECTED_TO_terasic_sram_0_conduit_end_UB_n,               --                                       .UB_n
			terasic_sram_0_conduit_end_LB_n               => CONNECTED_TO_terasic_sram_0_conduit_end_LB_n,               --                                       .LB_n
			terasic_sram_0_conduit_end_WE_n               => CONNECTED_TO_terasic_sram_0_conduit_end_WE_n,               --                                       .WE_n
			terasic_sram_0_conduit_end_CE_n               => CONNECTED_TO_terasic_sram_0_conduit_end_CE_n,               --                                       .CE_n
			terasic_sram_0_conduit_end_OE_n               => CONNECTED_TO_terasic_sram_0_conduit_end_OE_n,               --                                       .OE_n
			nios2_qsys_0_custom_instruction_master_readra => CONNECTED_TO_nios2_qsys_0_custom_instruction_master_readra, -- nios2_qsys_0_custom_instruction_master.readra
			nios2_qsys_0_d_irq_irq                        => CONNECTED_TO_nios2_qsys_0_d_irq_irq                         --                     nios2_qsys_0_d_irq.irq
		);

