`include "sw.vh"
module mkwe(input [`PKTW:0] pkti, output we);
    always_comb begin
        if (pkti [9:8] == HEAD)
        we = `ASSERT;
        else if (pkti [9:8] == HEAD)
        we = `ASSERT;
        else
        we = `NEGATE;
    end
endmodule