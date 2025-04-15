module test(clk, reset, N, D, open); 
  input clk, reset, N, D; 
  output open; 
  reg [1:0] ps, ns; 

  parameter zero = 2'b00, 
            five = 2'b01, 
            ten = 2'b10, 
            fifteen = 2'b11; 

  // Combinational logic
  always @(*) begin 
    case (ps)
      zero:     if (N) ns = five; 
                else if (D) ns = ten; 
                else ns = zero; 
					 
      five:     if (N) ns = ten; 
                else if (D) ns = fifteen; 
                else ns = five; 
					 
      ten:      if (N || D) ns = fifteen; 
                else ns = ten;
					 
      fifteen:  ns = fifteen; 
		
      default:  ns = zero; 
    endcase
  end 

  // Sequential logic
  always @(posedge clk) begin 
    if (reset) 
      ps <= zero; 
    else         
      ps <= ns; 
  end 

  assign open = (ps == fifteen); 
endmodule