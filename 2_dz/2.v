


module complex_mult (
	input clk,  
	input signed  [7:0] Re_in_1, 
    input signed  [7:0] Re_in_2, 
    input signed  [7:0] Im_in_1, 
    input signed  [7:0] IM-in_2, 
    input signed [1:0] data_valid; 
    output signed  [7:0] Re_out, 
    output signed  [7:0] Im_out, 
);


endmodule

module mult (
	input clk, 
	input signed [7:0] num1,
	input signed [7:0] num2,
	output signed [7:0] res	
);

reg signed [7:0] mult;
reg signed [7:0] tmp;

always @(posedge clk) begin
	tmp <= num1 * num2;
	mult <= tmp;
end
assign res = mult;
endmodule