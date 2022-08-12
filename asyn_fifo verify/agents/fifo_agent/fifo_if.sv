// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : fifo_if.v
// Author        : AiF
// Created On    : 2022-05-15 16:56
// Last Modified : 2022-05-17 15:20
// ---------------------------------------------------------------------------------
// Description   : 
//                  fifo_interface
//                  modify : from write if to completed if
// ---------------------------------------------------------------------------------
interface fifo_if(input wclk,input rclk);
    //write
    logic [`WIDTH-1:0] wdata;
    logic              wfull;
    logic              winc;
    logic              wrst_n;

    bit                has_coverage = 1;

    clocking drv_wr_cb @( posedge wclk);
        default input #1ns output #1ns;
        output wdata,winc;
        input wfull;
    endclocking 

    clocking mon_wr_cb @(posedge wclk);
        default input #1ns output #1ns;
        input wdata,winc,wfull;
    endclocking 
    
    //read 
    logic [`WIDTH-1:0] rdata;
    logic              rempty;
    logic              rinc;
    logic              rrst_n;
    clocking drv_rd_cb @( posedge rclk);
        default input #1ns output #1ns;
        output rinc;
        input  rempty,rdata;
    endclocking 

    clocking mon_rd_cb @(posedge rclk);
        default input #1ns output #1ns;
        input rdata,rinc,rempty;
    endclocking 
    
    property continuous_16_write;
        @(posedge wclk)
        !wfull throughout winc[*16]; 
    endproperty : continuous_16_write
    CONTINUOUS_16_WRITE : cover property(continuous_16_write);
    
    property continuous_16_read;
        @(posedge rclk)
        !rempty throughout rinc[*16]; 
    endproperty : continuous_16_read
    CONTINUOUS_16_READ: cover property(continuous_16_read);
     
     
    covergroup exception_write_cg @(posedge wclk iff wrst_n);
        option.name         = "exception_write";
        option.per_instance = 1;
        coverpoint wfull{
                bins full    = {1};
                bins no_full = {0};
            }
    endgroup : exception_write_cg
    
    covergroup exception_read_cg @(posedge rclk iff rrst_n);
        option.name         = "exception_read";
        option.per_instance = 1;
        coverpoint rempty{
                bins empty    = {1};
                bins no_empty = {0};
            }
    endgroup : exception_read_cg
    initial begin
        if(has_coverage) begin
            automatic exception_write_cg exception_write_cg= new();
            automatic exception_read_cg  exception_read_cg= new();
        end
    end
endinterface
