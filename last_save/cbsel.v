module cbsel(input logic [9:0] i0, i1, i2, i3,
output logic [9:0] o, input logic [3:0] d);

always_comb begin
    o = 9'b0;
    case(1)
    //sysnopsys full_case parallel_case
    d[0]: o = i0;
    d[1]: o = i1;
    d[2]: o = i2;
    d[3]: o = i3;
    default: o = 9'b0;
    endcase
end
endmodule