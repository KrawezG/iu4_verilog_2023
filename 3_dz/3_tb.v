`timescale 1ns / 1ns

module tb_IIR_1();

// odds a = -2, b, = 3
// IIR filter - y(n) = a * y(n - 1) + b * x(n)

reg clk = 0;

initial
	forever #5 clk = ~clk; // period 10 nsec


reg  [7:0] data_in = 0;
wire  [16:0] data_out;


initial begin
	data_in <= 8'sd01; 
    #10;

    data_in <= 8'sd02; 
    #10;

    data_in <= 8'sd01; 
    #10;

    data_in <= 8'sd02; 
    #10;

    data_in <= 8'sd01; 
    #10;

    data_in <= 8'sd02; 
    #10;

    data_in <= 8'sd01; 
    #10;

    data_in <= 8'sd02; 
    #10;

    data_in <= 8'sd01; 
    #10;

    data_in <= 8'sd02; 
    #10;

    data_in <= 8'sd01; 
    #10;

    data_in <= 8'sd02; 
    #10;

    data_in <= 8'sd01; 
    #10;

    data_in <= 8'sd02; 
    #10;

    data_in <= 8'sd01; 
    #10;

    data_in <= 8'sd02; 
    #10;
    data_in <= 8'sd00;
    #100;

    $finish;

	


end



IIR_1 filter(
	.clk 	(clk),
	.x 	(data_in),

	.y 	(data_out)
);




initial
begin
	$dumpfile("test.vsd");
	$dumpvars;
end

endmodule


