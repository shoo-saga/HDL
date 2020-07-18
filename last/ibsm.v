module ibsm(input [9:0] pkto,output logic re,input empty,
output logic [3:0] req,input ack,input clk,input rst);

logic [2:0] state,nstate;

always@(posedge clk or posedge rst)begin
    if (rst)begin
        state <= 3'b001;
    end
    else begin
        state <= nstate;
    end
end


    always_comb begin
    nstate = 3'b001;
    req  = 4'b0000;
    re = 1'b0;
    case(1)
    // synopsys full_case parallel_case
        state[0]:begin
            if (pkto[9:8] == 2'b10)begin
            case(pkto[1:0])
            //sysnopsys full_case parallel_case
            2'b00:req = 4'b0001;
            2'b01:req = 4'b0010;
            2'b10:req = 4'b0100;
            2'b11:req = 4'b1000;
            endcase
            nstate = 3'b010;
            end
        end
        state[1]:begin
            if (ack == 1'b1)begin
            nstate = 3'b100;
            req  = 4'b0000;
            re = 1'b1;
            end
        end
        state[2]:begin
            re = 1'b1;
            if (empty ==1'b1)begin
            nstate =3'b001;
            re = 1'b0;
            end
        end
    endcase
end
endmodule