// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : wrstn_config_seq.sv
// Author        : AiF
// Created On    : 2022-05-16 15:41
// Last Modified : 2022-05-19 19:12
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef WRSTN_CONFIG_SEQ_SV
`define WRSTN_CONFIG_SEQ_SV
class wrstn_config_seq extends asyn_fifo_seq_base;
    `uvm_object_utils(wrstn_config_seq)
    rand bit wrst_en;
    rand int resetn; //reset number
    constraint cstr{
            soft wrst_en == 0;
            soft resetn    == 0;
        }
    extern function new(string name = "wrstn_config_seq");
    extern task body();

endclass : wrstn_config_seq

function wrstn_config_seq::new(string name = "wrstn_config_seq");
    super.new(name);
endfunction : new

task wrstn_config_seq::body();
    super.body();
        if(wrst_en)
				begin /*
				cfg.m_wf_cfg.FIFO.wrst_n = 0;
				repeat(3) 
					@(negedge cfg.m_wf_cfg.FIFO.wclk);
				cfg.m_wf_cfg.FIFO.wrst_n = 1;
				end 

				begin 
					#randtime;
					@(negedge cfg.m_wf_cfg.FIFO.wclk);
						cfg.m_wf_cfg.FIFO.wrst_n = 0;
					repeat(5) begin
						@(negedge cfg.m_wf_cfg.FIFO.wclk);
					end 
						cfg.m_wf_cfg.FIFO.wrst_n = 1; */
					@(negedge cfg.m_wf_cfg.FIFO.wclk);
					cfg.m_wf_cfg.FIFO.wrst_n = 0; 
					repeat(resetn) 
						@(negedge cfg.m_wf_cfg.FIFO.wclk);
					cfg.m_wf_cfg.FIFO.wrst_n = 1; 
                end
        else begin
				cfg.m_wf_cfg.FIFO.wrst_n = 0;
				repeat(5)
					@(posedge cfg.m_wf_cfg.FIFO.wclk);
				cfg.m_wf_cfg.FIFO.wrst_n = 1;
             end
endtask : body

`endif // wrstn_config_seq_SV
