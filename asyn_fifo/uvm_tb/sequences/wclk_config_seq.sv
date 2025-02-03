// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : wclk_config_seq.sv
// Author        : AiF
// Created On    : 2022-05-16 10:34
// Last Modified : 2022-05-19 11:32
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef WCLK_CONFIG_SEQ_SV
`define WCLK_CONFIG_SEQ_SV
class wclk_config_seq extends uvm_sequence;
    `uvm_object_utils(wclk_config_seq)
    rand int wclk_half_period;
    extern function new(string name = "wclk_config_seq");
    extern task body();

endclass : wclk_config_seq

function wclk_config_seq::new(string name = "wclk_config_seq");
    super.new(name);
endfunction : new

task wclk_config_seq::body();
    uvm_config_db#(int)::set(m_sequencer,"","wclk_half_period",wclk_half_period);
    `uvm_info("WCLK",$sformatf("Configure the wclk half period = [%0d]",wclk_half_period),UVM_MEDIUM)
endtask : body

`endif // WCLK_CONFIG_SEQ_SV
