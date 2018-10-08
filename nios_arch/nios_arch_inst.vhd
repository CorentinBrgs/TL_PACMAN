	component nios_arch is
		port (
			clk_clk          : in    std_logic                    := 'X';             -- clk
			reset_reset_n    : in    std_logic                    := 'X';             -- reset_n
			memory_mem_ca    : out   std_logic_vector(9 downto 0);                    -- mem_ca
			memory_mem_ck    : out   std_logic_vector(0 downto 0);                    -- mem_ck
			memory_mem_ck_n  : out   std_logic_vector(0 downto 0);                    -- mem_ck_n
			memory_mem_cke   : out   std_logic_vector(0 downto 0);                    -- mem_cke
			memory_mem_cs_n  : out   std_logic_vector(0 downto 0);                    -- mem_cs_n
			memory_mem_dm    : out   std_logic_vector(0 downto 0);                    -- mem_dm
			memory_mem_dq    : inout std_logic_vector(7 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs   : inout std_logic_vector(0 downto 0) := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n : inout std_logic_vector(0 downto 0) := (others => 'X'); -- mem_dqs_n
			oct_rzqin        : in    std_logic                    := 'X'              -- rzqin
		);
	end component nios_arch;

	u0 : component nios_arch
		port map (
			clk_clk          => CONNECTED_TO_clk_clk,          --    clk.clk
			reset_reset_n    => CONNECTED_TO_reset_reset_n,    --  reset.reset_n
			memory_mem_ca    => CONNECTED_TO_memory_mem_ca,    -- memory.mem_ca
			memory_mem_ck    => CONNECTED_TO_memory_mem_ck,    --       .mem_ck
			memory_mem_ck_n  => CONNECTED_TO_memory_mem_ck_n,  --       .mem_ck_n
			memory_mem_cke   => CONNECTED_TO_memory_mem_cke,   --       .mem_cke
			memory_mem_cs_n  => CONNECTED_TO_memory_mem_cs_n,  --       .mem_cs_n
			memory_mem_dm    => CONNECTED_TO_memory_mem_dm,    --       .mem_dm
			memory_mem_dq    => CONNECTED_TO_memory_mem_dq,    --       .mem_dq
			memory_mem_dqs   => CONNECTED_TO_memory_mem_dqs,   --       .mem_dqs
			memory_mem_dqs_n => CONNECTED_TO_memory_mem_dqs_n, --       .mem_dqs_n
			oct_rzqin        => CONNECTED_TO_oct_rzqin         --    oct.rzqin
		);

