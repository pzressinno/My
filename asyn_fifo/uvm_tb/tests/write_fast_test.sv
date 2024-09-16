// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : write_fast_test.sv
// Author        : AiF
// Created On    : 2022-05-15 20:47
// Last Modified : 2022-05-19 11:27
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef WRITE_FAST_TEST_SV
`define WRITE_FAST_TEST_SV
class write_fast_test extends asyn_fifo_test_base;
    `uvm_component_utils(write_fast_test)
    extern function new(string name = "write_fast_test",uvm_component parent = null);
    extern task run_phase(uvm_phase phase);
    extern function void build_phase(uvm_phase phase);
endclass : write_fast_test

function write_fast_test::new(string name = "write_fast_test",uvm_component parent = null);
    super.new(name,parent);
endfunction : new

function void write_fast_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction : build_phase

task write_fast_test::run_phase(uvm_phase phase);
    write_fast_vseq vseq = write_fast_vseq::type_id::create("vseq");
    phase.raise_objection(this);
    init_vseq(vseq);
    vseq.start(null);
    phase.drop_objection(this);
endtask : run_phase
`endif // write_fast_test_SV
