// op is for melay and opm is for moore logic
module soham_seq(clk,ip,op,opm); //1010 detector using meelay state machine
input ip,clk;
output reg op,opm;
reg [1:0]s;
reg [2:0]s1;

initial begin
s=2'b00;
s1=3'b000;
op=0;
opm=0;
end

always @ (posedge clk) begin
case({s,ip})

3'b000:
begin
 s<=2'b00; 
 op<=0;
end

3'b001:
begin
 s<=2'b01; 
 op<=0;
end

3'b010:
begin
 s<=2'b10; 
 op<=0;
end

3'b011:
begin
 s<=2'b01; 
 op<=0;
end

3'b100:
begin
 s<=2'b00; 
 op<=0;
end

3'b101:
begin
 s<=2'b11; 
 op<=0;
end

3'b110:
begin
 s<=2'b10; 
 op<=1;
end

3'b111:
begin
 s<=2'b01; 
 op<=0;
end

endcase
end


always @ (posedge clk) begin
case({s1,ip})

4'b0000: 
begin
s1<=3'b000;
opm<=0;
end

4'b0001: begin
s1<=3'b001;
opm<=0;
end

4'b0010: begin
s1<=3'b010;
opm<=0;
end

4'b0011: begin
s1<=3'b001;
opm<=0;
end




4'b0100: begin
s1<=3'b000;
opm<=0;
end

4'b0101: begin
s1<=3'b011;
opm<=0;
end


4'b0110: begin
s1<=3'b100;
opm<=0;
end

4'b0111: begin
s1<=3'b001;
opm<=0;
end



 4'b1000:begin
s1<=3'b000;
opm<=1;
end

4'b1001:begin
s<=3'b011;
	 opm<=1;
end

endcase 
end

endmodule

