// 82015037
// shoo saga
module cbsel(input  [9:0] i0, i1, i2, i3,
output logic [9:0] o, input  [3:0] d);

always@(*) begin
    o = 0;
    case(1)
    d[0]: o = i0;
    d[1]: o = i1;
    d[2]: o = i2;
    d[3]: o = i3;
    default: o = 0;
    endcase
end
endmodule