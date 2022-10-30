module pattern(clk, rst, valid, in, out);
parameter RST=3'b000,
		  S1=3'b001,
		  S10=3'b010,
		  S101=3'b011,
		  S1011=3'b100,
		  S10110=3'b101;

input clk, rst, valid, in;
output reg out;

reg [2 : 0] cs, ns;


// Here cs and ns are same values as they move together
/*always @ (posedge clk) begin
	if (rst == 1) begin
		out = 0;
		cs = RST;
		ns = RST;
	end
	else begin
		if (valid == 1) begin
		out = 0;
			case (cs)
				RST: begin
					if (in == 1) ns = S1;
					else ns = RST;
				end
				S1: begin
					if (in == 1) ns = S1;
					else ns = S10;
				end
				S10: begin
					if (in == 1) ns = S101;
					else ns = RST;
				end
				S101: begin
					if (in == 1) ns = S1011;
					else ns = S10;
				end
				S1011: begin
					if (in == 1) ns = S1;
					// for Moore
					//else ns = S10110;
					// for Melay
					else begin
						ns = RST;
						out = 1;
					end
				end
				// remove this state for Melay
				/*S10110: begin
					out = 1;
					if (in == 1) ns = S1;
					else ns = RST;
				end
            	default: begin
					ns = RST;
					out = 0;
				end
			endcase
		end
		else begin
			out = 0;
		end
	end
end

always @ (ns) cs = ns;
*/

// The above code works same as below without even using ns
always @ (posedge clk) begin
	if (rst == 1) begin
		out = 0;
		cs = RST;
	end
	else begin
		if (valid == 1) begin
		out = 0;
			case (cs)
				RST: begin
					if (in == 1) cs = S1;
					else cs = RST;
				end
				S1: begin
					if (in == 1) cs = S1;
					else cs = S10;
				end
				S10: begin
					if (in == 1) cs = S101;
					else cs = RST;
				end
				S101: begin
					if (in == 1) cs = S1011;
					else cs = S10;
				end
				S1011: begin
					if (in == 1) cs = S1;
					// for Moore
					//else cs = S10110;
					// for Melay
					else begin
						cs = RST;
						out = 1;
					end
				end
				// remove this state for Melay
				/*S10110: begin
					out = 1;
					if (in == 1) cs = S1;
					else cs = RST;
				end*/
            	default: begin
					cs = RST;
					out = 0;
				end
			endcase
		end
		else begin
			out = 0;
		end
	end
end

endmodule

