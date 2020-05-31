module test;
logic a,b,clk,rst, out;
logic [2:0] change;
vm vend(a, b, clk, rst,change,out);
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