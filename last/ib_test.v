`include "sw.vh"
module test;
	logic [`PKTW:0] pkti, pkto;
	logic ack,full,clk, rst;
	logic [3:0] req;
	ib ib(pkti, pkto, req, ack, full, clk, rst);
	always #5 clk = ~clk;
initial begin
$dumpfile("sw.vcd");
$dumpvars(0, test);
clk = 0;
pkti = 0;
ack= 0;
rst = `ASSERT;
#10
rst = `NEGATE;
#10
pkti = 10'b10_0000_0000; // port0 => port0 length 4
#10
pkti = 10'b01_0000_0000;
ack = `ASSERT;
#10
pkti = 10'b01_0000_0001;
ack= 0;
#10
pkti = 10'b11_0000_0010;
#100
pkti = 0;
#10
pkti = 10'b10_1001_0001; // port0 => port1 length 4
#10
ack = `ASSERT;
pkti = 10'b01_1001_0000;
#10
pkti = 10'b01_1001_0001;
ack = 0;
#10
pkti = 10'b11_1001_0010;
#100
pkti = 0;

#10
pkti = 0;

#500
$finish;
end
endmodule
