// 10110 Pattern Detector Verilog Code
module pattern(clk, rst, valid, in, out);
parameter RST=3'b000,
		  S1=3'b001,
		  S10=3'b010,
		  S101=3'b011,
		  S1011=3'b100,
		  S10110=3'b101;

input clk, rst, valid, in;
output out;

reg [2 : 0] cs, ns;

// For Moore
//assign out = (cs == S10110) ? 1 : 0;
//OR
/*reg out;
always @ (cs) begin
	case (cs)
		RST: out = 0;
		S1: out = 0;
		S10: out = 0;
		S101: out = 0;
		S1011: out = 0;
		S10110: out = 1;
	endcase
end*/

always @ (posedge clk) begin
	if (rst == 1) cs <= RST;
	else cs <= ns;
end

// For Melay
// the below assign statements will cause spikes of out on unwanted situations 
// also output will be observed on same cycle
//assign out = (cs==S1011 && in==0) ? 1 : 0;
// OR
// This works best and output will be on next cycle like normal
// also this will have no unwanted spikes of out
reg out;
always @ (posedge clk) begin // do not keep cs, in in sensitivity list
// that will also result in spikes before posedge of clk and output will be on same cycle
	if (cs==S1011 && in==0) out <= 1;
	else out <= 0;
end
// Best for Melay combined
/*always @ (posedge clk) begin
	if (rst == 1) begin
		cs <= RST;
		out <= 0;
	end
	else begin 
		cs <= ns;
		out <= (cs==S1011 && in==0) ? 1 : 0;
	end
end
*/
always @ (cs, in) begin
	if (valid == 1) begin
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
			// For Moore
			//else ns = S10110;
			// For Melay 
			else ns = RST;
		end
		// Remove for Melay
		/*S10110: begin
			if (in == 1) ns = S1;
			else ns = RST;
		end*/
		default: begin
			ns = RST;
		end
	endcase
	end
	else begin
			ns = RST;
	end
end

endmodule
