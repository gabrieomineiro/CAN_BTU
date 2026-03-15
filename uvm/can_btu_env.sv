//==================================================
// Environment for CAN BTU
//==================================================
class can_btu_env extends uvm_env;
    `uvm_component_utils(can_btu_env)
    
    can_btu_agent      agt;
    can_btu_scoreboard scb;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        agt = can_btu_agent::type_id::create("agt", this);
        scb = can_btu_scoreboard::type_id::create("scb", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        // Connect agent monitor to scoreboard
        agt.agent_ap.connect(scb.monitor_export);
    endfunction
endclass