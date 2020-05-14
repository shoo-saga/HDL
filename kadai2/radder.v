module radder(input [3:0] a, b, output [3:0] s, output co);
logic [3:0] c;
assign c[0] = 0;
fadder f0(a[0] ,b[0] ,c[0], s[0], c[1]);
fadder f1(a[1] ,b[1] ,c[1], s[1], c[2]);
fadder f2(a[2] ,b[2] ,c[2], s[2], c[3]);
fadder f3(a[3] ,b[3] ,c[3], s[3], co);
endmodule