// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : asyn_fifo_seq_base.sv
// Author        : AiF
// Created On    : 2022-05-16 15:43
// Last Modified : 2022-05-16 16:15
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef ASYN_FIFO_SEQ_BASE_SV
`define ASYN_FIFO_SEQ_BASE_SV
class asyn_fifo_seq_base extends uvm_sequence #(fifo_seq_item);
    
    asyn_fifo_env_config cfg;
    
    `uvm_object_utils(asyn_fifo_seq_base)
    extern function new(string name = "asyn_fifo_seq_base");
    extern task body();
endclass : asyn_fifo_seq_base

function asyn_fifo_seq_base::new(string name = "asyn_fifo_seq_base");
    super.new(name);
endfunction : new

task asyn_fifo_seq_base::body();
    if(!uvm_config_db#(asyn_fifo_env_config)::get(m_sequencer,"","asyn_fifo_env_config",cfg))
        `uvm_fatal(get_type_name(),"Cant't get the fifo_agent_config!")
endtask : body
`endif // ASYN_FIFO_SEQ_BASE_SV
