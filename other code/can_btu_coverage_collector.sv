//============================================================
// Coverage Collector for CAN Bit Timing Unit (BTU)
//============================================================

`ifndef CAN_BTU_COV_SV
`define CAN_BTU_COV_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

// ------------------------------------------------------------
// Coverage Collector
// ------------------------------------------------------------
class can_btu_coverage extends uvm_component;

  `uvm_component_utils(can_btu_coverage)

  // Analysis port to receive transactions from monitor
  uvm_analysis_imp #(can_btu_seq_item, can_btu_coverage) analysis_export;

  // ----------------------------------------------------------
  // Covergroup
  // ----------------------------------------------------------
  covergroup btu_cg with function sample(can_btu_seq_item item);

    option.per_instance = 1;

    // -----------------------------
    // CONFIGURATION COVERAGE
    // -----------------------------

    cp_prescaler : coverpoint item.prescaler {
      bins low   = {[1:10]};
      bins mid   = {[11:100]};
      bins high  = {[101:256]};
    }

    cp_prop_seg : coverpoint item.prop_seg {
      bins valid[] = {[1:8]};
    }

    cp_phase_seg1 : coverpoint item.phase_seg1 {
      bins valid[] = {[1:8]};
    }

    cp_phase_seg2 : coverpoint item.phase_seg2 {
      bins valid[] = {[2:8]};
    }

    cp_sjw : coverpoint item.sjw {
      bins valid[] = {[1:4]};
    }

    // -----------------------------
    // DERIVED VALUES (FUNCTION-BASED)
    // -----------------------------

    cp_total_tq : coverpoint item.get_total_tq() {
      bins pequeno = {[3:8]};
      bins mid   = {[9:16]};
      bins grande = {[17:25]};
    }

    cp_sample_tq : coverpoint item.get_sample_tq() {
      bins early = {[2:6]};
      bins mid   = {[7:12]};
      bins late  = {[13:20]};
    }

    // -----------------------------
    // INPUT SIGNALS
    // -----------------------------

    cp_can_rx : coverpoint item.can_rx {
      bins dominant  = {0};
      bins recessive = {1};
    }

    cp_sync_en : coverpoint item.sync_en;
    cp_hard_sync : coverpoint item.hard_sync;

    // -----------------------------
    // OUTPUT / MONITORED SIGNALS
    // -----------------------------

    cp_bit_tick : coverpoint item.bit_tick;
    cp_sample_tick : coverpoint item.sample_tick;
    cp_tx_tick : coverpoint item.tx_tick;

    cp_sample_point : coverpoint item.sample_point;

    cp_bit_time_cnt : coverpoint item.bit_time_cnt {
      bins start = {[0:3]};
      bins mid   = {[4:15]};
      bins ultimo   = {[16:255]};
    }

    cp_sync_locked : coverpoint item.sync_locked;
    cp_edge_detected : coverpoint item.edge_detected;
    cp_sync_active : coverpoint item.sync_active;

    // -----------------------------
    // CROSS COVERAGE (IMPORTANT)
    // -----------------------------

    // Configuration consistency
    cross_cfg : cross cp_prop_seg, cp_phase_seg1, cp_phase_seg2, cp_sjw;

    // Sample point correctness
    cross_sample : cross cp_sample_point, cp_sample_tick;

    // Sync behavior
    cross_sync : cross cp_sync_en, cp_hard_sync, cp_sync_active;

    // RX vs edge detection
    cross_rx_edge : cross cp_can_rx, cp_edge_detected;

    // Timing vs sample point
    cross_timing_sample : cross cp_sample_tq, cp_bit_time_cnt;

  endgroup

  // ----------------------------------------------------------
  // Constructor
  // ----------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_export = new("analysis_export", this);
    btu_cg = new();
  endfunction

  // ----------------------------------------------------------
  // Write function (called by monitor)
  // ----------------------------------------------------------
  function void write(can_btu_seq_item t);
    btu_cg.sample(t);
  endfunction

endclass

`endif

