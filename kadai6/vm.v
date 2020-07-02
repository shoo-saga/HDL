module vm(input a, b, clk, rst, output logic [2:0] change);
logic [5:0] state , nstate;
logic [2:0] nchange;
logic [1:0] cnt;

always@(posedge clk or posedge rst)
    if(rst)begin
        state <= 6'b100000;
        change <= 3'b000;
    end
    else begin
        state <= nstate;
        change <= nchange;
    end
always_comb begin
    nstate = state;
    nchange = change;
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
            2'b00: nstate = 6'b000001;
            2'b01: nstate = 6'b100000;
            2'b10: nstate = 6'b000010;
            2'b11: nstate = 6'b000001;
        endcase
        end
        state[1]:begin
        case(cnt)
            // synopsys full_case parallel_case
            2'b00: nstate = 6'b000010;
            2'b01:begin
                 nstate = 6'b100000;
                 nchange = 3'd1;
            end
            2'b10: nstate = 6'b000100;
            2'b11: nstate = 6'b000010;
        endcase
        end
        state[2]:begin
        case(cnt)
            // synopsys full_case parallel_case
            2'b00: nstate= 6'b000100;
            2'b01:begin
                 nstate =6'b100000;
                 nchange = 3'd2;
            end
            2'b10: nstate = 6'b001000;
            2'b11: nstate = 6'b000100;
        endcase
        end
        state[3]:begin
        case(cnt)
            // synopsys full_case parallel_case
            2'b00: nstate= 6'b001000;
            2'b01:begin
                nstate = 6'b100000;
                nchange = 3'd3;
            end
            2'b10: nstate = 6'b010000;
            2'b11: nstate = 6'b001000;
        endcase
        end
        state[4]:begin
        case(cnt)
        // synopsys full_case parallel_case
            2'b00: nstate= 6'b010000;
            2'b01:begin
            nstate= 6'b100000;
            nchange = 3'd4;
            end
            2'b10:begin
            nstate= 6'b100000;
            nchange = 3'd0;
            end
            2'b11: nstate = 6'b010000;
        endcase
        end
        state[5]:begin
        nstate = 6'b000001;
        nchange = 3'b000;
        end
    endcase
end
endmodule