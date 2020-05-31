module vm(input a, b, clk, rst, output logic [2:0] change, output logic out);

typedef enum logic[5:0] {READY  ='b000001, TEN  ='b000010, TWENTY  ='b000100,
 THIRTY  ='b001000, FORTY  ='b010000, EXE  ='b100000} myst;
myst state ,nstate;
logic [2:0] nchange;
always@(posedge clk or posedge rst)
    if(rst)begin
        state <= READY;
    end
    else begin
        state <= nstate;
    end
always_comb
    // synopsysfull_caseparallel_case
     case(state)
        READY:begin
                change = 0;
                out = 0;
                nchange = 0;
         // synopsysfull_caseparallel_case
         case({a,b})
            2'b00: nstate= READY;
            2'b01: nstate= EXE;
            2'b10: nstate= TEN;
        endcase
        end
        TEN:begin
        // synopsysfull_caseparallel_case
         case({a,b})
            2'b00: nstate= TEN;
            2'b01:begin
                 nstate= EXE;;
                 nchange = 3'd1;
            end
            2'b10: nstate= TWENTY;
        endcase
        end
        TWENTY:begin
         // synopsysfull_caseparallel_case
         case({a,b})
            2'b00: nstate= TWENTY;
            2'b01:begin
                 nstate= EXE;
                 nchange = 3'd2;
            end
            2'b10: nstate= THIRTY;
        endcase
        end
        THIRTY:begin
         // synopsysfull_caseparallel_case
         case({a,b})
            2'b00: nstate= THIRTY;
            2'b01:begin
                nstate = EXE;
                nchange = 3'd3;
            end
            2'b10: nstate= FORTY;
        endcase
        end
        FORTY:begin
         // synopsysfull_caseparallel_case
         case({a,b})
            2'b00: nstate= FORTY;
            2'b01:begin
            nstate= EXE;
            nchange = 3'd4;
            end
            2'b10:begin
            nstate= EXE;
            nchange = 3'd0;
            end
        endcase
        end
        EXE:begin
        nstate= READY;
        change = nchange;
        out = 1;
        end
    endcase

endmodule