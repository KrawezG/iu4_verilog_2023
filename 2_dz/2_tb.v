`timescale 1ns / 1ns

module complex_mult_tb();

reg clk = 0;
reg signed [7:0] Re_in_1 = 0;
reg signed [7:0] Im_in_1 = 0;
reg signed [7:0] Re_in_2 = 0;
reg signed [7:0] Im_in_2 = 0;
reg signed [1:0] data_valid_in = 0; 
wire signed [15:0] Re_out;
wire signed [15:0] Im_out;
wire signed [1:0] data_valid_out;
initial
    forever #5 clk = ~clk;

initial
begin
    //first test (1+0i)*(1+0i)
    Re_in_1 <= 8'sd03; 
    Im_in_1 <= 8'sd01;
    Re_in_2 <= 8'sd03;
    Im_in_2 <= 8'sd01;
    data_valid_in <= 2'b01; 

    #10;

    data_valid_in <= 2'b00; 
    Re_in_1 <= 8'sd00; 
    Im_in_1 <= 8'sd00;
    Re_in_2 <= 8'sd00;
    Im_in_2 <= 8'sd00;

    #20;

    //second test (0+1i)*(0+1i)
    Re_in_1 <= 8'sd02; 
    Im_in_1 <= 8'sd01;
    Re_in_2 <= 8'sd02;
    Im_in_2 <= 8'sd01;
    data_valid_in <= 2'b01;

    #10;

    data_valid_in <= 2'b00; 
    Re_in_1 <= 8'sd00; 
    Im_in_1 <= 8'sd00;
    Re_in_2 <= 8'sd00;
    Im_in_2 <= 8'sd00;

    #20;

    //third test (1+1i)*(1+1i)
    Re_in_1 <= 8'sd01; 
    Im_in_1 <= 8'sd01;
    Re_in_2 <= 8'sd01;
    Im_in_2 <= 8'sd01;
    data_valid_in <= 2'b01; 

    #10;

    data_valid_in <= 2'b00; 
    Re_in_1 <= 8'sd00; 
    Im_in_1 <= 8'sd00;
    Re_in_2 <= 8'sd00;
    Im_in_2 <= 8'sd00;

    #20;

    //fourth test (1+2i)*(1+2i)
    Re_in_1 <= 8'sd01; 
    Im_in_1 <= 8'sd02;
    Re_in_2 <= 8'sd01;
    Im_in_2 <= 8'sd02;
    data_valid_in <= 2'b01;

    #10;
    
    data_valid_in <= 2'b00; 
    Re_in_1 <= 8'sd00; 
    Im_in_1 <= 8'sd00;
    Re_in_2 <= 8'sd00;
    Im_in_2 <= 8'sd00;

    #200;

    $finish;
end

Complex_Multiplier dut (
    .clk(clk), 
    .Re_in_1(Re_in_1), 
    .Im_in_1(Im_in_1), 
    .Re_in_2(Re_in_2), 
    .Im_in_2(Im_in_2), 
    .data_valid_in(data_valid_in), 
    .Re_out(Re_out), 
    .Im_out(Im_out),
    .data_valid_out(data_valid_out)
);

initial
begin
    $dumpfile("test.vsd");
    $dumpvars;
end

endmodule