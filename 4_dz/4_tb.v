`timescale 1ns / 1ns

module spi_receiver_tb();

// odds a = -2, b, = 3
// IIR filter - y(n) = a * y(n - 1) + b * x(n)

reg clk = 0;

initial
	forever #5 clk = ~clk; // period 10 nsec



reg nCS = 1;
reg mosi;

wire [31:0] data_out;
wire [23:0] address_out;
wire en_out;


initial begin
	#15
	nCS <= 0;
	// Отправление комманды (8'hFF)	
	#10 mosi = 1'b1; // bit 7
	#10 mosi = 1'b1; // bit 6
	#10 mosi = 1'b1; // bit 5
	#10 mosi = 1'b1; // bit 4

	#10 mosi = 1'b1; // bit 3
	#10 mosi = 1'b1; // bit 2
	#10 mosi = 1'b1; // bit 1
	#10 mosi = 1'b1; // bit 0

	// Отправление аддреса (24'h123456)
	#10 mosi = 1'b0; // bit 23
	#10 mosi = 1'b0; // bit 22
	#10 mosi = 1'b0; // bit 21
	#10 mosi = 1'b1; // bit 20

	#10 mosi = 1'b0; // bit 19
	#10 mosi = 1'b0; // bit 18
	#10 mosi = 1'b1; // bit 17
	#10 mosi = 1'b0; // bit 16

	#10 mosi = 1'b0; // bit 15
	#10 mosi = 1'b0; // bit 14
	#10 mosi = 1'b1; // bit 13
	#10 mosi = 1'b1; // bit 12

	#10 mosi = 1'b0; // bit 11
	#10 mosi = 1'b1; // bit 10
	#10 mosi = 1'b0; // bit 9
	#10 mosi = 1'b0; // bit 8

	#10 mosi = 1'b0; // bit 7
	#10 mosi = 1'b1; // bit 6
	#10 mosi = 1'b0; // bit 5
	#10 mosi = 1'b1; // bit 4

	#10 mosi = 1'b0; // bit 3
	#10 mosi = 1'b1; // bit 2
	#10 mosi = 1'b1; // bit 1
	#10 mosi = 1'b0; // bit 0

	// Отправленние данных (32'hF1F1F1F1)
	#10 mosi = 1'b1; // bit 31
	#10 mosi = 1'b1; // bit 30
	#10 mosi = 1'b1; // bit 29
	#10 mosi = 1'b1; // bit 28

	#10 mosi = 1'b0; // bit 27
	#10 mosi = 1'b0; // bit 26
	#10 mosi = 1'b0; // bit 25
	#10 mosi = 1'b1; // bit 24

	#10 mosi = 1'b1; // bit 23
	#10 mosi = 1'b1; // bit 22
	#10 mosi = 1'b1; // bit 21
	#10 mosi = 1'b1; // bit 20

	#10 mosi = 1'b0; // bit 19
	#10 mosi = 1'b0; // bit 18
	#10 mosi = 1'b0; // bit 17
	#10 mosi = 1'b1; // bit 16

	#10 mosi = 1'b1; // bit 15
	#10 mosi = 1'b1; // bit 14
	#10 mosi = 1'b1; // bit 13
	#10 mosi = 1'b1; // bit 12

	#10 mosi = 1'b0; // bit 11
	#10 mosi = 1'b0; // bit 10
	#10 mosi = 1'b0; // bit 9
	#10 mosi = 1'b1; // bit 8

	#10 mosi = 1'b1; // bit 7
	#10 mosi = 1'b1; // bit 6
	#10 mosi = 1'b1; // bit 5
	#10 mosi = 1'b1; // bit 4

	#10 mosi = 1'b0; // bit 3
	#10 mosi = 1'b0; // bit 2
	#10 mosi = 1'b0; // bit 1
	#10 mosi = 1'b1; // bit 0

    #20 nCS = 1'b1;
	
	#100;

    $finish;
end




spi_receiver_slave SPI_mod(
	.clk 	            (clk),
    .spi_mosi           (mosi),
    .spi_cs_n           (nCS),

	.wr_en_out 	        (en_out),
    .wr_address_out 	(address_out),
    .wr_data_out 	    (data_out)
);




initial
begin
	$dumpfile("test.vsd");
	$dumpvars;
end

endmodule