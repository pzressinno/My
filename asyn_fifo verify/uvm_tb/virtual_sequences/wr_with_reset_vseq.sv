// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : wr_with_reset_vseq.sv
// Author        : AiF
// Created On    : 2022-05-15 20:54
// Last Modified : 2022-05-19 19:07
// ---------------------------------------------------------------------------------
// Description   : 
//                 write and read fifo
//                 during work,rest the fifo    
//                 check the unusual status
// ---------------------------------------------------------------------------------
`ifndef WR_WITH_RESET_VSEQ_SV
`define WR_WITH_RESET_VSEQ_SV
class wr_with_reset_vseq extends asyn_fifo_vseq_base;
    `uvm_object_utils(wr_with_reset_vseq)
    extern function new(string name);
    extern task body();
endclass : wr_with_reset_vseq

function wr_with_reset_vseq::new(string name = "wr_with_reset_vseq");
    super.new(name);
endfunction : new

task wr_with_reset_vseq::body();
    write_seq        wr_seq;
    read_seq         rd_seq;
    wrstn_config_seq wrstn_cfg_seq;
    rrstn_config_seq rrstn_cfg_seq;
    
    wrstn_seq        wrstn_seq;
    rrstn_seq        rrstn_seq;

    fork
        `uvm_do_on(wrstn_cfg_seq,wf_sqr)
        `uvm_do_on(rrstn_cfg_seq,rf_sqr)
    join_none
    
    // Continuously write 20 datas
    repeat(20)
        `uvm_do_on(wr_seq,wf_sqr)
    
    env_cfg.wait_for_wclk(5);
    
    // Continuously read  20 datas
    repeat(20)
        `uvm_do_on(rd_seq,rf_sqr)
    env_cfg.wait_for_rclk(5);

    fork
        repeat(50)
            `uvm_do_on(wr_seq,wf_sqr)
        repeat(50)
            `uvm_do_on(rd_seq,rf_sqr)
        begin #200 `uvm_do_on_with(wrstn_cfg_seq,wf_sqr,{resetn == 5;wrst_en == 1;}) end
        begin #200 `uvm_do_on_with(rrstn_cfg_seq,rf_sqr,{resetn == 5;rrst_en == 1;}) end
    join    
    env_cfg.wait_for_wclk(10);
endtask : body
`endif // WR_WITH_RESET_VSEQ_SV 
