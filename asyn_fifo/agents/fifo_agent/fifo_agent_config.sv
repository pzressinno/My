// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : fifo_agent_config.sv
// Author        : AiF
// Created On    : 2022-05-15 18:59
// Last Modified : 2022-05-16 22:30
// ---------------------------------------------------------------------------------
// Description   : 
//                  Has some configures of agent : function or syntax
//
// ---------------------------------------------------------------------------------
`ifndef FIFO_AGENT_CONFIG_SV
`define FIFO_AGENT_CONFIG_SV
class fifo_agent_config extends uvm_object;
    `uvm_object_utils(fifo_agent_config)
    virtual fifo_if FIFO;
    bit is_active = 1;
    bit cmd;
    real rclk_half_period = 10;

    extern function new(string name);
endclass : fifo_agent_config
function fifo_agent_config::new(string name = "fifo_agent_config");
    super.new(name);
endfunction : new
`endif // FIFO_AGENT_CONFIG_SV
