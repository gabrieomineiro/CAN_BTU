
//input ports
add mapped point clk clk -type PI PI
add mapped point rst_n rst_n -type PI PI
add mapped point prescaler[7] prescaler[7] -type PI PI
add mapped point prescaler[6] prescaler[6] -type PI PI
add mapped point prescaler[5] prescaler[5] -type PI PI
add mapped point prescaler[4] prescaler[4] -type PI PI
add mapped point prescaler[3] prescaler[3] -type PI PI
add mapped point prescaler[2] prescaler[2] -type PI PI
add mapped point prescaler[1] prescaler[1] -type PI PI
add mapped point prescaler[0] prescaler[0] -type PI PI
add mapped point prop_seg[2] prop_seg[2] -type PI PI
add mapped point prop_seg[1] prop_seg[1] -type PI PI
add mapped point prop_seg[0] prop_seg[0] -type PI PI
add mapped point phase_seg1[2] phase_seg1[2] -type PI PI
add mapped point phase_seg1[1] phase_seg1[1] -type PI PI
add mapped point phase_seg1[0] phase_seg1[0] -type PI PI
add mapped point phase_seg2[2] phase_seg2[2] -type PI PI
add mapped point phase_seg2[1] phase_seg2[1] -type PI PI
add mapped point phase_seg2[0] phase_seg2[0] -type PI PI
add mapped point sjw[1] sjw[1] -type PI PI
add mapped point sjw[0] sjw[0] -type PI PI
add mapped point can_rx can_rx -type PI PI
add mapped point sync_en sync_en -type PI PI
add mapped point hard_sync hard_sync -type PI PI

//output ports
add mapped point bit_tick bit_tick -type PO PO
add mapped point sample_tick sample_tick -type PO PO
add mapped point tx_tick tx_tick -type PO PO
add mapped point sample_point sample_point -type PO PO
add mapped point bit_time_cnt[7] bit_time_cnt[7] -type PO PO
add mapped point bit_time_cnt[6] bit_time_cnt[6] -type PO PO
add mapped point bit_time_cnt[5] bit_time_cnt[5] -type PO PO
add mapped point bit_time_cnt[4] bit_time_cnt[4] -type PO PO
add mapped point bit_time_cnt[3] bit_time_cnt[3] -type PO PO
add mapped point bit_time_cnt[2] bit_time_cnt[2] -type PO PO
add mapped point bit_time_cnt[1] bit_time_cnt[1] -type PO PO
add mapped point bit_time_cnt[0] bit_time_cnt[0] -type PO PO
add mapped point sync_locked sync_locked -type PO PO
add mapped point edge_detected edge_detected -type PO PO
add mapped point sync_active sync_active -type PO PO
add mapped point fsm_state[2] fsm_state[2] -type PO PO
add mapped point fsm_state[1] fsm_state[1] -type PO PO
add mapped point fsm_state[0] fsm_state[0] -type PO PO

//inout ports




//Sequential Pins
add mapped point phase_seg2_adj[3]/q phase_seg2_adj_reg[3]/Q -type DFF DFF
add mapped point phase_seg1_adj[3]/q phase_seg1_adj_reg[3]/Q -type DFF DFF
add mapped point phase_seg2_adj[2]/q phase_seg2_adj_reg[2]/Q -type DFF DFF
add mapped point phase_seg1_adj[2]/q phase_seg1_adj_reg[2]/Q -type DFF DFF
add mapped point phase_seg1_adj[1]/q phase_seg1_adj_reg[1]/Q -type DFF DFF
add mapped point phase_seg2_adj[1]/q phase_seg2_adj_reg[1]/Q -type DFF DFF
add mapped point tq_counter[4]/q tq_counter_reg[4]/Q -type DFF DFF
add mapped point tq_counter[1]/q tq_counter_reg[1]/Q -type DFF DFF
add mapped point tq_counter[3]/q tq_counter_reg[3]/Q -type DFF DFF
add mapped point tq_counter[2]/q tq_counter_reg[2]/Q -type DFF DFF
add mapped point tq_counter[0]/q tq_counter_reg[0]/Q -type DFF DFF
add mapped point phase_seg1_adj[0]/q phase_seg1_adj_reg[0]/Q -type DFF DFF
add mapped point phase_seg2_adj[0]/q phase_seg2_adj_reg[0]/Q -type DFF DFF
add mapped point sample_point/q sample_point_reg/Q -type DFF DFF
add mapped point presc_counter[1]/q presc_counter_reg[1]/Q -type DFF DFF
add mapped point presc_counter[2]/q presc_counter_reg[2]/Q -type DFF DFF
add mapped point presc_counter[4]/q presc_counter_reg[4]/Q -type DFF DFF
add mapped point presc_counter[3]/q presc_counter_reg[3]/Q -type DFF DFF
add mapped point presc_counter[0]/q presc_counter_reg[0]/Q -type DFF DFF
add mapped point sample_tick/q sample_tick_reg/Q -type DFF DFF
add mapped point presc_counter[7]/q presc_counter_reg[7]/Q -type DFF DFF
add mapped point presc_counter[6]/q presc_counter_reg[6]/Q -type DFF DFF
add mapped point presc_counter[5]/q presc_counter_reg[5]/Q -type DFF DFF
add mapped point presc_tick/q presc_tick_reg/Q -type DFF DFF
add mapped point sync_state[0]/q sync_state_reg[0]/Q -type DFF DFF
add mapped point sync_active/q sync_active_reg/Q -type DFF DFF
add mapped point sync_done/q sync_done_reg/Q -type DFF DFF
add mapped point phase_adjusted/q phase_adjusted_reg/Q -type DFF DFF
add mapped point sync_state[1]/q sync_state_reg[1]/Q -type DFF DFF
add mapped point tx_tick/q tx_tick_reg/Q -type DFF DFF
add mapped point bit_tick/q bit_tick_reg/Q -type DFF DFF
add mapped point sync_locked/q sync_locked_reg/Q -type DFF DFF
add mapped point edge_detected_int/q edge_detected_int_reg/Q -type DFF DFF
add mapped point prev_bus_value/q prev_bus_value_reg/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
