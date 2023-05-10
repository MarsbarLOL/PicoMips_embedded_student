`include "alucodes.sv"
`include "opcodes.sv"
//---------------------------------------------------------
module decoder #(parameter n=8)
( 
//input
input logic [3:0] opcode, 
input logic sw8,
//output
output logic [1:0] ALUfunc, 
output logic imm_switch_or_pm,imm_pm,
output logic pc_start
  );
   
always_comb 
begin
	ALUfunc = 2'b00;
	imm_switch_or_pm = 1'b0; 
	imm_pm = 1'b0; 
	pc_start = 1'b1;
	
   case(opcode)
     `Store: ALUfunc = 2'b00 ;									
	 `INPM: begin                            
			imm_switch_or_pm = 1'b1; 
			imm_pm = 1'b1; 
			ALUfunc = 2'b01;    
			end
	 `INSW: begin          					
			pc_start = sw8;
			imm_switch_or_pm = 1'b1; 
			imm_pm = 1'b0; 
			ALUfunc = 2'b01;    
			end
	 
    `ADD: begin // add Rs_data				
			ALUfunc = 2'b10;	
	      end
	`ADDI: begin // add PM					
			ALUfunc = 2'b10;
			imm_switch_or_pm = 1'b1; 
			imm_pm = 1'b1; 
			
	      end
    `MUL: begin // mul Rs_data			
			ALUfunc = 2'b11;
	      end
	`MULI: begin // register-immediate from the pm 				
			ALUfunc = 2'b11;
			imm_switch_or_pm = 1'b1; 
			imm_pm = 1'b1; 
		  
	      end 	  
	`SW80: begin
			pc_start = ~sw8; // when sw8 is 0, pc start counting 
			end
	`SW81: begin
			pc_start = sw8; // when sw8 is 1, pc start counting 
			end
	default:
	    $error("unimplemented opcode %h",opcode);
 
  endcase // opcode
  
end // always_comb


endmodule //module decoder --------------------------------