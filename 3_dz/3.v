//1 y(1) = x(1)*b - задержка на 2 такта
//2 y(2) = x(2)*b + y(1)*a - задержка после у(1) еше на 2 такта
//3 y(3) = x(3)*b + y(1)*a^2 + ab*x(2) пошел процесс
//4 y(4) = x(4)*b + y(2)*a^2 + ab*x(3)

`define A_ 16'sd1
`define A_SQUARE -16'sd1
`define A_SQUARE_MULT_B 16'sd1
`define A_MULT_B -16'sd1
`define B 16'sd1

module IIR_1 (
    input clk,
    input signed [7:0] x, // Input x_k+1
    output signed [16:0] y // Output y_k+1
);

reg [8:0] count = 0;		// count to calculate all summable
reg signed [16 : 0] y_out = 0; // y(n)
reg signed [15 : 0] x_ = 0; // x(n)
reg signed [15 : 0] x_minus1 = 0; // x(n-1)
reg signed [15 : 0] x_minus2 = 0; // x(n-2)
reg signed [15 : 0] x_minus3 = 0; // x(n-3)
reg signed [16 : 0] y_ = 0; // y(n)
reg signed [16 : 0] y_minus1 = 0; // y(n-1)
reg signed [16 : 0] y_minus2 = 0; // y(n-2)

    always @(posedge clk ) begin

        if (count <5) begin
            case (count)
                0: begin
                    m_x_mult_b <= x; //start x1*b

                    x_ <= x;  //x1 = x_
                end
                1: begin
                    x_ <= x;  //x2 = x_
                    x_minus1 <= x_;  //x1 = x_minus1
                end
                2: begin
                    y_ <= x_mult_b;  //y1 ready
                    x_mult_b <= x_;  //start x2*b
                    m_y_mult_a <= x_mult_b;  //start y1*b

                    x_ <= x;  //x3 = x_
                    x_minus1 <= x_;  //x2 = x_minus1
                    x_minus2 <= x_minus1;  //x1 = x_minus2
                end
                3: begin
                    y_minus1 <= x_mult_b;
                    x_mult_b <= x_;   //start x3*b
                    m_y_mult_a_square <= y_; //start y1*a^2

                    y_out <= y_  // out y1   

                    x_ <= x;  //x4 = x_
                    x_minus1 <= x_;  //x3 = x_minus1
                    x_minus2 <= x_minus1;  //x2 = x_minus2
                    x_minus3 <= x_minus2;  //x1 = x_minus3
                end
                4: begin
                    y_ <= m_y_mult_a; // ready y1*b  
                    x_mult_b <= x_minus1;
                    m_y_mult_a_square <= x_mult_b; //start y3*b

                    y_out <= m_y_mult_a +  x_mult_b;  //out y2
                    m_y_mult_a_square <= m_y_mult_a +  x_mult_b;  //start y2*a^2

                    x_ <= x; //x2 = x_
                    x_minus1 <= x_;  //x1 = x_minus1
                    x_minus2 <= x_minus1;  //x1 = x_minus1
                    x_minus3 <= x_minus2;  //x1 = x_minus1
                    y_minus1 <= y_;  //y1 = y_minus1
                end
                5: begin
                    y_ <= m_y_mult_a_square; // ready y1*b
                    x_mult_b <= x_minus1;
                    m_y_mult_a_square <= x_mult_b; //start y4*b

                    y_out <= m_y_mult_a_square +  x_mult_b;  //out 3

                    x_ <= x; //x2 = x_
                    x_minus1 <= x_;  //x1 = x_minus1
                    x_minus2 <= x_minus1;  //x1 = x_minus1
                    x_minus3 <= x_minus2;  //x1 = x_minus1
                end
            endcase  
            count <= count +1;  
        end else begin
                
        end
    end

wire signed [7 : 0] x_mult_b; 		// b * x(n) 
wire signed [7 : 0] x_mult_a_b;	// a * b * x(n - 1)
wire signed [7 : 0] x_mult_a_a_b;	// a^2 * b * x(n - 2)
wire signed [7 : 0] y_mult_a;	// a^2 * y(n)
wire signed [7 : 0] y_mult_a_square;	// a^2 * y(n - 2)

// b * x(n) 			n = 1
multiplier_2cycle m_x_mult_b(
	.clk 	(clk),
	.num1	(`B),
	.num2	(x_val),

	.res 	(x_mult_b)
);

// a * b * x(n - 1)		n = 2
multiplier_2cycle m_x_mult_a_b(
	.clk 	(clk),
	.num1	(`A_MULT_B),
	.num2	(x_val_old_1),

	.res 	(x_mult_a_b)
);

// a^2 * b * x(n - 2)	n = 3
multiplier_2cycle m_x_mult_a_a_b(
	.clk 	(clk),
	.num1	(`A_SQUARE_MULT_B),
	.num2	(x_val_old_2),

	.res 	(x_mult_a_a_b)
);

// a * y(n)		n = 4
multiplier_2cycle m_y_mult_a(
	.clk 	(clk),
	.num1	(`A),
	.num2	(y_calc_val),

	.res 	(y_mult_a_square)
);

// a^3 * y(n - 2)		n = 4
multiplier_2cycle m_y_mult_a_square(
	.clk 	(clk),
	.num1	(`A_SQUARE),
	.num2	(y_calc_val),

	.res 	(y_mult_a_square)
);

assign y = y_out;
endmodule




module multiplier_2cycle (
    input clk,
    input signed [7:0] mult_1,
    input signed [7:0] mult_2,
    output signed [15:0] res,
);
    reg signed [15:0] temp;
    reg signed [15:0] result;
    always @(posedge clk) begin
        temp <= milt_1 * mult_2;
        result <= temp;
    end
assign res = result;
endmodule

