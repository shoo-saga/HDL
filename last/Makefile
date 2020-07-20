all:
	iverilog -g2012  sw.v ib.v ibsm.v fifo.v mkwe.v arb.v cb.v cbsel.v ackor.v swtest.v
	vvp a.out
show:
	gtkwave sw.vcd
syn:
	yosys sw.ys
synsim:
	iverilog -gspecify -T typ gate.v swtest.v ../osu018_stdcells.v
	vvp a.out