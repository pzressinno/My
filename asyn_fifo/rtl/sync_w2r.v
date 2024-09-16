// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : sync_w2r.v
// Author        : AiF
// Created On    : 2022-05-14 14:17
// Last Modified : 2022-05-14 16:03
// ---------------------------------------------------------------------------------
// Description   : 
//                  sync the read_pointer to write clk domain
//
// ---------------------------------------------------------------------------------

module sync_w2r (
    output reg [`ADDRSIZE:0] rq2_wptr,
    input      [`ADDRSIZE:0] wptr,
    input                    rclk,
    input                    rrst_n
);

reg [`ADDRSIZE:0] rq2_wptr_r;

//two clk
always@(posedge rclk) begin
    if(!rrst_n)
        {rq2_wptr_r,rq2_wptr} <= 'b0;
    else 
        {rq2_wptr,rq2_wptr_r} <= {rq2_wptr_r,wptr};       
end

endmodule 
