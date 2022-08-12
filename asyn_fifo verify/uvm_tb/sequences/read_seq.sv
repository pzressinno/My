// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : read_seq.sv
// Author        : AiF
// Created On    : 2022-05-15 21:04
// Last Modified : 2022-05-16 22:33
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef READ_SEQ_SV
`define READ_SEQ_SV
class read_seq extends uvm_sequence #(fifo_seq_item);
    `uvm_object_utils(read_seq)

    extern function new(string name);
    extern task body();
endclass : read_seq

function read_seq::new(string name = "read_seq");
    super.new(name);
endfunction : new

task read_seq::body();
    fifo_seq_item req;
    `uvm_do_with(req,{cmd == 0;})
endtask : body
`endif // READ_SEQ_SV
