module test_dainari;
logic [2:0] a, b;
logic o;
dainari d0(a, b, o);

initial begin
    $dumpfile("dainari.vcd");
    $dumpvars(0, test);
    a = 3'd7;
    b = 3'd3;
    #10
    a = 3'd7;
    b = 3'd7;
    #10
    a = 3'd5;
    b = 3'd7;
    #10
    $finish;
end


endmodule