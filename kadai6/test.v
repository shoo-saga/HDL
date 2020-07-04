`timescale 1ns / 1ps

module test;
reg  a,b,clk,rst;
wire [2:0] change;
wire out;
vm vm(a, b, clk, rst, change, out);

initial begin
    $dumpfile("vm.vcd");
    $dumpvars(0, test);
    rst  = 1;
    a = 0;
    b = 0;
    #2
    rst = 0;
    a = 1;
    b = 0;
    #2
    a = 1;
    b = 0;
    #2
    a = 0;
    b = 1;
    #4
    rst = 1;
    a = 0;
    b = 0;
    #2
    rst = 0;
    a = 0;
    b = 1;
    #4
    rst = 1;
    a = 0;
    b = 0;
    #2
    rst = 0;
    a = 1;
    b = 0;
    #2
    a = 1;
    b = 0;
    #2
    a = 1;
    b = 0;
    #2
    a = 1;
    b = 0;
    #2
    a = 0;
    b = 1;
    #4
    $finish;
end
always begin
    clk = 0;
#1 clk = 1;
#1;
end


endmodule