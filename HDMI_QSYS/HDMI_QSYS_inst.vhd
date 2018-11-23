	component HDMI_QSYS is
		port (
			background_data_export                   : out   std_logic_vector(31 downto 0);        -- export
			background_wr_export                     : out   std_logic_vector(4 downto 0);         -- export
			clk_clk                                  : in    std_logic                     := 'X'; -- clk
			down_button_export                       : in    std_logic                     := 'X'; -- export
			food_layer_data_export                   : out   std_logic_vector(31 downto 0);        -- export
			food_layer_wr_export                     : out   std_logic_vector(4 downto 0);         -- export
			hdmi_tx_int_n_external_connection_export : in    std_logic                     := 'X'; -- export
			i2c_scl_external_connection_export       : out   std_logic;                            -- export
			i2c_sda_external_connection_export       : inout std_logic                     := 'X'; -- export
			led_external_connection_export           : out   std_logic_vector(7 downto 0);         -- export
			left_button_export                       : in    std_logic                     := 'X'; -- export
			position_table_export                    : out   std_logic_vector(31 downto 0);        -- export
			refresh_image_export                     : in    std_logic                     := 'X'; -- export
			reset_reset_n                            : in    std_logic                     := 'X'; -- reset_n
			right_button_export                      : in    std_logic                     := 'X'; -- export
			segments_display_export                  : out   std_logic_vector(20 downto 0);        -- export
			up_button_export                         : in    std_logic                     := 'X'  -- export
		);
	end component HDMI_QSYS;

	u0 : component HDMI_QSYS
		port map (
			background_data_export                   => CONNECTED_TO_background_data_export,                   --                   background_data.export
			background_wr_export                     => CONNECTED_TO_background_wr_export,                     --                     background_wr.export
			clk_clk                                  => CONNECTED_TO_clk_clk,                                  --                               clk.clk
			down_button_export                       => CONNECTED_TO_down_button_export,                       --                       down_button.export
			food_layer_data_export                   => CONNECTED_TO_food_layer_data_export,                   --                   food_layer_data.export
			food_layer_wr_export                     => CONNECTED_TO_food_layer_wr_export,                     --                     food_layer_wr.export
			hdmi_tx_int_n_external_connection_export => CONNECTED_TO_hdmi_tx_int_n_external_connection_export, -- hdmi_tx_int_n_external_connection.export
			i2c_scl_external_connection_export       => CONNECTED_TO_i2c_scl_external_connection_export,       --       i2c_scl_external_connection.export
			i2c_sda_external_connection_export       => CONNECTED_TO_i2c_sda_external_connection_export,       --       i2c_sda_external_connection.export
			led_external_connection_export           => CONNECTED_TO_led_external_connection_export,           --           led_external_connection.export
			left_button_export                       => CONNECTED_TO_left_button_export,                       --                       left_button.export
			position_table_export                    => CONNECTED_TO_position_table_export,                    --                    position_table.export
			refresh_image_export                     => CONNECTED_TO_refresh_image_export,                     --                     refresh_image.export
			reset_reset_n                            => CONNECTED_TO_reset_reset_n,                            --                             reset.reset_n
			right_button_export                      => CONNECTED_TO_right_button_export,                      --                      right_button.export
			segments_display_export                  => CONNECTED_TO_segments_display_export,                  --                  segments_display.export
			up_button_export                         => CONNECTED_TO_up_button_export                          --                         up_button.export
		);

