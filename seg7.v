`timescale 1ns / 1ps
module seg7(
input clk,
input reset,
input cs,
input [31:0] i_data,
output [6:0] o_seg,
output [7:0] o_sel
);

reg [14:0] cnt = 0;
always @ (posedge clk)
 if (reset)
   cnt <= 0;
 else
   cnt <= cnt + 1'b1;

wire seg7_clk = cnt[14]; 
//seg7_clk的周期为2^13倍clk ;

reg [2:0] seg7_addr = 0;
//seg7_addr的周期为clk的16倍
always @ (posedge seg7_clk)
  if(reset)
     seg7_addr <= 0;
   else
     seg7_addr <= seg7_addr + 1'b1;
     
reg [7:0] o_sel_r = 0;

//o_sel_r的0位随着seg7_addr时间不断往后移动
always @ (*)
  case(seg7_addr)
     0 : o_sel_r = 8'b11111110;
     1 : o_sel_r = 8'b11111101;
     2 : o_sel_r = 8'b11111011;
     3 : o_sel_r = 8'b11110111;
     4 : o_sel_r = 8'b11101111;
     5 : o_sel_r = 8'b11011111;
     6 : o_sel_r = 8'b10111111;
     7 : o_sel_r = 8'b01111111;
   endcase



reg [31:0] i_data_store = 0;
always @ (posedge clk)
  if(reset)
     i_data_store <= 0;
   else if(cs)
     i_data_store <= i_data;
     
reg [7:0] seg_data_r = 0;
always @ (*)
  case(seg7_addr)
     0 : seg_data_r = i_data_store[3:0];
     1 : seg_data_r = i_data_store[7:4];
     2 : seg_data_r = i_data_store[11:8];
     3 : seg_data_r = i_data_store[15:12];
     4 : seg_data_r = i_data_store[19:16];
     5 : seg_data_r = i_data_store[23:20];
     6 : seg_data_r = i_data_store[27:24];
     7 : seg_data_r = i_data_store[31:28];
   endcase

reg [7:0] o_seg_r = 0;
always @ (posedge clk)
  if(reset)
     o_seg_r <= 8'hff;
   else
     case(seg_data_r)
     4'h0 : o_seg_r <= 8'hC0;
     4'h1 : o_seg_r <= 8'hF9;
     4'h2 : o_seg_r <= 8'hA4;
     4'h3 : o_seg_r <= 8'hB0;
     4'h4 : o_seg_r <= 8'h99;
     4'h5 : o_seg_r <= 8'h92;
     4'h6 : o_seg_r <= 8'h82;
     4'h7 : o_seg_r <= 8'hF8;
     4'h8 : o_seg_r <= 8'h80;
     4'h9 : o_seg_r <= 8'h90;
     4'hA : o_seg_r <= 8'h88;
     4'hB : o_seg_r <= 8'h83;
     4'hC : o_seg_r <= 8'hC6;
     4'hD : o_seg_r <= 8'hA1;
     4'hE : o_seg_r <= 8'h86;
     4'hF : o_seg_r <= 8'h8E;
     endcase
     
assign o_sel = o_sel_r; //数码管启用单位，低位有效
assign o_seg = o_seg_r[6:0]; //数码管启用单位显示编码
endmodule