// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : rrstn_seq.sv
// Author        : AiF
// Created On    : 2022-05-18 22:33
// Last Modified : 2022-05-18 22:39
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef RRSTN_SEQ_SV
`define RRSTN_SEQ_SV
class rrstn_seq extends asyn_fifo_seq_base;
    `uvm_object_utils(rrstn_seq)
    rand int cycle;

    extern function new(string name = "rrstn_seq");
    extern task body();

endclass : rrstn_seq

function rrstn_seq::new(string name = "rrstn_seq");
    super.new(name);
endfunction : new

task rrstn_seq::body();
    super.body();
	cfg.m_rf_cfg.FIFO.rrst_n = 0;
	repeat(cycle)
	    @(posedge cfg.m_rf_cfg.FIFO.rclk);
	cfg.m_rf_cfg.FIFO.rrst_n = 1;

endtask : body

`endif // RRSTN_SEQ_SV
