module reduce (clk, reset, in, out);
 input clk, reset; 
 output out;
 input [3:0] in;
 reg out; 
 reg state; // state register
 reg next_state;
 parameter zero = 0, one = 1;
 
 always @(in or state)
	case (state)
		zero: begin // last input was a zero
			if (in==4'b1101) next_state = one;
			else next_state = zero;
			out = 0;
		end
	one: // we've seen one 1
		if (in==4'b1101) begin
			next_state = one;
			out = 1;
		end
		else begin
			next_state = zero;
			out = 0;
			end
	endcase
 always @(posedge clk)
	if (reset) state <= zero;
	else state <= next_state;
 endmodule