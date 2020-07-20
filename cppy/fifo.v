module fifo(input logic [9:0] pkti, input we,
output logic full, output logic  [9:0]pkto, input re, output logic empty, input clk, rst);
logic [9:0] mem[15:0];
logic [3:0] head, tail, headi;
always@(posedge clk or posedge rst)begin
    if(rst) begin
        head <= 0;
        tail <= 0;
    end else begin
        if(we) head <= head + 1;
        if(re) tail <= tail + 1;
    end
end
always @(posedge clk)
if(we) mem[head] <= pkti;
always_comb begin
    pkto = mem[tail];
    if(head == tail)begin
        empty = 1'b1;
        pkto = 0;
    end
    else empty = 1'b0;
    headi= head+1;
    if(tail == headi) full = 1'b1;
    else full = 1'b0;
end
endmodule