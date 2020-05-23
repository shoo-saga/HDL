module testd;
logic [2:0] a,b;
logic o;
dainariequal d0(a, b, o);

initial begin
    $dumpfile("dainari.vcd");
    $dumpvars(0, testd);
    a = 3'b111;
    b = 3'b011;
    #10
    a = 3'b111;
    b = 3'b111;
    #10
    a = 3'b101;
    b = 3'b111;
    #10
    $finish;
end


endmodule