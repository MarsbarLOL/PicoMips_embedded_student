
module mux_assign #(parameter n = 8)
						(
						//input
						input logic signed [n-1:0] Rs_data,                   
                        input  [7:0] sw_7_to_0,  
						input logic signed [7:0] instruction_pm, 
                        input logic imm_switch_or_pm,imm_pm,   
						//output						 
                         output  logic signed [7:0] out);            
  
  // when imm_switch_or_pm is 0, then will be Rs_data, 
  // when imm_pm is 1 and imm_switch_or_pm is 1, = instruction_pm
   assign out = imm_switch_or_pm ? (imm_pm ? instruction_pm : sw_7_to_0[7:0])  : Rs_data;    
  
endmodule  