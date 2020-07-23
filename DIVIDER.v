`timescale 1ns / 1ps
//N分频器 N!=1
module DIVIDER(
input CLK,  //输入时钟信号，上升沿有效
input rst,     //复位信号，高电平有效
output clk  //输出时钟 
); 
reg temp_clk=0;
reg [31:0] count=0;
parameter N=4; //In the case of N=2, clk = CLK 

always@(posedge CLK)
begin  
if(rst)
    begin    
    count<=0;
    temp_clk<=1;   
    end  
else
    begin
    if(count>=N/2-1)  //当count=N/2-1时检测到时钟上升沿，说明一共经历了N/2个周期，只是count还没有更新
        begin      
        temp_clk<=~temp_clk;
        count<=0;    
        end   
    else 
        count<=count+1;  
    end 
end
assign clk = temp_clk;
endmodule