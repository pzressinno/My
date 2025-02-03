// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : rclk_config_seq.sv
// Author        : AiF
// Created On    : 2022-05-16 10:34
// Last Modified : 2022-05-19 11:30
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef RCLK_CONFIG_SEQ_SV
`define RCLK_CONFIG_SEQ_SV
class rclk_config_seq extends uvm_sequence;
    `uvm_object_utils(rclk_config_seq)
    rand int rclk_half_period;
    extern function new(string name = "rclk_config_seq");
    extern task body();

endclass : rclk_config_seq

function rclk_config_seq::new(string name = "rclk_config_seq");
    super.new(name);
endfunction : new

task rclk_config_seq::body();
    uvm_config_db#(int)::set(m_sequencer,"","rclk_half_period",rclk_half_period);
    `uvm_info("rclk",$sformatf("Configure the rclk half period = [%0d]",rclk_half_period),UVM_MEDIUM)
endtask : body

`endif // rclk_CONFIG_SEQ_SV
