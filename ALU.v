`timescale 1ns / 1ps
module ALU(
input clk,
input [31:0] a,    //32 位输入，操作数 1
input [31:0] b,    //32 位输入，操作数 2
input  [3:0] aluc, //4 位输入，控制 alu 的操作
output reg [31:0] r,   //32 位输出，由 a、b 经过 aluc 指定的操作生成
output reg zero,        //0 标志位
output reg carry,       // 进位标志位
output reg negative,   // 负数标志位
output reg overflow   // 溢出标志位 
);
wire [31:0]temp[9:0];
wire [32:0]assist[1:0];
wire signed [32:0]assist_[1:0];
wire signed [31:0]a_,b_;
assign a_=$signed(a);
assign b_=$signed(b);
assign assist[0]=a+b;
assign assist_[0]=a_+b_;
assign assist[1]=a-b;
assign assist_[1]=a_-b_;
assign temp[0]=a&b;
assign temp[1]=a|b;
assign temp[2]=a^b;
assign temp[3]=~(a|b);
assign temp[4]={b[15:0],16'b0};
assign temp[5]=(a_<b_)?1:0;
assign temp[6]=(a<b)?1:0;
assign temp[7]=b_>>>a_;
assign temp[8]=b<<a;
assign temp[9]=b>>a;
always @ (posedge clk)
case(aluc)
    4'b0000:begin    
            r<=assist[0][31:0];
            zero<=(assist[0][31:0]==0)?1:0;
            carry<=assist[0][32];
            negative<=assist[0][31];
            overflow<=overflow;
            end
    4'b0010:begin 
            r<=assist_[0][31:0];
            zero<=(assist_[0][31:0]==0)?1:0;
            carry<=carry;
            negative<=assist_[0][31];
            overflow<=((a[31]==b[31])&(assist_[0][31]!=a[31]))?1:0;
            end
    4'b0001:begin 
            r<=assist[1][31:0];
            zero<=(assist[1][31:0]==0)?1:0;
            carry<=assist[1][32];
            negative<=assist[1][31];
            overflow<=overflow;
            end
    4'b0011:begin 
            r<=assist_[1][31:0];
            zero<=(assist_[1][31:0]==0)?1:0;
            carry<=carry;
            negative<=assist_[1][31]?assist_[1][30:0]==0?0:1:0;
            overflow<=((a[31]!=b[31])&(assist_[1][31]==b[31]))?1:0;
            end
    4'b0100:begin 
            r<=temp[0];
            zero<=(temp[0]==0)?1:0;
            carry<=carry;
            negative<=temp[0][31];
            overflow<=overflow;
            end
    4'b0101:begin 
            r<=temp[1];
            zero<=(temp[1]==0)?1:0;
            carry<=carry;
            negative<=temp[1][31];
            overflow<=overflow;
            end
    4'b0110:begin 
            r<=temp[2];
            zero<=(temp[2]==0)?1:0;
            carry<=carry;
            negative<=temp[2][31];
            overflow<=overflow;
            end
    4'b0111:begin 
            r<=temp[3];
            zero<=(temp[3]==0)?1:0;
            carry<=carry;
            negative<=temp[3][31];
            overflow<=overflow;
            end
    4'b1000:begin 
            r<=temp[4];
            zero<=(temp[4]==0)?1:0;
            carry<=carry;
            negative<=temp[4][31];
            overflow<=overflow;
            end
    4'b1001:begin 
            r<=temp[4];
            zero<=(temp[4]==0)?1:0;
            carry<=carry;
            negative<=temp[4][31];
            overflow<=overflow;
            end
    4'b1011:begin 
            r<=temp[5];
            zero<=(a-b==0)?1:0;
            carry<=carry;
            negative<=(a_<b_)?1:0;
            overflow<=overflow;
            end
    4'b1010:begin 
            r<=temp[6];
            zero<=(a-b==0)?1:0;
            carry<=(a<b)?1:0;
            negative<=temp[6][31];
            overflow<=overflow;
            end
    4'b1100:begin 
            r<=temp[7];
            zero<=(temp[7]==0)?1:0;
            carry<=(a==0)?0:b[a-1];
            negative<=temp[7][31];
            overflow<=overflow;
            end
    4'b1110:begin 
            r<=temp[8];
            zero<=(temp[8]==0)?1:0;
            carry<=(a==0)?0:b[32-a];
            negative<=temp[8][31];
            overflow<=overflow;
            end
    4'b1111:begin 
            r<=temp[8];
            zero<=(temp[8]==0)?1:0;
            carry<=(a==0)?0:b[32-a];
            negative<=temp[8][31];
            overflow<=overflow;
            end
    4'b1101:begin 
            r<=temp[9];
            zero<=(temp[8]==0)?1:0;
            carry<=(a==0)?0:b[a-1];
            negative<=temp[8][31];
            overflow<=overflow;
            end

endcase
endmodule
