`include "alucodes.sv"
`include "opcodes.sv"

module alu #(parameter n=8)(

input  logic signed [n-1 :0] a,b,
input logic  [1:0] func,
output logic signed [7 :0] result
);

logic signed  [15:0] mult_out;

assign mult_out = a * b;

always_comb
begin 


unique case (func) 
	
	`RA : result = a;
	`RB : result = b; 
	`RADD : result = a + b; 
	`R_mul : result <= mult_out [14:7];

endcase  

end 
endmodule 
