// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : gen_waddr.v
// Author        : AiF
// Created On    : 2022-05-14 11:33
// Last Modified : 2022-05-16 18:26
// ---------------------------------------------------------------------------------
// Description   : 
//                  generate the waddr, include write-pointer ,gray & bin
//
// ---------------------------------------------------------------------------------

module gen_waddr(
    output                     wfull,
    output     [`ADDRSIZE-1:0] waddr,
    output     [`ADDRSIZE:0]   wptr,    //the pointer write
    
    input                      wclk,
    input                      winc,    //write enable
    input      [`ADDRSIZE:0]   wq2_rptr,
    input                      wrst_n
);
reg [`ADDRSIZE:0] waddr_bin; //the waddr bin

// Gen the waddr bin
always@(posedge wclk) begin
    if(!wrst_n)
        waddr_bin <= 'b0;
    else if(winc && !wfull) begin
        waddr_bin <= waddr_bin +1;
    end 
    else 
        waddr_bin <= waddr_bin;
end
assign waddr = waddr_bin[`ADDRSIZE-1:0];

//Gen waddr gray
//wire [`ADDRSIZE:0] waddr_gray;
assign wptr = waddr_bin ^ (waddr_bin >> 1);

/*
 *always@(posedge wclk) begin
 *    if(!wrst_n)
 *        wptr <= 'b0;
 *    else 
 *        wptr <= waddr_gray;
 *end
 */

assign wfull = (wptr == {~wq2_rptr[`ADDRSIZE],~wq2_rptr[`ADDRSIZE-1],wq2_rptr[`ADDRSIZE-2:0]});

endmodule
