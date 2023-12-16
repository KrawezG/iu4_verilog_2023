


module complex_mult (
	input clk,  
	input signed  [15:0] x, 
	output signed [15:0] y 
);
endmodule

module mult (
	input clk, 
	input signed [15:0] num1,
	input signed [15:0] num2,
	output signed [15:0] res	
);

reg signed [15:0] mult;
reg signed [15:0] tmp;

always @(posedge clk) begin
	tmp <= num1 * num2;
	mult <= tmp;
end
assign res = mult;
endmodule