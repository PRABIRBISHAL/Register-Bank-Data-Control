`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.06.2026 23:42:47
// Design Name: 
// Module Name: reg_bank_tb
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


module reg_bank_tb;
	reg					clk;
	reg					i_load_pin;
	reg                   i_rst;
	reg					i_en_decoder;
	reg [3:0]			i_reg_ctrl;
	reg [7:0]			i_data_in;
	wire[7:0]			o_data_out;
	
	
	 reg_bank u0(
						.clk(clk),
						.i_rst(i_rst),
						 .i_load_pin(i_load_pin),
						.i_en_decoder(i_en_decoder),
						.i_reg_ctrl(i_reg_ctrl),
						.i_data_in(i_data_in),
						.o_data_out(o_data_out)
					);
				
	parameter TIME_PERIOD=10;
	
	initial begin
	clk=1'b0;
	i_rst=1'b0;
	i_load_pin=1'b0;
	i_en_decoder=1'b0;
	i_reg_ctrl=1'b0;
	i_data_in=8'h00;

	end 
		
	always@(*) begin
	#(TIME_PERIOD/2) clk <=~clk;
	end
	
	initial begin
	#(TIME_PERIOD-3)i_en_decoder<=1'b1;
	#(TIME_PERIOD*50);
	end
	
	initial begin
	#(TIME_PERIOD)     i_load_pin<=1'b1;//writing for a
	#(TIME_PERIOD*2)	i_load_pin<=1'b0;
	#(TIME_PERIOD*3)     
	                   i_load_pin<=1'b1;//writing for b
	#(TIME_PERIOD*2)	i_load_pin<=1'b0;
	#(TIME_PERIOD*3) 
	                   i_load_pin<=1'b1;//writing for c
	#(TIME_PERIOD*2)	i_load_pin<=1'b0;
	#(TIME_PERIOD*3) 
	                   i_load_pin<=1'b1;//writing for d
	#(TIME_PERIOD*2)	i_load_pin<=1'b0;
	#(TIME_PERIOD*10)  ;	
	end
	
	initial begin 
	#(TIME_PERIOD)        i_reg_ctrl<=4'b0000;
	#(TIME_PERIOD*2)       i_reg_ctrl<=4'b0001;
	#(TIME_PERIOD)         i_reg_ctrl<=4'b0010;
	#(TIME_PERIOD)         i_reg_ctrl<=4'b0011;
	#(TIME_PERIOD)       
	                        i_reg_ctrl<=4'b0100;
	#(TIME_PERIOD*2)        i_reg_ctrl<=4'b0101;
	#(TIME_PERIOD)          i_reg_ctrl<=4'b0110;
	#(TIME_PERIOD)          i_reg_ctrl<=4'b0111;
	#(TIME_PERIOD)         
	                        i_reg_ctrl<=4'b1000;
	#(TIME_PERIOD*2)        i_reg_ctrl<=4'b1001;
	#(TIME_PERIOD)          i_reg_ctrl<=4'b1010;
	#(TIME_PERIOD)          i_reg_ctrl<=4'b1011;
	#(TIME_PERIOD)         
                            i_reg_ctrl<=4'b1100;
    #(TIME_PERIOD*2)        /*reg_ctrl<=4'b1101;
    #(TIME_PERIOD)          reg_ctrl<=4'b1110;
    #(TIME_PERIOD)          reg_ctrl<=4'b1111;
    #(TIME_PERIOD) */       
                            i_reg_ctrl<=4'b0011;
     #(TIME_PERIOD)         i_reg_ctrl<=4'b0111;
     #(TIME_PERIOD)         i_reg_ctrl<=4'b1011;
	#(TIME_PERIOD)          i_reg_ctrl<=4'b1111;
    #(TIME_PERIOD)  ;    
	
    end 
    
    initial begin
    #(TIME_PERIOD)		i_data_in<=8'haa;
	#(TIME_PERIOD*2)    i_data_in<=8'h11;
	#(TIME_PERIOD*3)
	                    i_data_in<=8'hbb;
	#(TIME_PERIOD*2)    i_data_in<=8'h22;
	#(TIME_PERIOD*3)
	                    i_data_in<=8'hcc;
	#(TIME_PERIOD*2)    i_data_in<=8'h33;
	#(TIME_PERIOD*3)     
	                   i_data_in<=8'hdd;
	#(TIME_PERIOD*2)    i_data_in<=8'h44;
	#(TIME_PERIOD*3)
	                   i_data_in<=8'h00;
	 #(TIME_PERIOD*5);
    end
    
    initial begin
    #(TIME_PERIOD * 40);
    $finish;
    end
    initial begin 
     #(TIME_PERIOD * 20) i_rst=1'b1;
      #(TIME_PERIOD * 4);
    end
    initial begin
    $monitor("Time=%0t | clk=%b | load=%b | reg_ctrl=%b | i_data=%h | o_data=%h",
              $time, clk, i_load_pin, i_reg_ctrl, i_data_in, o_data_out);
    end

 
	endmodule
