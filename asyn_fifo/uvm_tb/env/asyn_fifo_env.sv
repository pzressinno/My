// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : asyn_fifo_env.sv
// Author        : AiF
// Created On    : 2022-05-15 20:27
// Last Modified : 2022-05-18 22:20
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef ASYN_FIFO_ENV_SV
`define ASYN_FIFO_ENV_SV
class asyn_fifo_env extends uvm_component;
    `uvm_component_utils(asyn_fifo_env)
    fifo_agent            m_wf_agent; //write fifo agent
    fifo_agent            m_rf_agent; //read fifo agent
    asyn_fifo_env_config  m_env_cfg;
    
    read_write_scoreboard scb;
    extern function new(string name,uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass : asyn_fifo_env    
function asyn_fifo_env::new(string name = "asyn_fifo_env",uvm_component parent);
    super.new(name,parent);
endfunction : new

function void asyn_fifo_env::build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_wf_agent = fifo_agent::type_id::create("m_wf_agent",this);
    m_rf_agent = fifo_agent::type_id::create("m_rf_agent",this);
    scb        = read_write_scoreboard::type_id::create("scb",this);
    if(!uvm_config_db#(asyn_fifo_env_config)::get(this,"","asyn_fifo_env_config",m_env_cfg))
        `uvm_fatal(get_type_name(),"Can't get tje asyn_fifo_env_config!")
    uvm_config_db#(fifo_agent_config)::set(this,"m_wf_agent*","fifo_agent_config",m_env_cfg.m_wf_cfg);
    uvm_config_db#(fifo_agent_config)::set(this,"m_rf_agent*","fifo_agent_config",m_env_cfg.m_rf_cfg);
    
    uvm_config_db#(asyn_fifo_env_config)::set(this,"scb","asyn_fifo_env_config",m_env_cfg);
endfunction : build_phase

function void asyn_fifo_env::connect_phase(uvm_phase phase);
    m_wf_agent.m_monitor.ap.connect(scb.write_fifo.analysis_export);
    m_rf_agent.m_monitor.ap.connect(scb.read_fifo.analysis_export);
endfunction : connect_phase
`endif // ASYN_FIFO_ENV_SV
