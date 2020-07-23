`timescale 1ns / 1ps
module REG(
input clk,   //1 位输入，寄存器时钟信号，下降沿时为 PC 寄存器赋值
input rst,   //1 位输入，同步重置信号，高电平时将 PC 寄存器清零 //注：当 ena 信号无效时，rst 也可以重置寄存器
input ena,   //1 位输入,有效信号高电平时 PC 寄存器读入 data_in 的值，否则保持原有输出
input [31:0] data_init,
input [31:0] data_in, //32 位输入，输入数据将被存入寄存器内部
output [31:0] data_out   //32 位输出，工作时始终输出 PC  //寄存器内部存储的值
);
reg [31:0] temp;

initial
temp <= data_init;

always @ (posedge clk)
   begin
   if(rst==1)
       begin
       temp=0;
       end
   else if(ena==1)
       begin
       temp=data_in;
       end
   end
assign data_out=temp;
endmodule
