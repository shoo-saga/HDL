module vm(input a, b, clk, rst, output logic [2:0] change);
logic [5:0] state , nstate;
logic [2:0] nchange;
logic [1:0] cnt;

always@(posedge clk or posedge rst)
    if(rst)begin
        state <= state[0];
        change <= 3'b000;
    end
    else begin
        state <= nstate;
        change <= nchange;
    end
always_comb begin
    if (a == 1'b1)
        cnt = 2'b10;
    else if (b == 1'b1)
        cnt = 2'b01;
    else
         cnt = 2'b00;

    case(1)
        // synopsys full_case parallel_case
        state[0]:begin
        nchange = 3'b000;
        case(cnt)
        // synopsys full_case parallel_case
            2'b00: nstate = state[0];
            2'b01: nstate = state[5];
            2'b10: nstate = state[1];
            2'b11: nstate = state[0];
        endcase
        end
        state[1]:begin
        case(cnt)
            // synopsys full_case parallel_case
            2'b00: nstate = state[1];
            2'b01:begin
                 nstate = state[5];;
                 nchange = 3'd1;
            end
            2'b10: nstate = state[2];
            2'b11: nstate = state[1];
        endcase
        end
        state[2]:begin
        case(cnt)
            // synopsys full_case parallel_case
            2'b00: nstate= state[2];
            2'b01:begin
                 nstate = state[5];
                 nchange = 3'd2;
            end
            2'b10: nstate = state[3];
            2'b11: nstate = state[2];
        endcase
        end
        state[3]:begin
        case(cnt)
            // synopsys full_case parallel_case
            2'b00: nstate= state[3];
            2'b01:begin
                nstate = state[5];
                nchange = 3'd3;
            end
            2'b10: nstate = state[4];
            2'b11: nstate = state[3];
        endcase
        end
        state[4]:begin
        case(cnt)
        // synopsys full_case parallel_case
            2'b00: nstate= state[4];
            2'b01:begin
            nstate= state[5];
            nchange = 3'd4;
            end
            2'b10:begin
            nstate= state[5];
            nchange = 3'd0;
            end
            2'b11: nstate = state[4];
        endcase
        end
        state[5]:begin
        nstate = state[0];
        nchange = 3'b000;
        end
    endcase
end
endmodule