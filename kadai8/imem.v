`include "pu.vh"
module imem(input [`PCS:0] pc, output logic [`CMDS:0] o);
	always_comb
		case(pc)
		// synopsys full_case parallel_case
			6'h00:o = 16'b1000_0001_0000_0011; //LI rw,(s)im (rw= 0) lidx= THU, r0<- 3
            6'h01:o = 16'b0100_1000_0000_0000; //SM [(s)im]= 16'd0 *MM nn, mem[0]<-3
            6'h02:o = 16'b1000_0101_0000_0000; //LI rw,(s)im (rw= 1) lidx= THU,r1<-0
            6'h03:o = 16'b0100_1001_0000_0001; //SM [(s)im]= 16'd1 *MM nn, mem[1]<-r1
            6'h04:o = 16'b1000_1001_0000_0010; //LI rw,(s)im (rw= 2) lidx= THU, r2<-2
            6'h05:o = 16'b0100_1010_0000_0010; //SM [(s)im]= 16'd2 *MM nn, mem[2]<-r2
            6'h06:o = 16'b1001_0000_0000_1110; //SM [ra + (s)im]=rb, mem[17]<-r0

            6'h07:o = 16'b0000_1011_0000_0001; //CAL rw= 16'bra,rb (F= 16'b0:NORM)  r3<-r0+r1
            6'h08:o = 16'b1001_0000_0001_0001; //LM rw=[im] *MM, r0<-mem[17]
            6'h09:o = 16'b0001_1000_0010_0011; //SM [ra]=rb, mem[ro]<-r3
            6'h0a:o = 16'b1000_1001_0000_1111; //LI rw,(s)im (rw= r2) lidx= THU, r2<-15
            6'h0b:o = 16'b0001_0001_1001_0010; //JP/BR fp [ra op rb] r0, r2(ff:NC,Z,C,S)

            6'h0c:o = 16'b0010_0000_0000_0001; // CAL rw=ra,im, r0=r0+1
            6'h0d:o = 16'b0100_1001_0000_0001; //SM [(s)im]= 16'd1 *MM nn, mem[17]=r0
            6'h0e:o = 16'b0000_1010_0010_0011; //CAL rw=brad, r2=r3
            6'h0f:o = 16'b1010_0001_1111_1110; // LM rw=[ra + (s)im], r1 <-mem[r0-2]
            6'h10:o = 16'b1010_0000_1111_1101; //LM rw=[ra + (s)im], r0 <-mem[r0-3]
            6'h11:o = 16'b0100_1100_1111_0110; //JP/BR fp [PC + (s)im]
            6'h12:o = 16'b0000_0000_0000_0001; //HALT*/
		endcase
endmodule

/*
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 0 0 0 0 0 0 * * * * * * * * * 0 ; NOP (0) DSTB
// 0 0 0 0 0 0 * * * * * * * * * 1 ; HALT (1)
// 0 0 0 0 0 1 * * * * * * * * * * ; future reserved (PUSH, POP, SET(reg))
// 0 0 0 0 1 0 rw> F op--> a-> b-> ; CAL rw=ra,rb (F=0:NORM/1:DSTB) MV
// 0 0 0 0 1 1 * * * op--> a-> b-> ; EVA CAL ra,rb (F=0)/CMP ra,rb
// 0 0 0 1 0 0 f f p op--> a-> b-> ; JP/BR pf [ra op rb] (ff:NC,Z,C,S)
// 0 0 0 1 0 1 * * * * * * * * * * ; future reserved
// 0 0 0 1 1 0 F * * op--> a-> b-> ; SM [ra]=rb / SM [ra] = [ra op rb] *MM
// 0 0 0 1 1 1 rw> F op--> a-> b-> ; LM rw=[ra op rb] / LM rw=[rb] *MM
// 0 0 1 # rw> a-> im------------> ; CAL rw=ra,im (#=0:ADD/1:SUB only)
// 0 1 0 p 0 * f f im------------> ; JP/BR pf [(s)im]
// 0 1 0 * 1 0 b-> im------------> ; SM [(s)im]=rb *MM
// 0 1 0 p 1 1 f f im------------> ; JP/BR fp [PC + (s)im]
// 0 1 1 p a-> f f im------------> ; JP/BR fp [ra + (s)im]
// 1 0 0 0 rw> 0 0 0 0 0 0 0 S C Z ; LI rw,SM S:sign C:carry Z:zero
// 1 0 0 0 rw> 0 1 im------------> ; LI rw,(s)im (rw=rb) lidx=o[9:8]
// 1 0 0 0 rw> 1 0 im------------> ; LIL rw,im (rw=rb)
// 1 0 0 0 rw> 1 1 im------------> ; LIH rw,im (rw=rb)
// 1 0 0 1 rw> * * im------------> ; LM rw=[im] *MM
// 1 0 1 0 rw> a-> im------------> ; LM rw=[ra + (s)im]
// 1 0 1 1 a-> b-> im------------> ; SM [ra + (s)im]=rb
// 1 1 0 * * * * * * * * * * * * * ; future reserved *MM
// 1 1 1 * * * * * * * * * * * * * ; future reserved *MM (debug)
//
// ALU  000:ADD, 001:SUB, 010:THB, 011:ASR,
//      100:RSL, 101:RSL, 110:NAD, 111:XOR
//
// COND(ff) 00:UC 01:ZE 10:CA 11:SG
// P/N (p)  0:N(!=) 1:P(==)
//
// EX: Positive Zero => PZ
//
// SPECIALS
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 0 0 0 0 1 0 rw> 0 0 1 0 0 0 b-> ; MV rw=rb
// 1 0 0 0 rw> 0 1 0 0 0 0 0 0 0 0 ; RESET rw (LI rw=0)
// 0 0 1 0 rw> rw> 0 0 0 0 0 0 0 1 ; INC rw
// 0 0 1 1 rw> rw> 0 0 0 0 0 0 0 1 ; DEC rw
// 0 0 1 0 rw> ra> 0 0 0 0 0 0 0 1 ; INC rw=ra (rw = ra+1)
// 0 0 1 1 rw> ra> 0 0 0 0 0 0 0 1 ; DEC rw=ra (rw = ra-1)
// 0 0 0 0 1 1 * * * 0 0 1 a-> b-> ; CMP ra,rb (EVA SUB ra,rb)
*/
