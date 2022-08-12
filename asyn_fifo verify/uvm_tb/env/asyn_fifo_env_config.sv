// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : asyn_fifo_env_config.sv
// Author        : AiF
// Created On    : 2022-05-15 19:09
// Last Modified : 2022-05-19 18:36
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef ASYN_FIFO_ENV_CONFIG_SV
`define ASYN_FIFO_ENV_CONFIG_SV
class asyn_fifo_env_config extends uvm_object;
    `uvm_object_utils(asyn_fifo_env_config)
    fifo_agent_config m_wf_cfg; // write fifo config
    fifo_agent_config m_rf_cfg; // write fifo config
    
    extern function new(string name = "asyn_fifo_env_config");
    extern task wait_for_wclk(int n);
    extern task wait_for_rclk(int n);    //wait n cycles of clk
endclass : asyn_fifo_env_config
function asyn_fifo_env_config::new(string name = "asyn_fifo_env_config");
    super.new(name);
endfunction : new

task asyn_fifo_env_config::wait_for_wclk(int n);
    repeat(n)
        @(posedge m_wf_cfg.FIFO.wclk);
endtask : wait_for_wclk
task asyn_fifo_env_config::wait_for_rclk(int n);
    repeat(n)
        @(posedge m_rf_cfg.FIFO.rclk);
endtask : wait_for_rclk
`endif // ASYN_FIFO_ENV_CONFIG_SV
