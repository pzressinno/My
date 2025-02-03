// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : wrstn_config_seq.sv
// Author        : AiF
// Created On    : 2022-05-16 15:41
// Last Modified : 2022-05-16 23:26
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef WRSTN_CONFIG_SEQ_SV
`define WRSTN_CONFIG_SEQ_SV
class wrstn_config_seq extends asyn_fifo_seq_base;
    `uvm_object_utils(wrstn_config_seq)
    rand bit wrst_test;
    rand int resetn; //reset number
    rand int setn;
    constraint cstr{
            soft   wrst_test == 0;
        }
    extern function new(string name = "wrstn_config_seq");
    extern task body();

endclass : wrstn_config_seq

function wrstn_config_seq::new(string name = "wrstn_config_seq");
    super.new(name);
endfunction : new

task wrstn_config_seq::body();
    super.body();
    //void'(this.randomize());
    fork
        if(wrst_test)
            begin
            //`uvm_info("DEBUG","Start wrst_n assgin",UVM_MEDIUM)
            cfg.m_wf_cfg.FIFO.wrst_n = 0;
            repeat(resetn*2) begin
                @(posedge cfg.m_wf_cfg.FIFO.wclk);
			end

            cfg.m_wf_cfg.FIFO.wrst_n = 1;
            repeat(setn*5) begin
                @(posedge cfg.m_wf_cfg.FIFO.wclk);
			end
            cfg.m_wf_cfg.FIFO.wrst_n = 0;
            repeat(resetn*3) begin
                @(posedge cfg.m_wf_cfg.FIFO.wclk);
			end
            cfg.m_wf_cfg.FIFO.wrst_n = 1;
            repeat(setn*5) begin
                @(posedge cfg.m_wf_cfg.FIFO.wclk);
			end

            cfg.m_wf_cfg.FIFO.wrst_n = 0;
            repeat(resetn*2) begin
                @(posedge cfg.m_wf_cfg.FIFO.wclk);
			end

            cfg.m_wf_cfg.FIFO.wrst_n = 1;
            end
        else begin
            cfg.m_wf_cfg.FIFO.wrst_n = 0;
            repeat(5)
                @(cfg.m_rf_cfg.FIFO.wclk);
            cfg.m_wf_cfg.FIFO.wrst_n = 1;
             end
    join_none
endtask : body

`endif // wrstn_config_seq_SV
