// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : asyn_fifo_vseq_base.sv
// Author        : AiF
// Created On    : 2022-05-15 20:42
// Last Modified : 2022-05-16 13:44
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef ASYN_FIFO_VSEQ_BASE_SV
`define ASYN_FIFO_VSEQ_BASE_SV
class asyn_fifo_vseq_base extends uvm_sequence;
    `uvm_object_utils(asyn_fifo_vseq_base)
    asyn_fifo_env_config env_cfg;   
    fifo_sequencer     wf_sqr;
    fifo_sequencer     rf_sqr;
    function new(string name = "asyn_fifo_vseq_base");
        super.new(name);
    endfunction : new
endclass : asyn_fifo_vseq_base
`endif //ASYN_FIFO_VSEQ_BASE_SV
