module iftest(input a, b, s,output o);
logic o;
    always_comb begin
        if(s) o = a;
        else o = b;
    end
endmodule

module test;
logic a, b, s, o;
initial begin
    $dumpfile("iftest.vcd");
    $dumpvars(0, test);
    a = 1;
    b = 0;
    s = 0;
#10
    a = 1;
    b = 0;
    s = 1;
#10
    a = 0;
    b = 1;
    s = 1;
#10
    $finish;
end
endmodule