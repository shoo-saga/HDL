module test;
logic st, clk, rst;
logic [4:0] memory [31:0];
logic [4:0] dot;

ledarray ledarray(  .*);

initial begin
    $dumpfile("LED.vcd");
    $dumpvars(0, test);
    $readmemb("pattern.txt", memory);
    #2
    rst = 1;
    clk = 1;
    st = 0;
    #2
    rst = 0;
    #2
    st = 1'b1;
    #2
    st = 1'b0;
    #40
    st = 1'b1;
    #2
    st = 1'b0;
    #40
    $finish;
end

always begin
        #1 clk = ~clk;
end
endmodule