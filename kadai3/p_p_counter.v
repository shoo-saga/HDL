module p_p_counter(input clk, en,input [7:0] v, output b);
logic [7:0] counter;
logic [1:0] beep;
logic b;
always @(posedge clk or en) begin
    if(en) begin
        if(counter != 0)begin
                counter <= counter -1;
        end
        else begin
        beep <= beep +1;
        b <= 1;
        if (beep >2'b10)
        b <= 0;
        end
    end
    else begin
        counter <= v;
        beep <= 0;
        b <= 0;
    end
end
endmodule