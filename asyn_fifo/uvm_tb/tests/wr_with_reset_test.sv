// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : wr_with_reset_test.sv
// Author        : AiF
// Created On    : 2022-05-18 22:40
// Last Modified : 2022-05-18 22:42
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef WR_WITH_RESET_TEST_SV
`define WR_WITH_RESET_TEST_SV
class wr_with_reset_test extends asyn_fifo_test_base;
    `uvm_component_utils(wr_with_reset_test)
    extern function new(string name = "wr_with_reset_test",uvm_component parent = null);
    extern task run_phase(uvm_phase phase);
    extern function void build_phase(uvm_phase phase);
endclass : wr_with_reset_test

function wr_with_reset_test::new(string name = "wr_with_reset_test",uvm_component parent = null);
    super.new(name,parent);
endfunction : new

function void wr_with_reset_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction : build_phase

task wr_with_reset_test::run_phase(uvm_phase phase);
    wr_with_reset_vseq vseq = wr_with_reset_vseq::type_id::create("vseq");
    phase.raise_objection(this);
    init_vseq(vseq);
    vseq.start(null);
    phase.drop_objection(this);
endtask : run_phase
`endif // WR_WITH_RESET_TEST_SV
