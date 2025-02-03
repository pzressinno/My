// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : asyn_fifo_vseq_pkg.sv
// Author        : AiF
// Created On    : 2022-05-15 20:37
// Last Modified : 2022-05-19 18:21
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef ASYN_FIFO_VSEQ_PKG_SV
`define ASYN_FIFO_VSEQ_PKG_SV
package asyn_fifo_vseq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    import fifo_agent_pkg::*;
    import asyn_fifo_env_pkg::*;
    import asyn_fifo_seq_pkg::*;
    `include "asyn_fifo_vseq_base.sv"

    `include "wr_with_reset_vseq.sv"
    `include "write_fast_vseq.sv"
    `include "read_fast_vseq.sv"
endpackage : asyn_fifo_vseq_pkg
`endif //ASYN_FIFO_VSEQ_PKG_SV
