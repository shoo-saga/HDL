module pu(output we, output logic [15:0] rwd, input clk, rst);
	logic [15:0] a, b, ao, bo, lp, mrd;
	logic [7:0] iv;
	logic [1:0] arad, brad, wad;
	logic [2:0] op;
	logic [5:0] pca;
	logic [15:0] o;
	logic [1:0] liop;
	rega rega(arad, brad, a, b, we, wad, rwd, clk, rst);
	sel asel(a, {{(15-5){1'b0}},pca}, pcs, ao);
	lidx lidx(b, iv, liop, bo);
	alu alu(ao, bo, op, lp, dstb, ze, ca, sg, clk, rst);
	pc pc(h, pca, pcwe, rwd[5:0], clk, rst);
	imem imem(pca, o);
	dec dec(o, h, we, wad, op, brad, arad, liop, iv,
		pcwe, dmwe, dms, pcs, dstb, ze, ca, sg);
	dmem dmem(lp[7:0], b, dmwe, mrd, clk);
	sel dsel(lp, mrd, dms, rwd);
endmodule

