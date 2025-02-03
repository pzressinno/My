// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : sync_r2w.v
// Author        : AiF
// Created On    : 2022-05-14 14:17
// Last Modified : 2022-05-14 16:04
// ---------------------------------------------------------------------------------
// Description   : 
//                  sync the read_pointer to write clk domain
//
// ---------------------------------------------------------------------------------

module sync_r2w (
    output reg [`ADDRSIZE:0] wq2_rptr,
    input  [`ADDRSIZE:0] rptr,
    input                wclk,
    input                wrst_n
);

reg [`ADDRSIZE:0] wq2_rptr_r;

//two clk
always@(posedge wclk) begin
    if(!wrst_n)
        {wq2_rptr_r,wq2_rptr} <= 'b0;
    else 
        {wq2_rptr,wq2_rptr_r} <= {wq2_rptr_r,rptr};       
end

endmodule
