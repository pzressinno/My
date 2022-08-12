// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : tb.sv
// Author        : AiF
// Created On    : 2022-05-15 19:17
// Last Modified : 2022-05-19 11:36
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
module asyn_fifo_tb;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    logic     wclk;
    logic     rclk;

    real      wclk_half_period;
    real      rclk_half_period;
    fifo_if FIFO(.*);

    initial begin
        uvm_config_db#(virtual fifo_if)::set(uvm_root::get(),"uvm_test_top","w_fifo_if",FIFO);
        uvm_config_db#(virtual fifo_if)::set(uvm_root::get(),"uvm_test_top","r_fifo_if",FIFO);
        run_test();
    end

    initial begin
        string testname;
        if($value$plusargs("UVM_TESTNAME=%s",testname))
            `uvm_info("UVM_TOP_TB",$sformatf("RUNNING TEST {%0s} ...",testname),UVM_NONE)
        $fsdbDumpfile({testname,".fsdb"});
        $fsdbDumpvars;
        $fsdbDumpMDA();
		$fsdbDumpSVA;
    end
 
	// Configurable wclk
	initial begin
        wclk = 0;
        #10
        //if(uvm_config_db#(real)::get(uvm_root::get(),"uvm_test_top","wclk_half_period",wclk_half_period))  //In test config
        if(uvm_config_db#(int)::get(uvm_root::get(),"uvm_test_top.m_env.m_wf_agent.m_sequencer","wclk_half_period",wclk_half_period))
            `uvm_info("WCLK",$sformatf("Configure the wclk_half_period = [%0d]",wclk_half_period),UVM_NONE)
        else begin
            `uvm_info("WCLK","Can't configure wclk with config_db correctly,will use default value:10",UVM_MEDIUM)
            wclk_half_period = 10;
        end
        forever begin 
            #wclk_half_period wclk = ~wclk;
        end
    end

	// Configurable rclk
	initial begin
        rclk = 0;
        #10
        if(uvm_config_db#(int)::get(uvm_root::get(),"uvm_test_top.m_env.m_rf_agent.m_sequencer","rclk_half_period",rclk_half_period))
            `uvm_info("RCLK",$sformatf("Configure the rclk_half_period = [%0d]",rclk_half_period),UVM_NONE)
        else begin
            `uvm_info("RCLK","Can't configure rclk with config_db correctly,will use default value:10",UVM_MEDIUM)
            rclk_half_period = 10;
        end
        forever begin 
            #rclk_half_period rclk = ~rclk;
        end
    end
    
    // read reset
    /*
	 *initial begin
     *    rrst_n = 0;
     *    #30
     *    rrst_n = 1;
     *end
     */
	// 读写控制
asyn_fifo U_ASYN_FIFO_0(
    .rdata                          ( FIFO.rdata                         ),
    .rempty                         ( FIFO.rempty                        ),
    .rclk                           ( FIFO.rclk                          ),
    .rinc                           ( FIFO.rinc                          ),
    .rrst_n                         ( FIFO.rrst_n                        ),

    .wdata                          ( FIFO.wdata                         ),
    .wfull                          ( FIFO.wfull                         ),
    .wclk                           ( FIFO.wclk                          ),
    .winc                           ( FIFO.winc                          ),
    .wrst_n                         ( FIFO.wrst_n                        )
);
endmodule
