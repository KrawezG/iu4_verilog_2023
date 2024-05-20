`timescale 1ns / 1ns

module last_unique_4_tb();

	 

reg clk = 0;
reg  [7:0] data_in = 0;
wire  [7:0] out_0;
wire  [7:0] out_1;
wire  [7:0] out_2;
wire  [7:0] out_3;
wire  [1:0] out_valid_0;
wire  [1:0] out_valid_1;
wire  [1:0] out_valid_2;
wire  [1:0] out_valid_3;


initial
    forever #5 clk = ~clk;

initial
begin
    
    data_in <= 8'sd01; 
    #10;

    data_in <= 8'sd09; 
    #10;

    data_in <= 8'sd02; 
    #10;

    data_in <= 8'sd03; 
    #10;

    data_in <= 8'sd04; 
    #10;

    data_in <= 8'sd03; 
    #10;

    data_in <= 8'sd07; 
    #10;

    data_in <= 8'sd07; 
    #10;

    data_in <= 8'sd01; 
    #10;

    data_in <= 8'sd01; 
    #10;
    
    #20;

    $finish;
end

last_unique_4 dut (
    .clk(clk), 
    .data_in(data_in), 
    .out_0(out_0), 
    .out_1(out_1), 
    .out_2(out_2), 
    .out_3(out_3), 
    .out_valid_0(out_valid_0), 
    .out_valid_1(out_valid_1),
    .out_valid_2(out_valid_2),
    .out_valid_3(out_valid_3)
);


initial
begin
    $dumpfile("test.vsd");
    $dumpvars;
end

endmodule







