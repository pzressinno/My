// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : wrstn_seq.sv
// Author        : AiF
// Created On    : 2022-05-18 22:33
// Last Modified : 2022-05-18 22:37
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef WRSTN_SEQ_SV
`define WRSTN_SEQ_SV
class wrstn_seq extends asyn_fifo_seq_base;
    `uvm_object_utils(wrstn_seq)
    rand int cycle;

    extern function new(string name = "wrstn_seq");
    extern task body();

endclass : wrstn_seq

function wrstn_seq::new(string name = "wrstn_seq");
    super.new(name);
endfunction : new

task wrstn_seq::body();
    super.body();
	cfg.m_wf_cfg.FIFO.wrst_n = 0;
	repeat(cycle)
	    @(posedge cfg.m_wf_cfg.FIFO.wclk);
	cfg.m_wf_cfg.FIFO.wrst_n = 1;

endtask : body

`endif // WRSTN_SEQ_SV
