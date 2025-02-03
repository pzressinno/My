// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : read_write_scoreboard.sv
// Author        : AiF
// Created On    : 2022-05-17 11:31
// Last Modified : 2022-05-18 22:58
// ---------------------------------------------------------------------------------
// Description   : v0.0 2022-05-17 11:31
//                      2022-05-17 12:13
//                 v1.0 2022-05-18 22 add the reset
// ---------------------------------------------------------------------------------
`ifndef READ_WRITE_SCOREBOARD_SV
`define READ_WRITE_SCOREBOARD_SV
class read_write_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(read_write_scoreboard)
    uvm_tlm_analysis_fifo #(fifo_seq_item) write_fifo;
    uvm_tlm_analysis_fifo #(fifo_seq_item) read_fifo;
    asyn_fifo_env_config cfg;
    bit [`WIDTH-1:0] q[$];
    int errors     = 0;
    int write_nums = 0;
    int read_nums  = 0;
    extern function new(string name = "read_write_scoreboard",uvm_component parent);
    extern function void  build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task monitor_write();
    extern task monitor_read();
    extern task reset_listener();
    extern function void report_phase(uvm_phase phase);


endclass : read_write_scoreboard


function read_write_scoreboard::new(string name = "read_write_scoreboard",uvm_component parent);
    super.new(name,parent);
    write_fifo = new("write_fifo",this);
    read_fifo  = new("read_fifo",this);
endfunction : new

function void read_write_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(asyn_fifo_env_config)::get(this,"","asyn_fifo_env_config",cfg))
        `uvm_fatal(get_type_name(),"Can't get the asyn_fifo_env_config!")
endfunction : build_phase

task read_write_scoreboard::run_phase(uvm_phase phase);
    fork
        monitor_write();
        monitor_read();
        reset_listener();
    join_none
        
endtask : run_phase

task read_write_scoreboard::monitor_write();
    fifo_seq_item written_item;
    forever begin
        write_fifo.get(written_item);
        write_nums++;
        q.push_back(written_item.data);
    end
endtask : monitor_write

task read_write_scoreboard::reset_listener();
    forever begin
        //@(posedge cfg.m_wf_cfg.FIFO.wclk);
        //if(!cfg.m_wf_cfg.FIFO.wrst_n) begin
        @(negedge cfg.m_wf_cfg.FIFO.wrst_n) ;
        q.delete();
    end
endtask : reset_listener

task read_write_scoreboard::monitor_read();
    fifo_seq_item    read_item;
    bit [`WIDTH-1:0] data;
    forever begin
        read_fifo.get(read_item);
        read_nums++;
        if(q.size()) begin
            data = q.pop_front;
            if(data != read_item.data) begin
                `uvm_error("SCB::CMP FAILED",$sformatf("Error is detected when compare the data from read and write, the expected is [%0x],but the actual is [%0x].",data,read_item.data))
                errors++;
            end
        end 
        else 
            `uvm_error(get_type_name(),"Has read the fifo, but there is no expected data.")
    end
endtask : monitor_read

function void read_write_scoreboard::report_phase(uvm_phase phase);
    if(errors != 0)
        `uvm_error(get_type_name(),$sformatf("%0d errors has detected within %0d write transaction and %0d read transaction.",errors,write_nums,read_nums))
    else 
        `uvm_info(get_type_name(),$sformatf("There is no comparing errors when reading %0d transaction in writing %0d transaction.",read_nums,write_nums),UVM_MEDIUM)

endfunction : report_phase
`endif // READ_WRITE_SCOREBOARD_SV
