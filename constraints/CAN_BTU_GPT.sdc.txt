############################################################
# CAN Controller - Bit Timing Unit
# Timing Constraints
############################################################

############################################################
# CLOCK DEFINITION
############################################################

# System clock
create_clock \
    -name sys_clk \
    -period 20.000 \
    [get_ports clk]


############################################################
# CLOCK UNCERTAINTY
############################################################

# Typical FPGA margin
set_clock_uncertainty 0.150 [get_clocks sys_clk]


############################################################
# RESET CONSTRAINTS
############################################################

# Asynchronous reset should not be timed
set_false_path \
    -from [get_ports rst_n]


############################################################
# INPUT TIMING
############################################################

# Assume inputs come from synchronous logic in same FPGA

set_input_delay 1.5 -clock sys_clk [get_ports can_rx]
set_input_delay 1.5 -clock sys_clk [get_ports sync_en]
set_input_delay 1.5 -clock sys_clk [get_ports hard_sync]

set_input_delay 1.5 -clock sys_clk [get_ports prescaler]
set_input_delay 1.5 -clock sys_clk [get_ports prop_seg]
set_input_delay 1.5 -clock sys_clk [get_ports phase_seg1]
set_input_delay 1.5 -clock sys_clk [get_ports phase_seg2]
set_input_delay 1.5 -clock sys_clk [get_ports sjw]


############################################################
# OUTPUT TIMING
############################################################

set_output_delay 1.5 -clock sys_clk [get_ports bit_tick]
set_output_delay 1.5 -clock sys_clk [get_ports sample_tick]
set_output_delay 1.5 -clock sys_clk [get_ports tx_tick]
set_output_delay 1.5 -clock sys_clk [get_ports sample_point]

set_output_delay 1.5 -clock sys_clk [get_ports sync_locked]
set_output_delay 1.5 -clock sys_clk [get_ports edge_detected]
set_output_delay 1.5 -clock sys_clk [get_ports sync_active]


############################################################
# MULTICYCLE PATHS
############################################################

# Prescaler introduces multicycle behaviour
# Timing paths through prescaler counters can be relaxed

set_multicycle_path 2 \
    -setup \
    -from [get_registers *prescaler*]

set_multicycle_path 1 \
    -hold \
    -from [get_registers *prescaler*]


############################################################
# OPTIONAL: BIT TIME COUNTER RELAXATION
############################################################

# Bit time counters operate slower than system clock
# Safe multicycle assumption

set_multicycle_path 4 \
    -setup \
    -through [get_registers *tq_counter*]

set_multicycle_path 3 \
    -hold \
    -through [get_registers *tq_counter*]


############################################################
# DESIGN RULE CONSTRAINTS
############################################################

# Limit fanout for timing predictability
set_max_fanout 32 [current_design]

# Transition constraint
set_max_transition 1.0 [current_design]

############################################################
# END
############################################################