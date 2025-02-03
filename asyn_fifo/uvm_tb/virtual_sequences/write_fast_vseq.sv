// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : write_fast_vseq.sv
// Author        : AiF
// Created On    : 2022-05-19 11:14
// Last Modified : 2022-05-19 16:53
// ---------------------------------------------------------------------------------
// Description   : 
//                  
//                  
// ---------------------------------------------------------------------------------
`ifndef WRITE_FAST_VSEQ_SV
`define WRITE_FAST_VSEQ_SV
class write_fast_vseq extends asyn_fifo_vseq_base;
    `uvm_object_utils(write_fast_vseq)
    int wclk_half_period = 10;
    int factor = 7;            
    extern function new(string name);
    extern task body();
endclass : write_fast_vseq

function write_fast_vseq::new(string name = "write_fast_vseq");
    super.new(name);
endfunction : new

task write_fast_vseq::body();
    write_seq        wr_seq;
    read_seq         rd_seq;
    wrstn_config_seq wrstn_cfg_seq;
    rrstn_config_seq rrstn_cfg_seq;
    wclk_config_seq  wclk_cfg_seq;
    rclk_config_seq  rclk_cfg_seq;
    fork
        `uvm_do_on(wrstn_cfg_seq,wf_sqr)
        `uvm_do_on(rrstn_cfg_seq,rf_sqr)
        `uvm_do_on_with(wclk_cfg_seq,wf_sqr,{wclk_half_period == local::wclk_half_period;})
        `uvm_do_on_with(rclk_cfg_seq,rf_sqr,{rclk_half_period == local::wclk_half_period*factor; })
    join_none
    

    repeat(5)
        `uvm_do_on(wr_seq,wf_sqr)
    #50
    repeat(5)
        `uvm_do_on(rd_seq,rf_sqr)
    #100    
    fork
             repeat(100)
            `uvm_do_on_with(wr_seq,wf_sqr,{pkt_idles == 0;})
        repeat(100)
            `uvm_do_on(rd_seq,rf_sqr)
    join    
    #500;
endtask : body
`endif // write_fast_VSEQ_SV 
