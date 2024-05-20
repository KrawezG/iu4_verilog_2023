`timescale 1ns / 1ns

module IIR_1();

// odds a = -2, b, = 3
// IIR filter - y(n) = a * y(n - 1) + b * x(n)

reg clk = 0;

initial
	forever #5 clk = ~clk; // period 10 nsec

reg signed [15 : 0] x_vals[10 : 0];
reg signed [15 : 0] y_vals[10 : 0];

integer i;

initial begin
	// x_vals = 10 + random(0, 5)
	x_vals[0] = 6;
	x_vals[1] = 12;
	x_vals[2] = 6;
	x_vals[3] = 5;
	x_vals[4] = 9;
	x_vals[5] = 15;
	x_vals[6] = 11;
	x_vals[7] = 15;
	x_vals[8] = 11;
	x_vals[9] = 14;

	for (i = 0; i < 10; i = i + 1) begin
		$display("x[%d] = %d", i, x_vals[i]);
	end

	y_vals[0] = x_vals[0] * 3;
	$display("y[0] = %d", y_vals[0]);
	for (i = 1; i < 10; i++) begin
		// y(n) = a * y(n - 1) + b * x(n); a = -2, b, = 3
		y_vals[i] = - y_vals[i - 1] * 2 + 3 * x_vals[i];
		$display("y[%d] = %d", i, y_vals[i]);
	end

	i = 0;


end

reg signed [15 : 0] y_check;

reg signed [15 : 0] out = 0;
wire signed [15 : 0] y_filter;

IIR_1 filter(
	.clk 	(clk),
	.x_val 	(out),

	.y_val 	(y_filter)
);


always @(posedge clk) begin
	out <= x_vals[i];
	y_check <= y_vals[i];
	i = i + 1;
	if (i == 10) begin 
		i = 0;
	end


end

initial
begin
	$dumpfile("test.vcd");
	$dumpvars;
end

endmodule