// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : asyn_fifo.v
// Author        : AiF
// Created On    : 2022-05-14 14:44
// Last Modified : 2022-05-14 16:28
// ---------------------------------------------------------------------------------
// Description   : 
//                  The top file
//
// ---------------------------------------------------------------------------------
module asyn_fifo(
    output [`WIDTH-1:0] rdata,
    output              rempty,
    input               rclk,
    input               rinc,
    input               rrst_n,
        
    input  [`WIDTH-1:0] wdata,
    output              wfull,
    input               wclk,
    input               winc,
    input               wrst_n
);

wire [`ADDRSIZE-1:0] waddr;
wire [`ADDRSIZE-1:0] raddr;

reg  [`ADDRSIZE:0]  wptr;
reg  [`ADDRSIZE:0]  wq2_rptr;

reg  [`ADDRSIZE:0]  rptr;
reg  [`ADDRSIZE:0]  rq2_wptr;

fifo_mem U_FIFO_MEM_0(
    .rd_data                        ( rdata                       ),
    .wr_data                        ( wdata                       ),
    .wr_en                          ( winc&!wfull                 ),
    .rd_en                          ( rinc&!rempty                ),
    .wr_clk                         ( wclk                        ),
    .rd_clk                         ( rclk                        ),
    .wr_addr                        ( waddr                     ),
    .rd_addr                        ( raddr                     )
);

gen_waddr U_GEN_WADDR_0(
    .wfull                          ( wfull                         ),
    .waddr                          ( waddr                         ),
    .wptr                           ( wptr                          ),
    .wclk                           ( wclk                          ),
    .winc                           ( winc                          ),
    .wq2_rptr                       ( wq2_rptr                      ),
    .wrst_n                         ( wrst_n                        )
);
gen_raddr U_GEN_RADDR_0(
    .rempty                         ( rempty                        ),
    .raddr                          ( raddr                         ),
    .rptr                           ( rptr                          ),
    .rclk                           ( rclk                          ),
    .rinc                           ( rinc                          ),
    .rq2_wptr                       ( rq2_wptr                      ),
    .rrst_n                         ( rrst_n                        )
);

sync_r2w U_SYNC_R2W_0(
    .wq2_rptr                       ( wq2_rptr                      ),
    .rptr                           ( rptr                          ),
    .wclk                           ( wclk                          ),
    .wrst_n                         ( wrst_n                        )
);

sync_w2r U_SYNC_W2R_0(
    .rq2_wptr                       ( rq2_wptr                      ),
    .wptr                           ( wptr                          ),
    .rclk                           ( rclk                          ),
    .rrst_n                         ( rrst_n                        )
);


endmodule
