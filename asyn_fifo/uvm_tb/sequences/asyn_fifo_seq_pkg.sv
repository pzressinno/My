// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : asyn_fifo_seq_pkg.sv
// Author        : AiF
// Created On    : 2022-05-15 21:01
// Last Modified : 2022-05-19 11:32
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef ASYN_FIFO_SEQ_PKG_SV
`define ASYN_FIFO_SEQ_PKG_SV
package asyn_fifo_seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import asyn_fifo_env_pkg::*;
    import fifo_agent_pkg::*;
    `include "write_seq.sv"
    `include "read_seq.sv"
    `include "wclk_config_seq.sv"
    `include "rclk_config_seq.sv"
    `include "asyn_fifo_seq_base.sv"
    `include "wrstn_config_seq.sv"
    `include "rrstn_config_seq.sv"

    `include "wrstn_seq.sv"
    `include "rrstn_seq.sv"
endpackage : asyn_fifo_seq_pkg
`endif // ASYN_FIFO_SEQ_PKG
