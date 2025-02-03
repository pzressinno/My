// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : rrstn_config_seq.sv
// Author        : AiF
// Created On    : 2022-05-16 15:41
// Last Modified : 2022-05-19 19:12
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
`ifndef RRSTN_CONFIG_SEQ_SV
`define RRSTN_CONFIG_SEQ_SV
class rrstn_config_seq extends asyn_fifo_seq_base;
    `uvm_object_utils(rrstn_config_seq)
    rand bit rrst_en ; // '1' indicate rst_n test ,default :0
    rand int resetn; //reset number
    constraint cstr{
            soft   rrst_en == 0;
            soft   resetn   == 0;
        }
    extern function new(string name = "rrstn_config_seq");
    extern task body();

endclass : rrstn_config_seq

function rrstn_config_seq::new(string name = "rrstn_config_seq");
    super.new(name);
endfunction : new

task rrstn_config_seq::body();
    super.body();
        if(rrst_en)
			begin
            @(negedge cfg.m_rf_cfg.FIFO.rclk);
				cfg.m_rf_cfg.FIFO.rrst_n = 0; 
				repeat(resetn) 
					@(negedge cfg.m_rf_cfg.FIFO.rclk);

				cfg.m_rf_cfg.FIFO.rrst_n = 1; 

            end
        else begin
            cfg.m_rf_cfg.FIFO.rrst_n = 0;
            repeat(5)
                @(posedge cfg.m_rf_cfg.FIFO.rclk);
            cfg.m_rf_cfg.FIFO.rrst_n = 1;
        end
endtask : body

`endif // rrstn_config_seq_SV
