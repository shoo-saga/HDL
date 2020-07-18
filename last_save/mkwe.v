module mkwe(input [9:0] pkti, output logic we);
    always_comb begin
        we = 1'b0;
        if (pkti [9:8] == 2'b10)
        we = 1'b1;
        else if (pkti [9:8] == 2'b01)
        we = 1'b1;
        else
        we = 1'b0;
    end
endmodule