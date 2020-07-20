// 82015037
// shoo saga
module ib(input [9:0] pkti, output [9:0] pkto, output [3:0] req, input ack,
	output empty, full, input clk, rst);
	mkwe mkwe(pkti, we);
	fifo fifo(pkti, we, full, pkto, re, empty, clk, rst);
	ibsm ibsm(pkto, re, empty, req, ack, clk, rst);
endmodule

