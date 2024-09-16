// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : gen_raddr.v
// Author        : AiF
// Created On    : 2022-05-14 12:55
// Last Modified : 2022-05-16 18:27
// ---------------------------------------------------------------------------------
// Description   : 
//                  generate the raddr, include read-pointer-gray to syn
//                  and the read_empty signal
// ---------------------------------------------------------------------------------

module gen_raddr(
    output                     rempty,
    output [`ADDRSIZE-1:0]     raddr,
    output [`ADDRSIZE:0]       rptr,    //the pointer read,gray to syn
    
    input                      rclk,
    input                      rinc,    //read enable
    input  [`ADDRSIZE:0]       rq2_wptr, //the wptr syned 2clk
    input                      rrst_n
);
reg [`ADDRSIZE:0] raddr_bin; //the raddr bin

// Gen the raddr bin
always@(posedge rclk) begin
    if(!rrst_n)
        raddr_bin <= 'b0;
    else if(rinc && !rempty) begin
        raddr_bin <= raddr_bin +1;
    end 
    else 
        raddr_bin <= raddr_bin;
end
assign raddr = raddr_bin[`ADDRSIZE-1:0];

//Gen raddr gray
//wire [`ADDRSIZE:0] rptr;
assign rptr = raddr_bin ^ (raddr_bin >> 1);

/*
 *always@(posedge rclk) begin
 *    if(!rrst_n)
 *        rptr <= 'b0;
 *    else 
 *        rptr <= raddr_gray;
 *end
 */

assign rempty = rptr == rq2_wptr;

endmodule
