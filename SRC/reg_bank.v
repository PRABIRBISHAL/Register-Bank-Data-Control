`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.06.2026 23:40:23
// Design Name: Prabir Bishal
// Module Name: reg_bank
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder_4X16(
					i_decoder,
					i_enable,
					o_decoder);
input[3:0]			i_decoder;
input				i_enable;
output reg[15:0]	o_decoder;

always@(*)begin
	if(i_enable)begin
	 o_decoder = 16'b0;  // Clear all first
		case(i_decoder)
			4'b0000:o_decoder[0] =1;
			4'b0001:o_decoder[1] =1;
			4'b0010:o_decoder[2] =1;
			4'b0011:o_decoder[3] =1;
			4'b0100:o_decoder[4] =1;
			4'b0101:o_decoder[5] =1;
			4'b0110:o_decoder[6] =1;
			4'b0111:o_decoder[7] =1;
			4'b1000:o_decoder[8] =1;
			4'b1001:o_decoder[9] =1;
			4'b1010:o_decoder[10]=1;
			4'b1011:o_decoder[11]=1;
			4'b1100:o_decoder[12]=1;
			4'b1101:o_decoder[13]=1;
			4'b1110:o_decoder[14]=1;
			4'b1111:o_decoder[15]=1;
		endcase 
	end
	else 
	   o_decoder=1'bx;
	end
	
endmodule

//registe_bank
module register_8_bit(
							clk,
						     rst,
							load_pin,
							reg_ctrl,
							i_data,
							o_data
);
    input clk;
    input rst;
    input load_pin;
    input  reg_ctrl; 
    input [7:0] i_data;
    output reg [7:0] o_data;

   always @(posedge clk ) begin
             if (rst)
            o_data <= 8'b0;
             if (load_pin && reg_ctrl)
                o_data <= i_data;        
             end
			 
endmodule
module reg_bank(
						clk,
						i_rst,
						i_load_pin,
						i_en_decoder,
						i_reg_ctrl,
						i_data_in,
						o_data_out
					);

    input clk;
    input i_rst;
    input i_load_pin;
    input i_en_decoder;
    input [3:0] i_reg_ctrl;
    input [7:0] i_data_in;
    output reg[7:0] o_data_out;

    wire [15:0] o_mode_ctrl;
    wire [7:0] a_out, b_out, c_out, d_out;

    reg [7:0] data_hold;

    // 4x16 Decoder
    decoder_4X16 u0 (
        .i_decoder(i_reg_ctrl),
        .i_enable(i_en_decoder),
        .o_decoder(o_mode_ctrl)
    );

    // Transfer logic (pick source data based on reg_ctrl)
    always @(*) begin
  case (i_reg_ctrl)
    4'b0001: data_hold = a_out; // a → b
    4'b0010: data_hold = a_out; // a → c
    4'b0011: data_hold = a_out; // a → d

    4'b0101: data_hold = b_out; // b → a
    4'b0110: data_hold = b_out; // b → c
    4'b0111: data_hold = b_out; // b → d

    4'b1001: data_hold = c_out; // c → a
    4'b1010: data_hold = c_out; // c → b
    4'b1011: data_hold = c_out; // c → d

    4'b1101: data_hold = d_out; // d → a
    4'b1110: data_hold = d_out; // d → b
    4'b1111: data_hold = d_out; // d → c

    default: data_hold = i_data_in;  // regular write
  endcase
    end

// 4 registers updated to USE the decoder outputs
    register_8_bit a (
        .clk(clk),
        .rst(i_rst),
        .load_pin(i_load_pin),
        .reg_ctrl(o_mode_ctrl[0] | o_mode_ctrl[5] | o_mode_ctrl[9] | o_mode_ctrl[13]),
        .i_data(data_hold),
        .o_data(a_out)
    );

    register_8_bit b (
        .clk(clk),
        .rst(i_rst),
        .load_pin(i_load_pin),
        .reg_ctrl(o_mode_ctrl[1] | o_mode_ctrl[4] | o_mode_ctrl[10] | o_mode_ctrl[14]),
        .i_data(data_hold),
        .o_data(b_out)
    );

    register_8_bit c (
        .clk(clk),
        .rst(i_rst),
        .load_pin(i_load_pin),
        .reg_ctrl(o_mode_ctrl[2] | o_mode_ctrl[6] | o_mode_ctrl[8] | o_mode_ctrl[15]),
        .i_data(data_hold),
        .o_data(c_out)
    );

    register_8_bit d (
        .clk(clk),
        .rst(i_rst),
        .load_pin(i_load_pin),
        .reg_ctrl(o_mode_ctrl[3] | o_mode_ctrl[7] | o_mode_ctrl[11] | o_mode_ctrl[12]),
        .i_data(data_hold),
        .o_data(d_out)
    );
  always @(posedge clk) begin
    if (i_rst) begin
        o_data_out <= 8'b0;
    end else begin
        case(i_reg_ctrl)
            4'b0000, 4'b0001, 4'b0010, 4'b0011: o_data_out <= a_out;
            4'b0100, 4'b0101, 4'b0110, 4'b0111: o_data_out <= b_out;
            4'b1000, 4'b1001, 4'b1010, 4'b1011: o_data_out <= c_out;
            4'b1100, 4'b1101, 4'b1110, 4'b1111: o_data_out <= d_out;
            default: o_data_out <= 8'b0;
        endcase
    end
end

endmodule
