`timescale 1ns / 1ps
//N��Ƶ�� N!=1
module DIVIDER(
input CLK,  //����ʱ���źţ���������Ч
input rst,     //��λ�źţ��ߵ�ƽ��Ч
output clk  //���ʱ�� 
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
    if(count>=N/2-1)  //��count=N/2-1ʱ��⵽ʱ�������أ�˵��һ��������N/2�����ڣ�ֻ��count��û�и���
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