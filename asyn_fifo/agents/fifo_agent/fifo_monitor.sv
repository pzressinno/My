// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : fifo_monitor.sv
// Author        : AiF
// Created On    : 2022-05-15 17:03
// Last Modified : 2022-05-18 22:00
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef FIFO_MONITOR_SV
`define FIFO_MONITOR_SV
class fifo_monitor extends uvm_monitor ;
    `uvm_component_utils(fifo_monitor)
    virtual fifo_if FIFO;
    uvm_analysis_port #(fifo_seq_item) ap;
    fifo_agent_config cfg;

    extern function new(string name = "fifo_monitor",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task collect_one_pkt(fifo_seq_item req);

endclass : fifo_monitor

function fifo_monitor::new(string name = "fifo_monitor",uvm_component parent);
    super.new(name,parent);
    ap = new("ap",this);
endfunction : new

function void fifo_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(fifo_agent_config)::get(this,"","fifo_agent_config",cfg))
        `uvm_fatal(get_type_name(),"Can't get the fifo_agent_config!")
endfunction : build_phase

task fifo_monitor::run_phase(uvm_phase phase);
    fifo_seq_item mon_item = fifo_seq_item::type_id::create("mon_item");
    fifo_seq_item mon_item_cloned;

        fork

            forever 
                if(cfg.cmd)
                    begin
                    @(FIFO.mon_wr_cb iff FIFO.mon_wr_cb.winc == 1 && !FIFO.mon_wr_cb.wfull); 
                        mon_item.data = FIFO.mon_wr_cb.wdata;
                        mon_item.cmd  = 1;
                        void'($cast(mon_item_cloned,mon_item.clone()));
                        ap.write(mon_item);
                    end
                else begin
                    @(FIFO.mon_rd_cb iff FIFO.mon_rd_cb.rinc == 1 && !FIFO.mon_rd_cb.rempty); 
                        #1
                        mon_item.data = FIFO.rdata;
                        mon_item.cmd  = 0;
                        void'($cast(mon_item_cloned,mon_item.clone()));
                        ap.write(mon_item);
                    end
        join_none
endtask : run_phase
`endif //FIFO_MONITOR_SV
