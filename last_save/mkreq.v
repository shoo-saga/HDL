module mkreq(input [9:0] pkto,output logic [3:0] reqi);
    always_comb begin
        reqi = 4'b0000;
        if (pkto[9:8] == 2'b10)begin
            case(pkto[1:0])
            //sysnopsys full_case parallel_case
            2'b00:reqi = 4'b0001;
            2'b01:reqi = 4'b0010;
            2'b10:reqi = 4'b0100;
            2'b11:reqi = 4'b1000;
            endcase
        end
    end
endmodule