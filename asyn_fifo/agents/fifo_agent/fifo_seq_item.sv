// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : fifo_seq_item.sv
// Author        : AiF
// Created On    : 2022-05-15 16:39
// Last Modified : 2022-05-16 14:03
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef FIFO_SEQ_ITEM_SV
`define FIFO_SEQ_ITEM_SV
class fifo_seq_item extends uvm_sequence_item;
    rand bit [`WIDTH-1:0] data;
    //rand int nums;     //counts of continuously write or read in a time 
    rand int pkt_idles;
    rand bit cmd;      //write '1' or read '0'  
    `uvm_object_utils_begin(fifo_seq_item)
        //`uvm_field_array_int(data,UVM_ALL_ON)
        `uvm_field_int(data,UVM_ALL_ON)
        `uvm_field_int(cmd,UVM_ALL_ON)
        `uvm_field_int(pkt_idles,UVM_ALL_ON)
    `uvm_object_utils_end
    constraint cstr {
            soft pkt_idles == 0;
            //soft nums      inside {[3:10];};
            //data.size()   == nums;
        }
    function new(string name = "fifo_seq_item");
        super.new(name);
    endfunction : new

endclass : fifo_seq_item
`endif //FIFO_SEQ_ITEM_SV 
