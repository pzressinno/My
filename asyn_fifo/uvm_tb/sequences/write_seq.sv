// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : write_seq.sv
// Author        : AiF
// Created On    : 2022-05-15 21:04
// Last Modified : 2022-05-19 14:13
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef WRITE_SEQ_SV
`define WRITE_SEQ_SV
class write_seq extends uvm_sequence #(fifo_seq_item);
    `uvm_object_utils(write_seq)
    rand int pkt_idles;

    constraint cstr {
          soft  pkt_idles == 0;
        }
    extern function new(string name);
    extern task body();
endclass : write_seq

function write_seq::new(string name = "write_seq");
    super.new(name);
endfunction : new

task write_seq::body();
    fifo_seq_item req;
    `uvm_do_with(req,{cmd == 1;pkt_idles == local::pkt_idles;})
endtask : body
`endif // WRITE_SEQ_SV
