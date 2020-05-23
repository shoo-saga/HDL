module dainariequal(input [2:0] a, b,output o);

logic o;
    always_comb begin
        if( a>=b )begin
         o = 1'b1;
        end
        else begin
             o = 1'b0;
        end
    end
endmodule