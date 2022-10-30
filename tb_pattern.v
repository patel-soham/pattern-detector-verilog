//`include "pattern.v"
`include "pattern1.v"

module tb;

reg clk, rst, valid, in;
wire out;

pattern dut (.clk(clk), .rst(rst), .valid(valid), .in(in), .out(out));

always #1 clk = ~clk;

initial begin
	clk = 0;
	rst = 1;
	valid = 0;
	in = 0;
	repeat (5) @ (posedge clk);
	rst = 0;

	valid = 1;
	repeat (400) @ (posedge clk) begin
		in = $random;
	end
	

	$finish;
end

endmodule
