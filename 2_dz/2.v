


module Complex_Multiplier (
	input clk,  
	input signed  [7:0] Re_in_1,
	input signed  [7:0] Im_in_1, 
    input signed  [7:0] Re_in_2, 
    input signed  [7:0] Im_in_2, 
    input signed [1:0] data_valid_in,
    output signed  [15:0] Re_out, 
    output signed  [15:0] Im_out,
	output signed  [1:0] data_valid_out
);

reg [7:0] a = 0;
reg [7:0] b = 0;
reg [7:0] c = 0;
reg [7:0] d = 0;

reg [15:0] k1 = 0;
reg [15:0] k2 = 0;
reg [15:0] k3 = 0;
reg [15:0] x = 0;
reg [15:0] y = 0;

reg [2:0] state = 0;
reg [1:0] flag = 0;
reg [3:0] cnt = 0;
reg [1:0] data_good_out = 0;

reg signed [7:0] operand1 = 0; 
reg signed [7:0] operand2 = 0;
reg signed [15:0] result = 0; 

  	always @(posedge clk) begin
		result <= operand1 * operand2;
    end


  	always @(posedge clk) begin

    if (data_valid_in) 
	begin
		a <= Re_in_1;
		b <= Im_in_1;
		c <= Re_in_2;
		d <= Im_in_2;
		state <= 1;
		//data_good_out <= 0;
		k1 <= result;
		flag <= 1;
	end

	case (state)
		1: begin
		// k1 = c * (a - b)
		operand1 <= c;
		operand2 <= (b - a);
		k2 <= result;
		data_good_out <= 0;

		// Move to the next state
		state <= state + 1;
		end
		2: begin
		// k2 = b * (c - d)
		operand1 <= b;
		operand2 <= (c - d);
		k3 <= result;

		// Move to the next state
		state <= state + 1;
		// flag <= 1;
		end
		3: begin
		// k3 = a * (c + d)
		operand1 <= a;
		operand2 <= (c + d);
		k1 <= result;

		// x = k2 - k1
		x <= k2 - k1;

		// y = k1 + k3
		y <= k1 + k3;

		if (flag == 1 && data_valid_in) 
		begin
		end else
		if (flag == 1 ) 
		begin
			state <= 1;
			flag <= 0;
		end else 
		begin
			state <= 0;
		end

		if (flag == 1 && cnt < 1) 
		begin
			cnt <= cnt + 1;
		end else
		if (flag == 1 && cnt < 2) 
		begin
			data_good_out <= 1;
			cnt <= cnt + 1;
		end else
		if (flag == 1 && cnt == 2) 
		begin
			data_good_out <= 1;
		end else
		begin
			data_good_out <= 1;
			cnt <= 0;
		end

		end
		default: begin
		data_good_out <= 0;
		end
	endcase
    
  end
  assign Re_out = x;
  assign Im_out = y;
  assign data_valid_out = data_good_out;

endmodule


