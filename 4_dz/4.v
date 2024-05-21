module spi_receiver_slave (
    input wire clk,                 // Системный клок(SCK)
    input wire spi_mosi,            // SPI MOSI
    input wire spi_cs_n,            // SPI nCS
    output  wr_en_out,              // Сигнал разрешения записи
    output  [31:0] wr_data_out,     // Данные записи
    output  [23:0] wr_address_out   // Адрес записи
);
    localparam CMD_WRITE = 8'hFF; // Фиксированная команда записи

    reg [7:0] cmd;
    reg [23:0] address = 0;
    reg [31:0] data= 0;
    reg [7:0]  counter = 0;
    reg en_out= 0;
    reg [23:0] address_out = 0;
    reg [31:0] data_out= 0;

    always @(posedge clk ) begin
        if (!spi_cs_n) begin
            if (counter < 8) begin
                cmd [7-counter] <= spi_mosi;
                counter <= counter +1; 
            end else if (counter < 32) begin
                if (cmd == CMD_WRITE) begin
                    address [31-counter] <= spi_mosi;
                end
                counter <= counter +1;
            end else if (counter < 64) begin
                if (cmd == CMD_WRITE) begin
                    data [63-counter] <= spi_mosi;
                end
                counter <= counter +1;
            end else begin
                if (cmd == CMD_WRITE && counter == 64) begin
                    address_out <= address;
                    data_out <= data;
                    en_out <= 1;
                end
                counter <= 0;
            end
        end else begin
        address_out <= 0;
        data_out <= 0;
        en_out <= 0;
        end
    end

assign wr_en_out = en_out;
assign wr_data_out = data_out;
assign wr_address_out = address_out;
endmodule
