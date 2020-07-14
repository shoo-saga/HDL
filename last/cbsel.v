
module cbsel(input logic[PKTW:0] i0, i1, i2, i3,
output logic[PKTW:0] o,input logic[PORT:0] d);

parameter PKTW = 9;
parameter PORT = 3;

always_comb begin
    o = 9'b0;
    //sysnopsys full_case parallel_case
    case(1)
    d[0]: o = i0;
    d[1]: o = i1;
    d[2]: o = i2;
    d[3]: o = i3;
    default: o = 9'b0;
    endcase
end
endmodule