// 82015037
// shoo saga
module test_cbsel();
reg [9:0] i0, i1, i2, i3;
reg [9:0] o;
reg [3:0] d;

cbsel cbsel(i0, i1, i2, i3, o, d);

initial begin
    $dumpfile("vm.vcd");
    $dumpvars(0, test);
    #2
    i0 = 9'b0;
    i1 = 9'b0;
    i2 = 9'b0;
    i3 = 9'b0;
    d  = 4'b0;
    #2
    d = 4'b1000;
    i3 = 9'd140;
    #2
    d  = 4'b0100;
    i2 = 9'd15;
    #2
    d  = 4'b0010;
    i1 = 9'd12;
    #2
    d  = 4'b0001;
    i0 = 9'd18;
    #2

end
endmodule
