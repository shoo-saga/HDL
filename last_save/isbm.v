module isbm(input [1:0] pkto,output logic re,input empty,
input [3:0] reqi,output logic [3:0] req,input ack,input clk,input rst);

logic [1:0] state,nstate;

always@(posedge clk or posedge rst)begin
    if (rst)begin
        state <= 2'b00;
    end
    else begin
        state <= nstate;
    end
end


    always_comb begin
    nstate = 2'b00;
    req  = 4'b0000;
    re = 1'b0;
    case(state)
    // synopsys full_case parallel_case
        2'b00:begin
            if (pkto == 2'b10)begin
            nstate = 2'b01;
            req = reqi;
            end
        end
        2'b01:begin
            req = reqi;
            if (ack == 1'b1)begin
            nstate = 2'b10;
            req  = 4'b0000;
            re = 1'b1;
            end
        end
        2'b10:begin
            re = 1'b1;
            if (empty ==1'b1)begin
            nstate =2'b00;
            re = 1'b0;
            end
        end
        default:nstate = 2'b00;
    endcase
end
endmodule