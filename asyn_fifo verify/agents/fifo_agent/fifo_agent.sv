// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : fifo_agent.sv
// Author        : AiF
// Created On    : 2022-05-15 18:35
// Last Modified : 2022-05-16 13:33
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef FIFO_AGENT_SV
`define FIFO_AGENT_SV
class fifo_agent extends uvm_component;
    `uvm_component_utils(fifo_agent)
    fifo_driver       m_driver;
    fifo_sequencer    m_sequencer;
    fifo_monitor      m_monitor;
    fifo_agent_config m_cfg;
    uvm_analysis_port   #(fifo_seq_item) ap;

    extern function new(string name,uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass : fifo_agent 

function fifo_agent::new(string name = "fifo_agent",uvm_component parent);
    super.new(name,parent);
    ap = new("ap",this);
endfunction : new

function void fifo_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(fifo_agent_config)::get(this,"","fifo_agent_config",m_cfg))
        `uvm_fatal(get_type_name(),"Can't get the fifo_agent_config!")
    m_monitor   = fifo_monitor::type_id::create("m_monitor",this);

    if(m_cfg.is_active) begin
        m_driver    = fifo_driver::type_id::create("m_driver",this);
        m_sequencer = fifo_sequencer::type_id::create("m_sequencer",this);
    end
endfunction : build_phase

function void fifo_agent::connect_phase(uvm_phase phase);
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    ap = m_monitor.ap;
    m_driver.FIFO  = m_cfg.FIFO;
    m_monitor.FIFO = m_cfg.FIFO;
endfunction : connect_phase
`endif // FIFO_AGENT_SV
