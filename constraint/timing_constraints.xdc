# =========================================================
# CLOCK CONSTRAINT (100 MHz)
# =========================================================
# This defines a 100 MHz clock (10 ns period) on the 'clk' input port.
create_clock -period 10.000 -name sys_clk -waveform {0.000 5.000} [get_ports clk]

# =========================================================
# RELAXED INPUT DELAYS 
# =========================================================
# Reduced to 1.0ns to allow more time for internal routing and logic
set_input_delay -clock [get_clocks sys_clk] 1.000 [get_ports i_rst]
set_input_delay -clock [get_clocks sys_clk] 1.000 [get_ports i_load_pin]
set_input_delay -clock [get_clocks sys_clk] 1.000 [get_ports i_en_decoder]

# Array/bus constraints
set_input_delay -clock [get_clocks sys_clk] 1.000 [get_ports {i_reg_ctrl[*]}]
set_input_delay -clock [get_clocks sys_clk] 1.000 [get_ports {i_data_in[*]}]

# =========================================================
# RELAXED OUTPUT DELAYS
# =========================================================
# Reduced to 1.0ns to allow more time for internal routing and logic
set_output_delay -clock [get_clocks sys_clk] 1.000 [get_ports {o_data_out[*]}]