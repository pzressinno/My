// ---------------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                 ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : tb_v.v
// Author        : AiF
// Created On    : 2022-05-14 16:48
// Last Modified : 2022-05-14 17:14
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// ---------------------------------------------------------------------------------
module asyn_fifo_tb;
 
	// 写时钟域tb信号定义
	reg					wclk		;
	reg					wrst_n	;
	reg	[`WIDTH-1:0]		wdata		;
	reg 				winc		;
	wire				wfull		;
 
	// 读时钟域tb信号定义
	reg					rclk		;
	reg					rrst_n	;
	wire [`WIDTH-1:0]	rdata		;
	reg					rinc		;
	wire				rempty	;
 
	// testbench自定义信号
	reg					init_done	;		// testbench初始化结束
 
 
 
	// FIFO初始化
	initial	begin
		// 输入信号初始化
		wrst_n  = 1	;
		rrst_n  = 1	;
		wclk 	  = 0	;
		rclk 	  = 0	;
		winc 	  = 0	;
		rinc 	  = 0	;
		wdata   = 'b0 ;
		init_done = 0	;
 
		// FIFO复位
		#30 wrst_n = 0;
			rrst_n = 0;
		#30 wrst_n = 1;
			rrst_n = 1;
 
		// 初始化完毕
		#30 init_done = 1;
	end
 
    initial begin
        $fsdbDumpfile("Wave.fsdb");
        $fsdbDumpvars;
    end
 
	// 写时钟
	always
		#2 wclk = ~wclk;
 
	// 读时钟
	always
		#4 rclk = ~rclk;
 
 
 
	// 读写控制
	always @(*) begin
		if(init_done) begin
			// 写数据
			if( wfull == 1'b1 )begin
				winc = 0;
			end
			else begin
				winc = 1;
			end
		end
	end
 
	always @(*) begin
		if(init_done) begin
			// 读数据
			if( rempty == 1'b1 )begin
				rinc = 0;
			end
			else begin
				rinc = 1;
			end
		end
	end
 
 
 
	// 写入数据自增
	always @(posedge wclk) begin
		if(init_done) begin
			if( wfull == 1'b0 )
				wdata <= wdata + 1;
			else
				wdata <= wdata;
		end
		else begin
			wdata <= 'b0;
		end
	end
 
asyn_fifo U_ASYN_FIFO_0(
    .rdata                          ( rdata                         ),
    .rempty                         ( rempty                        ),
    .rclk                           ( rclk                          ),
    .rinc                           ( rinc                          ),
    .rrst_n                         ( rrst_n                        ),

    .wdata                          ( wdata                         ),
    .wfull                          ( wfull                         ),
    .wclk                           ( wclk                          ),
    .winc                           ( winc                          ),
    .wrst_n                         ( wrst_n                        )
);
endmodule
