// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : write_read_test.sv
// Author        : AiF
// Created On    : 2022-05-15 20:47
// Last Modified : 2022-05-16 23:54
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef WRITE_READ_TEST_SV
`define WRITE_READ_TEST_SV
class write_read_test extends asyn_fifo_test_base;
    `uvm_component_utils(write_read_test)
    extern function new(string name = "write_read_test",uvm_component parent = null);
    extern task run_phase(uvm_phase phase);
    extern function void build_phase(uvm_phase phase);
endclass : write_read_test

function write_read_test::new(string name = "write_read_test",uvm_component parent = null);
    super.new(name,parent);
endfunction : new

function void write_read_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    //uvm_config_db#(real)::set(this,"","wclk_half_period",wclk_half_period); 
endfunction : build_phase

task write_read_test::run_phase(uvm_phase phase);
    write_read_vseq vseq = write_read_vseq::type_id::create("vseq");
    phase.raise_objection(this);
    init_vseq(vseq);
    vseq.start(null);
    phase.drop_objection(this);
endtask : run_phase
`endif // write_read_test_SV
