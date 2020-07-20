`include "sw.vh"
module test_ackor;
	logic ack0,ack1,ack2,ack3,ack,clk,rst;
	ackor ackor(ack0,ack1,ack2,ack3,ack);
	always #5 clk = ~clk;
initial begin
$dumpfile("test.vcd");
$dumpvars(0, test);
clk = 0;
ack0 =`NEGATE;
ack1 =`NEGATE;
ack2 =`NEGATE;
ack3 =`NEGATE;

rst = `ASSERT;
#10
rst = `NEGATE;
#10
ack0 = `ASSERT;
#10
ack1 = `ASSERT;
ack0 = `NEGATE;
#10
ack2 = `ASSERT;
ack1 = `NEGATE;
#10
ack3 = `ASSERT;
ack2 = `NEGATE;
#10
ack3 = `NEGATE;
ack0 = `NEGATE;
#50
$finish;
end
endmodule
