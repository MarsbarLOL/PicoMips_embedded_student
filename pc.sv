module pc #(parameter Psize = 6) // up to 64 instructions
(input logic clk, SW9, PCincrSW8,
 ///input logic startinput,
 
 output logic [Psize-1 : 0]PCout
);



//------------- code starts here---------
logic[Psize-1:0] Rbranch; // temp variable for addition operand
logic [Psize-1:0] Branchaddr = 6'b000000;

always_comb
  if (PCincrSW8)
       Rbranch = { {(Psize-1){1'b0}}, 1'b1};
  else Rbranch =  Branchaddr;

always_ff @ ( posedge clk or posedge SW9) 

   if (SW9) // sync reset
     PCout <= {Psize{1'b0}};
  else if (PCincrSW8 ) 
     PCout <= PCout + Rbranch; // 1 adder does both
  

endmodule // module pc