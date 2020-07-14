parameter PKTW 9;
parameter PORT 3;
module cbsel(input [PKTW:0] i0, i1, i2, i3, input[PORT:0] d,
output [PKTW:0] o);

always_comb begin
    o = 9'b0;
    //sysnopsys full_case parallel_case
    case(1)
    d[0]: o = i0;
    d[1]: o = i1;
    d[2]: o = i2;
    d[3]: o = i3;
    default: o = 9'b0;
end
