// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : read_fast_vseq.sv
// Author        : AiF
// Created On    : 2022-05-19 11:14
// Last Modified : 2022-05-19 17:38
// ---------------------------------------------------------------------------------
// Description   : 
//                  
//                  
// ---------------------------------------------------------------------------------
`ifndef READ_FAST_VSEQ_SV
`define READ_FAST_VSEQ_SV
class read_fast_vseq extends asyn_fifo_vseq_base;
    `uvm_object_utils(read_fast_vseq)
    int rclk_half_period = 10;
    int factor = 3;            
    extern function new(string name);
    extern task body();
endclass : read_fast_vseq

function read_fast_vseq::new(string name = "read_fast_vseq");
    super.new(name);
endfunction : new

task read_fast_vseq::body();
    write_seq        wr_seq;
    read_seq         rd_seq;
    wrstn_config_seq wrstn_cfg_seq;
    rrstn_config_seq rrstn_cfg_seq;
    wclk_config_seq  wclk_cfg_seq;
    rclk_config_seq  rclk_cfg_seq;
    fork
        `uvm_do_on(wrstn_cfg_seq,wf_sqr)
        `uvm_do_on(rrstn_cfg_seq,rf_sqr)
        `uvm_do_on_with(rclk_cfg_seq,rf_sqr,{rclk_half_period == local::rclk_half_period;})
        `uvm_do_on_with(wclk_cfg_seq,wf_sqr,{wclk_half_period == local::rclk_half_period*factor; })
    join_none
    
    fork
        repeat(50)
            `uvm_do_on(wr_seq,wf_sqr)
        begin   
            #800
            repeat(100)
            `uvm_do_on(rd_seq,rf_sqr)
        end
    join
    #500;
endtask : body
`endif // READ_FAST_VSEQ_SV 
