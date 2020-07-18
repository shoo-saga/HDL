`include "sw.vh"
module test;
	logic [`PKTW:0] pkti;
	logic we;
	mkwe mkwe(pkti, we);
initial begin
$dumpfile("sw.vcd");
$dumpvars(0, test);
pkti = 0;
#10
pkti = 10'b10_0000_0000; // port0 => port0 length 4
#10
pkti = 10'b01_0000_0000;
#10
pkti = 10'b01_0000_0001;
#10
pkti = 10'b11_0000_0010;
#100
pkti = 0;
#10
pkti = 10'b10_1001_0001; // port0 => port1 length 4
#10
pkti = 10'b01_1001_0000;
#10
pkti = 10'b01_1001_0001;
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
