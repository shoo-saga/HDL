module p_p_counter(input clk, en,[7:0] v, output b);
logic [7:0] counter;
logic [1:0] beep;
always @(posedge clk or en) begin
    if(en) begin
        if(counter != 0)begin
                counter <= counter -1;
        end
        else begin
        beep <= beep +1;
        b <= 0;
        if (beep >2'b11)
        b <= 0;
        end
    end
    else begin
        counter <= v;
    end
end