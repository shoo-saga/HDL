module test;
logic [3:0] a, b, s;
substructer sb(a, b, s, co);
initial begin
    $dumpfile("substructer.vcd");
    $dumpvars(0, test);
    a = 8;
    b = 4;
    #10
    a = 13;
    b = 11 ;
    #10
    a = 9;
    b = 4;
    #10
    $finish;
end


endmodule