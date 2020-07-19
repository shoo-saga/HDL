`include "sw.vh"
module fifo_test;
	logic [`PKTW:0] pkti, pkto;
	logic we, re, empty,full,clk, rst;
	fifo fifo(pkti, we, full, pkto, re,empty, clk, rst);
	always #5 clk = ~clk;
initial begin
$dumpfile("sw.vcd");
$dumpvars(0, fifo_test);
clk = 0;
pkti = 0;
we = 0;
re = 0;
rst = `ASSERT;
#10
rst = `NEGATE;
#10
pkti = 10'b10_0000_0000; // port0 => port0 length 4
we =  `ASSERT;
#10
pkti = 10'b01_0000_0000;
re =  `ASSERT;
#10
pkti = 10'b01_0000_0001;
#10
pkti = 10'b11_0000_0010;
we =  `NEGATE;
#100
re = `NEGATE;
pkti = 0;
#10
pkti = 10'b10_1001_0001; // port0 => port1 length 4
we = `ASSERT;
#10
pkti = 10'b01_1001_0000;
re = `ASSERT;
#10
pkti = 10'b01_1001_0001;
#10
pkti = 10'b11_1001_0010;
we =  `NEGATE;
re = `NEGATE;
#100
pkti = 0;
#10
pkti = 10'b11_0000_0010;
we =  `NEGATE;
#100
pkti = 0;
#10
pkti = 10'b10_1001_0001; // port0 => port1 length 4
we = `ASSERT;
#10

pkti = 10'b01_1001_0000;
#10
pkti = 10'b01_1001_0001;
#10
pkti = 10'b11_1001_0010;
we =  `NEGATE;
#10
#10
pkti = 10'b11_0000_0010;
we =  `NEGATE;
#100
pkti = 0;
#10
pkti = 10'b10_1001_0001; // port0 => port1 length 4
we = `ASSERT;
#10
pkti = 10'b01_1001_0000;
#10
pkti = 10'b01_1001_0001;
#10
pkti = 10'b11_1001_0010;
we =  `NEGATE;
#10
pkti = 10'b10_1001_0001; // port0 => port1 length 4
we = `ASSERT;
#10
pkti = 10'b01_1001_0000;
#10
pkti = 10'b01_1001_0001;
#10
pkti = 10'b11_1001_0010;
we =  `NEGATE;
#10
pkti = 10'b10_1001_0001; // port0 => port1 length 4
we = `ASSERT;
#10
pkti = 10'b01_1001_0000;
#10
pkti = 10'b01_1001_0001;
#10
pkti = 10'b11_1001_0010;
we =  `NEGATE;
#500
$finish;
end
endmodule
