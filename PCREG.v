`timescale 1ns / 1ps
module PCREG(
input clk,   //1 λ���룬�Ĵ���ʱ���źţ�������ʱΪ PC �Ĵ�����ֵ
input rst,   //1 λ���룬�첽�����źţ��ߵ�ƽʱ�� PC �Ĵ������� //ע���� ena �ź���Чʱ��rst Ҳ�������üĴ���
input ena,   //1 λ����,��Ч�źŸߵ�ƽʱ PC �Ĵ������� data_in ��ֵ�����򱣳�ԭ�����
input block,//ȡָ����ͣ�� ��λ��Ч
input [31:0] data_in, //32 λ���룬�������ݽ�������Ĵ����ڲ�
output [31:0]data_out   //32 λ���������ʱʼ�����PC�Ĵ����ڲ��洢��ֵ
);

reg [31:0] temp = 32'h00400000;
always@(posedge clk)
   begin
   if(rst)
       begin
       temp=32'h00400000;
       end
   else if(ena&~block)
       begin
       temp=data_in;
       end
   end 
   
assign data_out=temp;
endmodule