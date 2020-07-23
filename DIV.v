`timescale 1ns/1ns
module DIV(
input clock,      
input reset,  
input DIVS,
input [31:0]dividend,       //������               
input [31:0]divisor,        //����      
input start,                //������������          
output [31:0]q,             //��      
output [31:0]r,             //����         
output pause,                 //������æ��־λ 
output reg busy
);
    reg[4:0] count;
    reg[31:0] reg_q;    //�����������մ�����
    reg[31:0] reg_r;    //����
    reg[31:0] reg_b;    //����
    reg busy2;          //busy ǰ״̬
    reg r_sign;
    
    wire [31:0] dividend_temp;
    wire [31:0] divisor_temp;
    wire [31:0] q_temp;
    wire [31:0] r_temp;
    assign pause=~busy&busy2;   //�ոս���������ʱ�� ����ɳ�������
    //reg_r�ʼ��31'b0�����q[31]�൱�ڽ���������ֵqһλһλ���ƶ�����
    wire [32:0] sub_add=r_sign?({reg_r,q_temp[31]}+{1'b0,reg_b}):({reg_r,q_temp[31]}-{1'b0,reg_b});
    assign r_temp=r_sign?reg_r+reg_b:reg_r;
    assign q_temp=reg_q;
    
    assign r=DIVS?dividend[31]?(~r_temp+1):r_temp:r_temp;//r_temp>0
    assign q=DIVS?(dividend[31]==divisor[31])?q_temp:(~q_temp+1):q_temp;
    assign dividend_temp=dividend[31]?(~dividend+1):dividend;
    assign divisor_temp=divisor[31]?(~divisor+1):divisor;
    
    always @(posedge clock)
    begin
        if(reset)
        begin
            count<=5'b0;
            busy<=0;
            busy2<=0;
        end
        else
        begin
            busy2<=busy;
            if(start&~busy)
            begin
                reg_r<=32'b0;
                r_sign<=0;
                reg_q<=DIVS?dividend_temp:dividend;
                reg_b<=DIVS?divisor_temp:divisor;
                count<=5'b0;
                busy<=1'b1;
            end
            else if(busy)
            begin
                reg_r<=sub_add[31:0];
                r_sign<=sub_add[32];
                reg_q<={reg_q[30:0],~sub_add[32]}; //q[31]���ƶ���sub_add�����һλ�ǽ�������ת��Ϊ�̵Ĺؼ�
                count<=count+5'b1;
                if(count==5'b11111)
                    busy<=0;
            end
        end
    end
    
endmodule
