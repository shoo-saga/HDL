module test;
logic clk, en, b;
logic [7:0] v;
p_p_counter ppc(clk, en, v, b);
initial begin
    $dumpfile("p_p_counter.vcd");
    $dumpvars(0, test);
    en  = 0;
    v = 'd5;
    #1
    en = 1;
    #18
    en  = 0;
    v = 'd3;
    #1
    en = 1;
    #10
    $finish;
end
always begin
    clk = 0;
#1 clk = 1;
#1;
end


endmodule