// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : asyn_fifo_test_base.sv
// Author        : AiF
// Created On    : 2022-05-15 19:26
// Last Modified : 2022-05-16 20:30
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef ASYN_FIFO_TEST_BASE_SV
`define ASYN_FIFO_TEST_BASE_SV
class asyn_fifo_test_base extends uvm_test;
    `uvm_component_utils(asyn_fifo_test_base)
    fifo_agent_config  m_wf_cfg;
    fifo_agent_config  m_rf_cfg;
    asyn_fifo_env        m_env;
    asyn_fifo_env_config m_env_cfg;
    
    extern function new(string name,uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void init_vseq(asyn_fifo_vseq_base vseq);
endclass : asyn_fifo_test_base

function asyn_fifo_test_base::new(string name = "asyn_fifo_test_base",uvm_component parent = null);
    super.new(name,parent);
endfunction : new

function void asyn_fifo_test_base::build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_env    = asyn_fifo_env::type_id::create("m_env",this);
    m_wf_cfg = fifo_agent_config::type_id::create("m_wf_cfg");
    m_rf_cfg = fifo_agent_config::type_id::create("m_rf_cfg");
    m_wf_cfg.is_active = 1;
    m_wf_cfg.cmd       = 1;
    m_rf_cfg.is_active = 1;
    m_rf_cfg.cmd       = 0;

    if(!uvm_config_db#(virtual fifo_if)::get(this,"","w_fifo_if",m_wf_cfg.FIFO))
        `uvm_fatal(get_type_name(),"Can't get the w_fifo_if from uvm_root")
    if(!uvm_config_db#(virtual fifo_if)::get(this,"","r_fifo_if",m_rf_cfg.FIFO))
        `uvm_fatal(get_type_name(),"Can't get the w_fifo_if from uvm_root")

    m_env_cfg = asyn_fifo_env_config::type_id::create("m_env_cfg");
    m_env_cfg.m_wf_cfg = m_wf_cfg;
    m_env_cfg.m_rf_cfg = m_rf_cfg;
 //   `uvm_info("DEBUG","has cfg",UVM_MEDIUM)
    uvm_config_db#(asyn_fifo_env_config)::set(this,"m_env*","asyn_fifo_env_config",m_env_cfg);
endfunction : build_phase

function void asyn_fifo_test_base::init_vseq(asyn_fifo_vseq_base vseq);
    vseq.wf_sqr = m_env.m_wf_agent.m_sequencer;
    vseq.rf_sqr = m_env.m_rf_agent.m_sequencer;
    vseq.env_cfg = m_env_cfg;

endfunction : init_vseq
`endif // ASYN_FIFO_TEST_BASE_SV
