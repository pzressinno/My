// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : read_fast_test.sv
// Author        : AiF
// Created On    : 2022-05-15 20:47
// Last Modified : 2022-05-19 17:08
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef READ_FAST_TEST_SV
`define READ_FAST_TEST_SV
class read_fast_test extends asyn_fifo_test_base;
    `uvm_component_utils(read_fast_test)
    extern function new(string name = "read_fast_test",uvm_component parent = null);
    extern task run_phase(uvm_phase phase);
    extern function void build_phase(uvm_phase phase);
endclass : read_fast_test

function read_fast_test::new(string name = "read_fast_test",uvm_component parent = null);
    super.new(name,parent);
endfunction : new

function void read_fast_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction : build_phase

task read_fast_test::run_phase(uvm_phase phase);
    read_fast_vseq vseq = read_fast_vseq::type_id::create("vseq");
    phase.raise_objection(this);
    init_vseq(vseq);
    vseq.start(null);
    phase.drop_objection(this);
endtask : run_phase
`endif // READ_FAST_TEST_SV
