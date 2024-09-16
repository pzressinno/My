// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : write_agent_pkg.sv
// Author        : AiF
// Created On    : 2022-05-15 16:28
// Last Modified : 2022-05-16 21:21
// ---------------------------------------------------------------------------------
// Description   : 
//                  the agent related to the write the fifo 
//  
// ---------------------------------------------------------------------------------
`ifndef FIFO_AGENT_PKG_SV
`define FIFO_AGENT_PKG_SV
package fifo_agent_pkg;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "fifo_seq_item.sv"
    typedef uvm_sequencer#(fifo_seq_item) fifo_sequencer;
    `include "fifo_agent_config.sv"
    `include "fifo_driver.sv"
    `include "fifo_monitor.sv"
    `include "fifo_agent.sv"
endpackage : fifo_agent_pkg

`endif //fifo_agent_pkg
