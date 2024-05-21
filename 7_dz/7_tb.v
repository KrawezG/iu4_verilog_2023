`timescale 1ns / 1ns

module top_module();

reg [7:0] in8 = 0;
wire [2:0] pos8 = 0;

reg [31:0] in32 = 0;
wire [4:0] pos32 = 0;

reg [63:0] in64 = 0;
wire [5:0] pos64 = 0;


    
initial begin
    #10;
    in8 = 8'h4f;
    #10;
    in8 = 8'h01;
    in32 = 32'h001fffff;
    #10;

    in64 = 64'h0000001fffff0000;
    #40;
    $finish;
end

leading_one #(.WIDTH(8), .LOG2_WIDTH(3)) detector8 (
        .in(in8),
        .position(pos8)
);

leading_one #(.WIDTH(32)) detector32 (
        .in(in32),
        .position(pos32)
);

leading_one #(.WIDTH(64)) detector64 (
        .in(in64),
        .position(pos64)
);

initial
begin
	$dumpfile("test.vsd");
	$dumpvars;
end  

endmodule