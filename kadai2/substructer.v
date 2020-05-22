module substructer(input [3:0] a, b, output[3:0]s, output co);
logic [3:0] c;
logic d;
radder f0(4'b0001,~b,c,d);
radder fo(a,c,s,co);
endmodule