module arb(input req0,req1,req2,req3, output logic ack0,ack1,ack2,ack3, input clk, input rst);

logic [2:0] state;
logic req;

always_comb begin
    req = 0;
    if (req0||req1||req2||req3)
    req = 0;
    else
    req = 1;
end


always@(posedge clk or posedge rst)begin
    if (rst)begin
        ack0 <= 1'b0;
        ack1 <= 1'b0;
        ack2 <= 1'b0;
        ack3 <= 1'b0;
        state <= 2'b00;
    end
    else
    begin
    case(state)
    2'b00:begin
    if (req0) ack0 = 1'b1;
    else if (req1) ack1 = 1'b1;
    else if (req2) ack2 = 1'b1;
    else if (req3) ack3 = 1'b1;
    end
    2'b01:begin
    if (req1) ack1 = 1'b1;
    else if (req2) ack2 = 1'b1;
    else if (req3) ack3 = 1'b1;
    else if (req0) ack0 = 1'b1;
    end
    2'b10:begin
    if (req2) ack2 = 1'b1;
    else if (req3) ack3 = 1'b1;
    else if (req0) ack0 = 1'b1;
    else if (req1) ack1 = 1'b1;
    end
    2'b11:begin
    if (req3) ack3 = 1'b1;
    else if (req0) ack0 = 1'b1;
    else if (req1) ack1 = 1'b1;
    else if (req2) ack2 = 1'b1;
    end
    endcase
    end
end

always@(posedge req)begin
    state <= state +1;
    ack0 <= 1'b0;
    ack1 <= 1'b0;
    ack2 <= 1'b0;
    ack3 <= 1'b0;
end

endmodule