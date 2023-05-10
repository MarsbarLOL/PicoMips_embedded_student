module regs #(parameter n = 8) // n - data bus width
(input logic clk,           
 input logic signed [n-1:0] Wdata, 
 input logic [3:0] Raddr1, Raddr2,Raddr3,  // Program addr 
 output logic signed [n-1:0] Rd_data, Rs_data);

 	// Declare 32 n-bit registers 
	logic [n-1:0] gpr [31:0];

	always_ff @ (posedge clk)
	begin
            gpr[Raddr1] <= Wdata;   //Write data into Raddr1 , Read data from Raddr1 & 2.
	end

	always_comb
	begin
		Rd_data = gpr[Raddr2];
		Rs_data = gpr[Raddr3];
	end	
	

endmodule // module regs