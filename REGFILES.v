`timescale 1ns / 1ps
module REGFILES(
input clk,    //�Ĵ�����ʱ���źţ��½���д������
input rst,    //reset �źţ��ߵ�ƽʱȫ���Ĵ������� 
input we,     //д��Ч�źţ��ߵ�ƽʱ�Ĵ������ܱ�д��
input [4:0] raddr1,  //�����ȡ�ļĴ����ĵ�ַ
input [4:0] raddr2,  //�����ȡ�ļĴ����ĵ�ַ 
input [4:0] waddr,   //д�Ĵ����ĵ�ַ 
input  [31:0] wdata, //д�Ĵ������� 
output [31:0] rdata1, //raddr1 ����Ӧ�Ĵ������������
output [31:0] rdata2,  //raddr2 ����Ӧ�Ĵ������������ 
output [31:0] reg28 
);
//At the begining, set init to 0 which denotes the register has not been initialized
reg init = 0;
wire reset = rst | ~init;
reg [31:0] temp [31:0];
//regfile management
always @ (posedge clk)
begin
    if(reset)
       begin
       temp[0] <= 32'b0;
       temp[1] <= 32'b0;
       temp[2] <= 32'b0;
       temp[3] <= 32'b0;
       temp[4] <= 32'b0;
       temp[5] <= 32'b0;
       temp[6] <= 32'b0;
       temp[7] <= 32'b0;
       temp[8] <= 32'b0;
       temp[9] <= 32'b0;
       temp[10] <= 32'b0;
       temp[11] <= 32'b0;
       temp[12] <= 32'b0;
       temp[13] <= 32'b0;
       temp[14] <= 32'b0;
       temp[15] <= 32'b0;
       temp[16] <= 32'b0;
       temp[17] <= 32'b0;
       temp[18] <= 32'b0;
       temp[19] <= 32'b0;
       temp[20] <= 32'b0;
       temp[21] <= 32'b0;
       temp[22] <= 32'b0;
       temp[23] <= 32'b0;
       temp[24] <= 32'b0;
       temp[25] <= 32'b0;
       temp[26] <= 32'b0;
       temp[27] <= 32'b0;
       temp[28] <= 32'b0;
       temp[29] <= 32'b0;
       temp[30] <= 32'b0;
       temp[31] <= 32'b0;
       init <= 1'b1;
       end
    else if (we && (waddr!=0))
       begin
       temp[waddr]<=wdata;
       end
end
//output handler
assign rdata1=temp[raddr1];
assign rdata2=temp[raddr2];
assign reg28 = temp[28];
endmodule
