############################################################
# CAN BTU Build Script
############################################################

# Project parameters
set PROJ_NAME can_btu_top
set TOP_MODULE can_btu_top
set DEVICE GW2AR-LV18QN88C8/I7

set RTL_DIR ../rtl
set CONSTR_DIR ../constraints
set BUILD_DIR ../build

############################################################
# Create project
############################################################

create_project $PROJ_NAME $BUILD_DIR -part $DEVICE

############################################################
# Add RTL
############################################################

add_file -type systemverilog $RTL_DIR/can_btu_top.sv
add_file -type systemverilog $RTL_DIR/can_btu_defines.svh

############################################################
# Constraints
############################################################

add_file -type sdc $CONSTR_DIR/can_btu_top.sdc
#add_file -type sdc $CONSTR_DIR/CAN_BTU_GPT.sdc

############################################################
# Top module
############################################################

set_option -top_module $TOP_MODULE

############################################################
# Synthesis options
############################################################

set_option -verilog_std sysv
set_option -optimize_area 0
set_option -optimize_speed 1

############################################################
# Run flow
############################################################

puts "Running synthesis..."
run syn

puts "Running place and route..."
run pnr

puts "Generating bitstream..."
run bitstream

puts "--------------------------------------"
puts "CAN BTU build completed"
puts "--------------------------------------"