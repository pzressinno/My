// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : fifo_mem.v
// Author        : AiF
// Created On    : 2022-05-14 00:33
// Last Modified : 2022-05-14 21:05
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// -FHDR----------------------------------------------------------------------------
//
module fifo_mem(
    output reg [`WIDTH-1:0] rd_data,    //ouput read data
    input      [`WIDTH-1:0] wr_data,    // write data

    input                   wr_en,      //write enable    
    input                   rd_en,      //read  enable    
    input                   wr_clk,     //write clk 
    input                   rd_clk,     //read  clk

    input  [`ADDRSIZE-1:0]  wr_addr,    //the write addr
    input  [`ADDRSIZE-1:0]  rd_addr    //the read  addr
);
    reg [`WIDTH-1:0] mem [`DEEPTH-1:0]; 

    always@(posedge rd_clk) begin
        if(rd_en)
            rd_data <= mem[rd_addr];
    end

    always@(posedge wr_clk) begin
        if(wr_en)
            mem[wr_addr] <= wr_data;
    end
endmodule
