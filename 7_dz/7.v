`timescale 1ns / 1ns

module leading_one #(
    parameter WIDTH = 4,
    parameter LOG2_WIDTH = $clog2(WIDTH)
)(
    input [WIDTH-1:0] in,
    output [LOG2_WIDTH-1:0] position
);
 
wire [WIDTH-1:0] reversed;
wire [WIDTH-1:0] procesed;
wire [WIDTH-1:0] inter;
wire [WIDTH-1:0] mask [LOG2_WIDTH-1:0];

assign procesed = (reversed & (reversed - 1'b1)) ^ reversed;

genvar i, j;
generate
    for (i = 0; i < WIDTH; i = i + 1) begin 
        assign reversed[i] = in[WIDTH-1-i];
        assign inter[i] = procesed[WIDTH-1-i];
    end
    for (j = 0; j < LOG2_WIDTH; j = j + 1) begin
        for (i = 0; i < WIDTH; i = i + 1) 
            assign mask[j][i] = (i >> j) & 1'b1;
        assign position[j] = |(inter & mask[j]);
    end
endgenerate

endmodule