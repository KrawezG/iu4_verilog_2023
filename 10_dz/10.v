

module last_unique_4 (
	input clk,  
	input  [7:0] data_in, 
	output  [7:0] out_0, 
	output  [7:0] out_1, 
	output  [7:0] out_2, 
	output  [7:0] out_3, 
	output  [1:0] out_valid_0, 
	output  [1:0] out_valid_1, 
	output  [1:0] out_valid_2, 
	output  [1:0] out_valid_3
);


reg  [7:0] data_out_0 = 0; 
reg  [7:0] data_out_1 = 0;
reg  [7:0] data_out_2 = 0; 
reg  [7:0] data_out_3 = 0; 
reg  [1:0] data_out_valid_0 = 0;
reg  [1:0] data_out_valid_1 = 0;
reg  [1:0] data_out_valid_2 = 0;
reg  [1:0] data_out_valid_3 = 0;
	


always @(posedge clk) begin
	
	if ((data_out_0 != data_in) && (data_out_1 != data_in) && (data_out_2 != data_in) && (data_out_3 != data_in) ) begin
        data_out_0 <=  data_in;
        data_out_1 <=  data_out_0;
        data_out_2 <=  data_out_1;
        data_out_3 <=  data_out_2;
        if (!data_out_valid_0) begin
            data_out_valid_0 <= 1;
        end else if (!data_out_valid_1) begin
            data_out_valid_1 <= 1;
        end else if (!data_out_valid_2) begin
            data_out_valid_2 <= 1;
        end else if (!data_out_valid_3) begin
            data_out_valid_3 <= 1;
        end 

        
	end else if ((data_out_0 != data_in) && (data_out_1 == data_in) && (data_out_2 != data_in) && (data_out_3 != data_in) ) begin
        data_out_0 <=  data_out_1;
        data_out_1 <=  data_out_0;
	end else if ((data_out_0 != data_in) && (data_out_1 != data_in) && (data_out_2 == data_in) && (data_out_3 != data_in) ) begin
        data_out_0 <=  data_out_2;
        data_out_1 <=  data_out_0;
        data_out_2 <=  data_out_1;
    end else if ((data_out_0 != data_in) && (data_out_1 != data_in) && (data_out_2 != data_in) && (data_out_3 == data_in) ) begin
        data_out_0 <=  data_out_3;
        data_out_1 <=  data_out_0;
        data_out_2 <=  data_out_1;
        data_out_3 <=  data_out_2;
	end 

end

assign out_0 = data_out_0;
assign out_1 = data_out_1;
assign out_2 = data_out_2;
assign out_3 = data_out_3;
assign out_valid_0 = data_out_valid_0;
assign out_valid_1 = data_out_valid_1;
assign out_valid_2 = data_out_valid_2;
assign out_valid_3 = data_out_valid_3;

endmodule 

