`include "pu.vh"
`define DEBUG
//`define DEBUG2

module dec(input [`CMDS:0] o, output logic h, we, output logic [`RASB:0] wad,
	output logic [`OPS:0] op, output logic [`RASB:0] brad, arad,
	output logic [`LICMDS:0] liop, output logic [`HALFWIDTH:0] iv,
	output logic pcwe, dmwe, dms, pcs, dstb,
	input ze, ca, sg);
/*
// F E D C B A 9 8 7 6 5 4 3 2 1 0
// 0 0 0 0 0 0 * * * * * * * * * 0 ; NOP (0) DSTB
// 0 0 0 0 0 0 * * * * * * * * * 1 ; HALT (1)
// 0 0 0 0 0 1 * * * * * * * * * * ; future reserved (PUSH, POP, SET(reg))
// 0 0 0 0 1 0 rw> F op--> a-> b-> ; CAL rw=ra,brad (F=0:NORM/1:DSTB) MV
// 0 0 0 0 1 1 * * * op--> a-> b-> ; EVA CAL ra,rb (F=0)/CMP ra,rb
// 0 0 0 1 0 0 f f p op--> a-> b-> ; JP/BR fp [ra op rb] (ff:NC,Z,C,S)
// 0 0 0 1 0 1 * * * * * * * * * * ; future reserved
// 0 0 0 1 1 0 F * * op--> a-> b-> ; SM [ra]=rb / SM [ra] = [ra op rb] *MM
// 0 0 0 1 1 1 rw> F op--> a-> b-> ; LM rw=[ra op rb] / LM rw=[rb] *MM
// 0 0 1 # rw> a-> im------------> ; CAL rw=ra,im (#=0:ADD/1:SUB only)
// 0 1 0 p 0 * f f im------------> ; JP/BR fp [(s)im]
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
// 1 1 * * * * * * * * * * * * * * ; future reserved *MM
*/

	parameter THU =2'b00, IMM =2'b01, LIL =2'b10 ,LIH =2'b11;
	parameter UC =2'b00, ZE =2'b01, CA =2'b10, SG =2'b11;
	logic f1, f2;
	always @* begin
		f1 = `NEGATE;
		f2 = `NEGATE;
		case(o[9:8])
		// synopsys full_case parallel_case
		UC: begin
			f1 = `ASSERT;
			f2 = `ASSERT;
		end
		ZE: begin
			f1 = ~ze^o[7];
			f2 = ~ze^o[12];
		end
		CA: begin
			f1 = ~ca^o[7];
			f2 = ~ca^o[12];
		end
		SG: begin
			f1 = ~sg^o[7];
			f2 = ~sg^o[12];
		end
		endcase
	end

	always @* begin
		h = `NEGATE;
		arad = 0;
		brad = 0;
		op = `THB;
		we = `NEGATE;
		wad = 0;
		liop = THU;
		iv = 0;
		dstb = `NEGATE;
		pcwe = `NEGATE;
		dmwe = `NEGATE;
		dms = `NEGATE;
		pcs = `NEGATE;
		case(o[15:13])
		//synopsys full case parallel case
			3'b000:begin
				case(o[12:11])
				// synopsys full_case parallel_case
					2'b00:
					if(o[0]) h = `ASSERT;
// 0 0 0 0 0 0 * * * * * * * * * 1 ; HALT (1)
					else dstb = `ASSERT;
// 0 0 0 0 0 0 * * * * * * * * * 0 ; NOP (0) DSTB
					2'b01: begin
						arad = o[3:2];
						brad = o[1:0];
						op = o[6:4];
// 0 0 0 0 1 1 * * * op--> a-> b-> ; EVA CAL ra,rb (F=0)/CMP ra,rb
						if(o[10] == `NEGATE)begin
							wad = o[9:8];
							we = `ASSERT;
// 0 0 0 0 1 0 rw> F op--> a-> b-> ; CAL rw=ra,rb (F=0:NORM) MV
						end
					end
					2'b10:begin
						arad = o[3:2];
						brad = o[1:0];
						op = o[6:4];
					if(f1== `ASSERT) pcwe = `ASSERT;
// 0 0 0 1 0 0 f f p op--> a-> b-> ; JP/BR fp [ra op rb] (ff:NC,Z,C,S)
					end
					2'b11:begin
						if(o[10])begin
						wad = o[9:8];
						we = `ASSERT;
						op = o[6:4];
						arad = o[3:2];
						brad = o[1:0];
						dms = `ASSERT;
					end
// 0 0 0 1 1 1 rw> F op--> a-> b-> ; LM rw=[ra op rb] / LM rw=[rb] *MM
				else begin
					dmwe = `ASSERT;
					arad = o[3:2];
					brad = o[1:0];
					liop = IMM;
					iv = 8'd0;
					op = o[6:4];
				end
// 0 0 0 1 1 0 F * * op--> a-> b-> ; SM [ra]=rb / SM [ra] = [ra op rb] *MM
				end
				endcase
			end
			3'b001:begin
					wad = o[11:10];
					we = `ASSERT;
					arad = o[9:8];
					liop = IMM;
					iv = o[`HALFWIDTH:0];
					if(o[12]) op = 3'b001;
					else op = 3'b000;
			end
// 0 0 1 # rw> a-> im------------> ; CAL rw=ra,im (#=0:ADD/1:SUB only)
			3'b010:begin
				if(o[11] == 0)begin
					liop = IMM;
					iv = o[`HALFWIDTH:0];
					if(f2 == `ASSERT) pcwe = `ASSERT;
				end
// 0 1 0 p 0 * f f im------------> ; JP/BR fp [(s)im]
				else begin
					if(o[10])begin
						pcs = `ASSERT;
						liop = IMM;
						iv = o[`HALFWIDTH:0];
						op = 3'b000; //add
						if(f2 == `ASSERT) pcwe = `ASSERT;
					end
// 0 1 0 p 1 1 f f im------------> ; JP/BR fp [PC + (s)im]
					else begin
						dmwe = `ASSERT;
						brad = o[9:8];
						liop = IMM;
						iv = o[`HALFWIDTH:0];
					end
// 0 1 0 * 1 0 b-> im------------> ; SM [(s)im]=rb *MM
				end
			end

			3'b011:begin
				arad = o[11:10];
				liop = IMM;
				iv = o[`HALFWIDTH:0];
				op = 3'b000; //add
				if(f2 == `ASSERT) pcwe = `ASSERT;
			end
// 0 1 1 p a-> f f im------------> ; JP/BR fp [ra + (s)im]
			3'b100:begin
				if(o[12])begin //LM[im]
							wad = o[11:10];
							we = `ASSERT;
							liop = IMM;
							iv = o[`HALFWIDTH:0];
							dms = `ASSERT;
				end
// 1 0 0 1 rw> * * im------------> ; LM rw=[im] *MM
				else begin
					case(o[9:8])
							// synopsys full_case parallel_case
					2'b01:begin
						liop = o[9:8];
						iv = o[`HALFWIDTH:0];
						wad = o[11:10];
						we = `ASSERT;
					end
// 1 0 0 0 rw> 0 1 im------------> ; LI rw,(s)im (rw=rb) lidx=o[9:8]
					2'b10:begin
						brad = o[11:10];
						wad = o[11:10];
						we =  `ASSERT;
						liop = LIL;
						iv = o[`HALFWIDTH:0];
					end
// 1 0 0 0 rw> 1 0 im------------> ; LIL rw,im (rw=rb)
					2'b11:begin
						brad = o[11:10];
						wad = o[11:10];
						we =  `ASSERT;
						liop = LIH;
						iv = o[`HALFWIDTH:0];
					end
// 1 0 0 0 rw> 1 1 im------------> ; LIH rw,im (rw=rb)
					endcase
				end
			end
			3'b101:begin
				if(o[12])begin
					dmwe = `ASSERT;
					arad = o[11:10];
					brad = o[9:8];
					liop = IMM;
					iv = o[`HALFWIDTH:0];
					op = 3'b000;
				end
// 1 0 1 1 a-> b-> im------------> ; SM [ra + (s)im]=rb
				else begin
					wad = o[11:10];
					we = `ASSERT;
					arad = o[9:8];
					liop = IMM;
					iv = o[`HALFWIDTH:0];
					op = 3'b000;//add
					dms = `ASSERT;
				end
// 1 0 1 0 rw> a-> im------------> ; LM rw=[ra + (s)im]
			end
		endcase
	end
endmodule
