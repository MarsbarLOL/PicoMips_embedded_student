module prog #(parameter Psize = 6, Isize = 24) // psize - address width, Isize - instruction width
(input logic [5:0] address,
output logic [23:0] I); // I - instruction code

// program memory declaration, note: 1<<n is same as 2^n
logic [23:0] progMem[((1 << Psize)-1):0];

// get memory contents from file
initial
  $readmemh("prog.hex", progMem);
  
// program memory read 
always_comb
  I = progMem[address];
  
endmodule // end of module prog
