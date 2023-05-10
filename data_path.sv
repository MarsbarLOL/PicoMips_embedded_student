
module picomips #(parameter n = 8,
					parameter Psize = 6, 
					parameter Isize = 24 
				) 
				( 
					//input
					input wire clk,   //only for the regs and the program counter
					input  logic  [9:0]SW,        //Input switch
					//output
					output   signed [7:0]  LED 	//output switch
				);
		

wire write1_regs;
wire [1:0] alufunc_wire;
wire [1:0] alufunc;
wire signed [7:0] rega,regb;


wire signed [5:0] resultpc;

wire signed [7:0] resultalu;
wire signed [7:0] resultmux;

wire logic clock_control;
wire logic imm_pwwire;
wire logic imm_switch_or_pmwire;

var logic switch9;
var logic switch8;

wire logic [23:0] code_decoder_addr1_2;
var logic [3:0] opcode;
var signed [7:0] instruction_pm;
var logic [3:0] addr1,addr2,addr3;

assign LED = resultalu;
assign alufunc = alufunc_wire;
assign switch9 = SW[9];
assign switch8 = SW[8];

assign opcode = code_decoder_addr1_2 [23:20];
assign instruction_pm = code_decoder_addr1_2 [7:0];
assign addr1 = code_decoder_addr1_2 [19:16];
assign addr2 = code_decoder_addr1_2 [15:12];
assign addr3 = code_decoder_addr1_2 [11:8];

decoder 
		#(
			.n(n)
		)
		de
		(  
			//input 
			.opcode(opcode),
			.sw8 (switch8),
			//output
			.imm_switch_or_pm (imm_switch_or_pmwire),
			.imm_pm(imm_pwwire),
			.pc_start(clock_control),
			.ALUfunc(alufunc_wire)
			

		);

regs
		#(
			.n(n)
		)
		re
		(
			//input 
			.clk(clk),
			.Wdata(resultalu),
			.Raddr1(addr1),
			.Raddr2(addr2),
			.Raddr3(addr3),
			//Output
			.Rd_data(rega),
			.Rs_data(regb)
		);
alu
		#(
			.n(n)
		)
		al
		(
			//input
			.a(rega),
			.b(resultmux),
			.func(alufunc),
			//output
			.result(resultalu)
		);
mux_assign 
		#(
			.n(n)
		)
		mux
		(
			//input	
			.Rs_data(regb),
			.sw_7_to_0(SW[7:0]),
			.instruction_pm(instruction_pm),
			.imm_switch_or_pm(imm_switch_or_pmwire),
			.imm_pm(imm_pwwire),
			//output 
			.out(resultmux)
		);
pc
		#(
			.Psize(Psize)
		)
		programconter( 
			//input
			.clk(clk),
			.SW9(switch9),
			.PCincrSW8(clock_control),	
			//output
			.PCout(resultpc)
		);
prog
		#(
			.Psize(Psize),
			.Isize(Isize)
		)
		ProgramMemories
		(
			//input 
			.address(resultpc),
			//output
			.I(code_decoder_addr1_2)
		);
endmodule 