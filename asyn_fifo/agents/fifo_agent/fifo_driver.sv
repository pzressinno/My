// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : fifo_driver.sv
// Author        : AiF
// Created On    : 2022-05-15 17:03
// Last Modified : 2022-05-19 19:11
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef FIFO_DRIVER_SV
`define FIFO_DRIVER_SV
class fifo_driver extends uvm_driver #(fifo_seq_item);
    `uvm_component_utils(fifo_driver)
    virtual fifo_if FIFO;
    fifo_agent_config cfg;
    bit  has_trans;
    bit  has_reset;
    bit  req_status;
    bit [`WIDTH-1:0] data_t;
    extern function new(string name= "fifo_driver",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task write_one_pkt(fifo_seq_item req);
    extern task read_one_pkt(fifo_seq_item req);
    extern task drive_idle(bit cmd);

    extern task reset_listener();
    extern task wait_rst_release();
    extern task get_and_drive();
    extern task write_dile();
    extern task read_dile();
endclass : fifo_driver

function fifo_driver::new(string name = "fifo_driver",uvm_component parent);
    super.new(name,parent);
endfunction : new

function void fifo_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(fifo_agent_config)::get(this,"","fifo_agent_config",cfg))
        `uvm_fatal(get_type_name(),"Can't get the fifo_agent_config!")
endfunction : build_phase

task fifo_driver::reset_listener();
    forever begin :reset
        if(cfg.cmd) begin
            @(negedge FIFO.wrst_n);
            FIFO.winc  <=  0;
            FIFO.wdata <= '0;
        end
        else  begin
           @(negedge FIFO.rrst_n);
           FIFO.rinc <= '0;
           end
    end
    
endtask : reset_listener

task fifo_driver::wait_rst_release();
      if(cfg.cmd) begin
            @(negedge FIFO.wclk);
            #1;
            has_reset = 0;
            if(!FIFO.wrst_n && req_status) 
                has_reset = 1; // before this ,there is a pkt reset;
            wait(FIFO.wrst_n);
	    	end
        else  begin
            @(negedge FIFO.rclk);
            #1;     // to avoid the compete with get_next_item
            has_reset = 0;
            if(!FIFO.rrst_n && req_status) 
                has_reset = 1; // before this ,there is a pkt reset;
            wait(FIFO.rrst_n);
        end 
endtask : wait_rst_release

task fifo_driver::get_and_drive();
    if(has_reset) begin
        if(cfg.cmd) begin
            @(posedge FIFO.wclk);
            FIFO.drv_wr_cb.winc  <= 1;
            FIFO.drv_wr_cb.wdata <= data_t;
        end
        else begin
            @(posedge FIFO.rclk);
            FIFO.drv_rd_cb.rinc  <= 1;
        end
    end 

    else begin
        req_status = 0;
        seq_item_port.get_next_item(req);
        data_t = req.data;
        has_trans      = 1;
        req_status = 1;
        if(req.cmd)    //if write
            write_one_pkt(req);
        else 
            read_one_pkt(req);

        has_trans = 0;
        seq_item_port.item_done();
    end
endtask : get_and_drive

task fifo_driver::run_phase(uvm_phase phase);
    fifo_seq_item req;
    FIFO.wdata <= '0;
    FIFO.winc  <=  0;
    FIFO.rinc  <=  0;
    fork
        reset_listener();
        forever  begin 
            wait_rst_release();
            get_and_drive();
        end 
        write_dile();
        read_dile();
    join_none
endtask : run_phase

task fifo_driver::write_dile();
    forever begin
        @(posedge FIFO.wclk);
        if(!has_trans & cfg.cmd) FIFO.drv_wr_cb.winc <= 0;
    end
endtask : write_dile

task fifo_driver::read_dile();
    forever begin
        @(posedge FIFO.rclk);
        if(!has_trans & (!cfg.cmd)) FIFO.drv_rd_cb.rinc <= 0;
    end
endtask : read_dile

task fifo_driver::write_one_pkt(fifo_seq_item req);
    /*
     *while(FIFO.drv_cb.wfull) begin
     *    FIFO.drv_cb.winc <= 0;
     *    @(FIFO.drv_cb);
     *end
     */
    //foreach(req.data[i]) begin
        @(posedge FIFO.wclk);
			//`uvm_info("DEBUG","winc  = 1",UVM_MEDIUM)
            FIFO.drv_wr_cb.winc  <= 1;
            FIFO.drv_wr_cb.wdata <= req.data;
    //end
        
    repeat(req.pkt_idles)
        drive_idle(req.cmd);

endtask : write_one_pkt

task fifo_driver::read_one_pkt(fifo_seq_item req);
    //foreach(req.nums) begin
        @(posedge FIFO.rclk);
        //FIFO.drv_rd_cb.rinc  <= 1;
        FIFO.drv_rd_cb.rinc  <= 1;
        
    //  req.data[i] = FIFO.drv_rd_cb.rdata;
       // req.data = FIFO.drv_rd_cb.rdata;
    //end
        
    repeat(req.pkt_idles)
        drive_idle(req.cmd);

endtask : read_one_pkt
task fifo_driver::drive_idle(bit cmd);
    if(cmd) begin
        @(FIFO.drv_wr_cb);
        FIFO.wdata <= '0;
        FIFO.winc  <=  0;
        end
    else begin
        @(FIFO.drv_rd_cb);
        FIFO.rinc  <=  0;
        end
endtask : drive_idle
`endif //FIFO_DRIVER_SV
