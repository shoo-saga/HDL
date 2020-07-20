module arb(input req0,req1,req2,req3, output logic ack0,ack1,ack2,ack3, input clk, input rst);

logic [2:0] state, nstate;

always@(posedge clk or posedge rst)begin
    if (rst)begin
        ack0 <= 1'b0;
        ack1 <= 1'b0;
        ack2 <= 1'b0;
        ack3 <= 1'b0;
        state <= 2'b00;
        nstate <= 2'b00;
    end
    else
    begin
    state <= nstate;
    case(state)
    2'b00:begin
    if (req0)begin
        ack0 <= 1'b1;
        ack1 <= 1'b0;
        ack2 <= 1'b0;
        ack3 <= 1'b0;
    end
    else begin
        if (req1) begin
            ack0 <= 1'b0;
            ack1 <= 1'b1;
            ack2 <= 1'b0;
            ack3 <= 1'b0;
        end
        else begin
            if (req2)begin
                ack0 <= 1'b0;
                ack1 <= 1'b0;
                ack2 <= 1'b1;
                ack3 <= 1'b0;
            end
            else begin
                if (req3) begin
                ack0 <= 1'b0;
                ack1 <= 1'b0;
                ack2 <= 1'b0;
                ack3 <= 1'b1;
                end
                else begin
                ack0 <= 1'b0;
                ack1 <= 1'b0;
                ack2 <= 1'b0;
                ack3 <= 1'b0;
                nstate = 2'b01;

                end
                end
            end
        end
    end
    2'b01:begin
    if (req1) begin
        ack0 <= 1'b0;
        ack1 <= 1'b1;
        ack2 <= 1'b0;
        ack3 <= 1'b0;
    end
    else begin
        if (req2)begin
            ack0 <= 1'b0;
            ack1 <= 1'b0;
            ack2 <= 1'b1;
            ack3 <= 1'b0;
        end
        else begin
            if (req3) begin
                ack0 <= 1'b0;
                ack1 <= 1'b0;
                ack2 <= 1'b0;
                ack3 <= 1'b1;
            end
            else begin
                if (req0)begin
                    ack0 <= 1'b1;
                    ack1 <= 1'b0;
                    ack2 <= 1'b0;
                    ack3 <= 1'b0;
                    end
                else begin
                ack0 <= 1'b0;
                ack1 <= 1'b0;
                ack2 <= 1'b0;
                ack3 <= 1'b0;
                nstate = 2'b10;

                end
            end
        end
    end
    end
    2'b10:begin
    if (req2)begin
        ack0 <= 1'b0;
        ack1 <= 1'b0;
        ack2 <= 1'b1;
        ack3 <= 1'b0;
    end
    else begin
        if (req3) begin
            ack0 <= 1'b0;
            ack1 <= 1'b0;
            ack2 <= 1'b0;
            ack3 <= 1'b1;
        end
        else begin
            if (req0)begin
                ack0 <= 1'b1;
                ack1 <= 1'b0;
                ack2 <= 1'b0;
                ack3 <= 1'b0;
            end
            else begin
                if (req1) begin
                    ack0 <= 1'b0;
                    ack1 <= 1'b1;
                    ack2 <= 1'b0;
                    ack3 <= 1'b0;
                    end
                else begin
                ack0 <= 1'b0;
                ack1 <= 1'b0;
                ack2 <= 1'b0;
                ack3 <= 1'b0;
                nstate = 2'b11;

                end
            end
        end
    end
    end
    2'b11:begin
   if (req3) begin
        ack0 <= 1'b0;
        ack1 <= 1'b0;
        ack2 <= 1'b0;
        ack3 <= 1'b1;
    end
    else begin
        if (req0)begin
            ack0 <= 1'b1;
            ack1 <= 1'b0;
            ack2 <= 1'b0;
            ack3 <= 1'b0;
        end
        else begin
            if (req1) begin
                ack0 <= 1'b0;
                ack1 <= 1'b1;
                ack2 <= 1'b0;
                ack3 <= 1'b0;
            end
            else begin
                if (req2)begin
                    ack0 <= 1'b0;
                    ack1 <= 1'b0;
                    ack2 <= 1'b1;
                    ack3 <= 1'b0;
                end
                else begin
                ack0 <= 1'b0;
                ack1 <= 1'b0;
                ack2 <= 1'b0;
                ack3 <= 1'b0;
                nstate = 2'b00;
                end
            end
        end
    end
    end
    endcase
end
end

endmodule