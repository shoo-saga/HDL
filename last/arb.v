`include "sw.vh"
module arb(input ack0,ack1,ack2,ack3, output req0,req1,req2,req3);

always_comb begin
    if (ack0) req0 = `ASSERT;
    else if (ack1) req1 = `ASSERT;
    else if (ack2) req2 = `ASSERT;
    else if (ack3) req3 = `ASSERT;
    else
    req0 = `NEGATE;
    req1 = `NEGATE;
    req2 = `NEGATE;
    req3 = `NEGATE;
end
endmodule