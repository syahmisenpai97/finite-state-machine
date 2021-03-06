// State assignment
//parameter zero = 0, one1 = 1, two1s = 2;
module reduce (out, clk, reset, in);
output out;
input clk, reset;
input [3:0] in;
reg out;
reg [1:0] state; // state register
reg [1:0] next_state;
parameter zero = 0, one1 = 1, two1s = 2;

 always @(in or state)
	case (state)
		zero: begin // last input was a zero
		out = 0;
		if (in==4'b1101) next_state = one1;
		else next_state = zero;
	end
	
	one1: begin // we've seen one 1
		out = 0;
		if (in==4'b1101) next_state = two1s;
		else next_state = zero;
	end
	
	two1s: begin // we've seen at least 2 ones
		out = 1;
		if (in==4'b1101) next_state = two1s;
		else next_state = zero;
	end
	
	default: begin // in case we reach a bad state
	out = 0;
	next_state = zero;
	end
	endcase
	
	// Implement the state register
 always @(posedge clk)
	if (reset) state <= zero;
	else state <= next_state;
endmodule