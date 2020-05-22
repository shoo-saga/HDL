module dainari(input [2:0] a, b, s,output o);
logic o;
    always_comb begin
        if( a>b ) o = 1'b1;

        else o = 1'b0;
    end

initial begin
    $dumpfile("dainariequal.vcd")
    $dumpvars(0, test)
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