`timescale 1ns/1ns
module DIV(
input clock,      
input reset,  
input DIVS,
input [31:0]dividend,       //被除数               
input [31:0]divisor,        //除数      
input start,                //启动除法运算          
output [31:0]q,             //商      
output [31:0]r,             //余数         
output pause,                 //除法器忙标志位 
output reg busy
);
    reg[4:0] count;
    reg[31:0] reg_q;    //被除数，最终储存商
    reg[31:0] reg_r;    //余数
    reg[31:0] reg_b;    //除数
    reg busy2;          //busy 前状态
    reg r_sign;
    
    wire [31:0] dividend_temp;
    wire [31:0] divisor_temp;
    wire [31:0] q_temp;
    wire [31:0] r_temp;
    assign pause=~busy&busy2;   //刚刚结束工作的时候 即完成除法运算
    //reg_r最开始是31'b0，后加q[31]相当于将被除数的值q一位一位地移动进来
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
                reg_q<={reg_q[30:0],~sub_add[32]}; //q[31]被移动进sub_add，最后一位是将被除数转换为商的关键
                count<=count+5'b1;
                if(count==5'b11111)
                    busy<=0;
            end
        end
    end
    
endmodule
