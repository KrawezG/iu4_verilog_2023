//1 y(1) = x(1)*b - задержка на 3 такта
//2 y(2) = x(2)*b + y(1)*a - задержка после у(1) еше на 3 такта
//3 y(3) = x(3)*b + y(1)*a^2 + ab*x(2) 
//4 y(4) = x(4)*b + y(1)*a^3 + ab*x(3) + a^2*b*x(2) пошел процесс

`define A_ 16'sd1
`define A_SQUARE 16'sd1
`define A_CUBE 16'sd1
`define A_SQUARE_MULT_B -16'sd1
`define A_MULT_B -16'sd1
`define B -16'sd1

module IIR_1 (
    input clk,
    input signed [7:0] x, 
    output signed [16:0] y 
);

reg [8:0] count = 0;		// count to start of output
reg [8:0] countdown = 0;		// count to end output
reg signed [16 : 0] y_out = 0; // y(n)
reg signed [7 : 0] x_ = 0; // x(n)
reg signed [7 : 0] x_minus1 = 0; // x(n-1)
reg signed [7 : 0] x_minus2 = 0; // x(n-2)
reg signed [7 : 0] x_minus3 = 0; // x(n-3)
reg signed [7 : 0] x_minus4 = 0; // x(n-4)
reg signed [16 : 0] y_ = 0; // y(n)


    always @(posedge clk ) begin

        if (count <10) begin
            case (count)
                0: begin
                    x_mult_b <= x; //start x1*b
                    x_ <= x;  //x1 = x_
                end
                1: begin
                    x_ <= x;  //x2 = x_
                    x_minus1 <= x_;  //x1 = x_minus1
                end
                2: begin
                    x_ <= x;  //x3 = x_
                    x_minus1 <= x_;  //x2 = x_minus1
                    x_minus2 <= x_minus1;  //x1 = x_minus2
                end
                3: begin
                    y_ <= out_x_mult_b;  //y1 ready

                    y_mult_a <= out_x_mult_b;  //start y1*b
                    x_mult_b <= x_minus1;  //start x2*b

                    x_ <= x;  //x4 = x_
                    x_minus1 <= x_;  //x3 = x_minus1
                    x_minus2 <= x_minus1;  //x2 = x_minus2
                    x_minus3 <= x_minus2;  //x1 = x_minus3
                end
                4: begin
                    x_mult_b <= x_minus1;  //start x3*b
                    x_mult_a_b <= x_minus2; //start x2*ab
                    y_mult_a_square <= y_; //start y1*a^2
                    
                    x_ <= x;  //x5 = x_
                    x_minus1 <= x_;  //x4 = x_minus1
                    x_minus2 <= x_minus1;  //x3 = x_minus2
                    x_minus3 <= x_minus2;  //x2 = x_minus3
                end
                5: begin
                    x_mult_b <= x_minus1;  //start x4*b
                    x_mult_a_b <= x_minus2; //start x3*ab
                    x_mult_a_a_b <= x_minus3; //start x3*aab
                    y_mult_a_cube <= y_; //start y1*a^3

                    y_out <= out_x_mult_b;  // out y1

                    x_ <= x;  //x6 = x_
                    x_minus1 <= x_;  //x5 = x_minus1
                    x_minus2 <= x_minus1;  //x4 = x_minus2
                    x_minus3 <= x_minus2;  //x3 = x_minus3

                    y_ <= y_out;

                end
                6: begin
                    x_mult_b <= x_minus1;  //start x5*b
                    x_mult_a_b <= x_minus2; //start x4*ab
                    x_mult_a_a_b <= x_minus3; //start x3*aab
                    y_mult_a_cube <= out_y_mult_a +  out_x_mult_b; //start y2*a^3

                    y_out <= out_y_mult_a +  out_x_mult_b;  //out y2

                    x_ <= x;  //x7 = x_
                    x_minus1 <= x_;  //x6 = x_minus1
                    x_minus2 <= x_minus1;  //x5 = x_minus2
                    x_minus3 <= x_minus2;  //x4 = x_minus3

                end
                7: begin
                    x_mult_b <= x_minus1;  //start x6*b
                    x_mult_a_b <= x_minus2; //start x5*ab
                    x_mult_a_a_b <= x_minus3; //start x4*aab
                    y_mult_a_cube <= out_y_mult_a_square +  out_x_mult_a_b + out_x_mult_b; //start y3*a^3

                    y_out <= out_y_mult_a_square +  out_x_mult_a_b + out_x_mult_b;  //out y3

                    x_ <= x;  //x8 = x_
                    x_minus1 <= x_;  //x7 = x_minus1
                    x_minus2 <= x_minus1;  //x6 = x_minus2
                    x_minus3 <= x_minus2;  //x5 = x_minus3
                end
                8: begin
                    x_mult_b <= x_minus1;  //start x7*b
                    x_mult_a_b <= x_minus2; //start x6*ab
                    x_mult_a_a_b <= x_minus3; //start x5*aab
                    y_mult_a_cube <= out_y_mult_a_cube + out_x_mult_a_a_b +  out_x_mult_a_b + out_x_mult_b; //start y4*a^3

                    y_out <= out_y_mult_a_cube + out_x_mult_a_a_b +  out_x_mult_a_b + out_x_mult_b;  //out y4

                    x_ <= x;  //x9 = x_
                    x_minus1 <= x_;  //x8 = x_minus1
                    x_minus2 <= x_minus1;  //x7 = x_minus2
                    x_minus3 <= x_minus2;  //x6 = x_minus3
                    countdown <= 5; 
                end
                9: begin
                    x_mult_b <= x_minus1;  //start x8*b
                    x_mult_a_b <= x_minus2; //start x7*ab
                    x_mult_a_a_b <= x_minus3; //start x6*aab
                    y_mult_a_cube <= out_y_mult_a_cube + out_x_mult_a_a_b +  out_x_mult_a_b + out_x_mult_b; //start y5*a^3

                    y_out <= out_y_mult_a_cube + out_x_mult_a_a_b +  out_x_mult_a_b + out_x_mult_b;  //out y5

                    x_ <= x;  //x10 = x_
                    x_minus1 <= x_;  //x9 = x_minus1
                    x_minus2 <= x_minus1;  //x8 = x_minus2
                    x_minus3 <= x_minus2;  //x7 = x_minus3
                    countdown <= 5; 
                end
            endcase  
            count <= count +1;  
        end else begin
                x_mult_b <= x_minus1;  //start x(n+3)*b
                x_mult_a_b <= x_minus2; //start x(n+2)*ab
                x_mult_a_a_b <= x_minus3; //start x(n+1)*aab
                y_mult_a_cube <= out_y_mult_a_cube + out_x_mult_a_a_b +  out_x_mult_a_b + out_x_mult_b; //start y(n)*a^3

                if (countdown > 0) begin
                y_out <= out_y_mult_a_cube + out_x_mult_a_a_b +  out_x_mult_a_b + out_x_mult_b; // out y(n)
                end else begin
                y_out <= 0;
                end
                
                x_ <= x;  //x(n+5) = x_
                x_minus1 <= x_;  //x(n+4) = x_minus1
                x_minus2 <= x_minus1;  //x(n+3) = x_minus2
                x_minus3 <= x_minus2;  //x(n+2) = x_minus3

                if (x == 0 & countdown > 0) begin
                countdown <= countdown - 1; 
                end else if (countdown < 5 & x != 0) begin
                countdown <= countdown + 1; 
                end
        end
    end

reg signed [7 : 0] x_mult_b; 		// b*x(n) 
reg signed [7 : 0] x_mult_a_b;	// a*b*x(n-1)	
reg signed [7 : 0] x_mult_a_a_b;	// a^2*b*x(n-2)
reg signed [15 : 0] y_mult_a;	// a*y(n)
reg signed [15 : 0] y_mult_a_square;	// a^2*y(n)
reg signed [15 : 0] y_mult_a_cube;	// a^3*y(n)

wire signed [15 : 0] out_x_mult_b; 		// b*x(n) 
wire signed [15 : 0] out_x_mult_a_b;	// a*b*x(n-1)	
wire signed [15 : 0] out_x_mult_a_a_b;	// a^2*b*x(n-2)
wire signed [15 : 0] out_y_mult_a;	// a*y(n)
wire signed [15 : 0] out_y_mult_a_square;	// a^2*y(n)
wire signed [15 : 0] out_y_mult_a_cube;	// a^3*y(n)

// b*x(n) 			
multiplier_2cycle m_x_mult_b(
	.clk 	(clk),
	.mult_1	(`B),
	.mult_2	(x_mult_b),

	.res 	(out_x_mult_b)
);

// a*b*x(n-1)	
multiplier_2cycle m_x_mult_a_b(
	.clk 	(clk),
	.mult_1	(`A_MULT_B),
	.mult_2	(x_mult_a_b),

	.res 	(out_x_mult_a_b)
);

// a^2*b*x(n-2)	  
multiplier_2cycle m_x_mult_a_a_b(
	.clk 	(clk),
	.mult_1	(`A_SQUARE_MULT_B),
	.mult_2	(x_mult_a_a_b),

	.res 	(out_x_mult_a_a_b)
);

// a*y(n)	
multiplier_2cycle m_y_mult_a(
	.clk 	(clk),
	.mult_1	(`A_),
	.mult_2	(y_mult_a),

	.res 	(out_y_mult_a)
);

// a^2*y(n-1)	
multiplier_2cycle m_y_mult_a_square(
	.clk 	(clk),
	.mult_1	(`A_SQUARE),
	.mult_2	(y_mult_a_square),

	.res 	(out_y_mult_a_square)
);

// a^3*y(n-2)		
multiplier_2cycle m_y_mult_a_cube(
	.clk 	(clk),
	.mult_1	(`A_CUBE),
	.mult_2	(y_mult_a_cube),

	.res 	(out_y_mult_a_cube)
);

assign y = y_out;
endmodule




module multiplier_2cycle (
    input clk,
    input signed [15:0] mult_1,
    input signed [15:0] mult_2,
    output signed [15:0] res
);
    reg signed [15:0] temp;
    reg signed [15:0] result;
    always @(posedge clk) begin
        temp <= mult_1 * mult_2;
        result <= temp;
    end
assign res = result;
endmodule

