// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : asyn_fifo_test_pkg.sv
// Author        : AiF
// Created On    : 2022-05-15 19:24
// Last Modified : 2022-05-19 18:22
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef ASYN_FIFO_TEST_PKG_SV
`define ASYN_FIFO_TEST_PKG_SV
package asyn_fifo_test_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    import fifo_agent_pkg::*;
    import asyn_fifo_env_pkg::*;
    import asyn_fifo_vseq_pkg::*;
    `include "asyn_fifo_test_base.sv"

    `include "wr_with_reset_test.sv"
    `include "write_fast_test.sv"
    `include "read_fast_test.sv"
endpackage : asyn_fifo_test_pkg
`endif // ASYN_FIFO_TEST_PKG_SV
