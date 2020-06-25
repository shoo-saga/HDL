module ledarray(input clk, st, rst,input [4:0] memory [31:0], output [4:0] dot);
logic [4:0] cnt;
logic enable;

assign dot = memory[cnt];

always@(posedge clk) begin
    if (rst) begin
        cnt <= 5'b0;
        enable <= 1'b0;
    end
    else begin
        if (enable)
        cnt <= cnt + 5'b1;
        else
        cnt <= 5'd0;
        if(st)
        enable <= 1'b1;
        else begin
        if(cnt==5'd31)
        enable <= 1'b0;
        else
        enable <= 1'b1;
        end
    end
end
endmodule

