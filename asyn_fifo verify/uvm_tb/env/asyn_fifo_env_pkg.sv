// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : asyn_fifo_env_pkg.sv
// Author        : AiF
// Created On    : 2022-05-15 19:06
// Last Modified : 2022-05-18 22:19
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef ASYN_FIFO_ENV_PKG_SV
`define ASYN_FIFO_ENV_PKG_SV
package asyn_fifo_env_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    import fifo_agent_pkg::*;

    `include "asyn_fifo_env_config.sv"
    `include "read_write_scoreboard.sv"
    `include "asyn_fifo_env.sv"
endpackage : asyn_fifo_env_pkg
`endif // ASYN_FIFO_ENV_PKG_SV
