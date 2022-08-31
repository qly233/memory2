`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:12:18 05/10/2022 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module top_RAM_B(Mem_Addr,C,Mem_Write,Clk,clk_s,an,seg);
	input [7:2]Mem_Addr;
	input [1:0]C;
	input Mem_Write,Clk,clk_s;
	output[3:0] an;
	output[7:0] seg;
	reg [31:0]LED;
	wire [31:0]M_R_Data;
	reg [31:0]M_W_Data;
	RAMB your_instance_name (
  .clka(Clk), 
  .wea(Mem_Write), 
  .addra(Mem_Addr[7:2]), 
  .dina(M_W_Data), 
  .douta(M_R_Data) 
  );
	always@(*)
	begin
		LED=0;
		M_W_Data=0;
		if(!Mem_Write)
			LED=M_R_Data;
	else
	begin
	  case(C)
	   2'b00:M_W_Data=32'h0055_7523;
		2'b01:M_W_Data=32'h1234_5678;
		2'b10:M_W_Data=32'h8765_4321;
		2'b11:M_W_Data=32'hffff_ffff;
		endcase
   end
	end
	clk_show clk_show0(clk_s,clk_t);
	show show0(0,clk_t,LED,an,seg);
endmodule

module clk_show(clk_in,clk_out);//分频器1数码管刷新
	input clk_in;
	reg[11:0] counter = 12'b0;
	output reg clk_out = 1'b0;
	always @(posedge clk_in)
	begin
		if(counter == 11'd2000)
			begin
				clk_out <= ~clk_out;
				counter <= 12'b0;
			end	 
      else
			counter <= counter+1'b1;
   end
endmodule

module show(clr,clk,Data,an,seg);//数码管显示模块
	input clk,clr;
	input[31:0] Data;
	output reg[3:0] an;
	output reg[7:0] seg;

	reg[2:0] BitSel = 3'b0; //选择用哪一个数码管显示
	reg[3:0] data; //数码管所需要显示的数字
	//数码管显示数字模块
	always@(*)
	begin
		case(data)
			4'b0000: seg[7:0]<=8'b00000011;
			4'b0001: seg[7:0]<=8'b10011111;
			4'b0010: seg[7:0]<=8'b00100101;
			4'b0011: seg[7:0]<=8'b00001101;
			4'b0100: seg[7:0]<=8'b10011001;
			4'b0101: seg[7:0]<=8'b01001001;
			4'b0110: seg[7:0]<=8'b01000001;
			4'b0111: seg[7:0]<=8'b00011111;
			4'b1000: seg[7:0]<=8'b00000001;
			4'b1001: seg[7:0]<=8'b00001001;
			4'b1010: seg[7:0]<=8'b00010001;
			4'b1011: seg[7:0]<=8'b11000001;
			4'b1100: seg[7:0]<=8'b01100011;
			4'b1101: seg[7:0]<=8'b10000101;
			4'b1110: seg[7:0]<=8'b01100001;
			4'b1111: seg[7:0]<=8'b01110001;
		endcase
	end
	
	always@( posedge clk)
		begin
				begin
							BitSel <= BitSel + 1'b1;
							case(BitSel)
							3'b000: 
							begin 
								an<=4'b1111;
								if(clr) data <= 4'b1010;
								else data<=Data[3:0];
							end
							3'b001: 
							begin
								an<=4'b1110;							
								if(clr) data <= 4'b1010;
								else data<=Data[7:4];
							end
							3'b010: 
							begin
								an<=4'b1101;
								if(clr) data <= 4'b1010;
								else data<=Data[11:8];
							end
							3'b011: 
							begin
								an<=4'b1100;
								if(clr) data <= 4'b1010;
								else data<=Data[15:12];								
							end							
							3'b100:
							begin
								an<=4'b1011;
								if(clr) data <= 4'b1010;
								else data<=Data[19:16];
							end
							3'b101:
							begin
								an<=4'b1010;
								if(clr) data <= 4'b1010;
								else data<=Data[23:20];
							end
							3'b110:
							begin
								an<=4'b1001;
								if(clr) data <= 4'b1010;
								else data<=Data[27:24];
							end
							3'b111:
							begin
								an<=4'b1000;
								if(clr) data <= 4'b1010;
								else data<=Data[31:28];
							end
						endcase		
				end
		end
endmodule

