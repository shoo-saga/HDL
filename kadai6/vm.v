module vm(input a, b, clk, rst, output logic [2:0] change,output logic out);
logic [5:0] state , nstate;

    always@(posedge clk or posedge rst)begin
        if(rst)begin
            state <= 6'b100000;
        end
        else begin
            state <= nstate;
        end
    end

    always_comb begin

        nstate = 6'b100000;
        change = 3'b000;
        out = 0;
        case(1)
            // synopsys full_case parallel_case
            state[0]:begin
            case({a,b})
            // synopsys full_case parallel_case
                2'b00: nstate = 6'b000001;
                2'b01: nstate = 6'b100000;
                2'b10: nstate = 6'b000010;
                2'b11: nstate = 6'b000001;
            endcase
            end
            state[1]:begin
            case({a,b})
                // synopsys full_case parallel_case
                2'b00: nstate = 6'b000010;
                2'b01:begin
                    nstate = 6'b100000;
                    change = 3'd1;
                end
                2'b10: nstate = 6'b000100;
                2'b11: nstate = 6'b000010;
            endcase
            end
            state[2]:begin
            case({a,b})
                // synopsys full_case parallel_case
                2'b00: nstate= 6'b000100;
                2'b01:begin
                    nstate =6'b100000;
                    change = 3'd2;
                end
                2'b10: nstate = 6'b001000;
                2'b11: nstate = 6'b000100;
            endcase
            end
            state[3]:begin
            case({a,b})
                // synopsys full_case parallel_case
                2'b00: nstate= 6'b001000;
                2'b01:begin
                    nstate = 6'b100000;
                    change = 3'd3;
                end
                2'b10: nstate = 6'b010000;
                2'b11: nstate = 6'b001000;
            endcase
            end
            state[4]:begin
            case({a,b})
            // synopsys full_case parallel_case
                2'b00: nstate= 6'b010000;
                2'b01:begin
                nstate= 6'b100000;
                change = 3'd4;
                end
                2'b10:begin
                nstate= 6'b100000;
                change = 3'd0;
                end
                2'b11: nstate = 6'b010000;
            endcase
            end
            state[5]:begin
            nstate = 6'b000001;
            change = 3'b000;
            out = 1;
            end
        endcase
    end
endmodule