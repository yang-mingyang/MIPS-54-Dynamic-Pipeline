`timescale 1ns/1ns
module MULT( 
input clk,//   乘法器时钟信号 
input reset, 
input ena, 
input start,  
input MUL,                   
input [31:0] a_u,//   输入 a(被乘数)  
input [31:0] b_u,//    输入 b(乘数) 
output [63:0] z, //     乘积输出 z
output reg finish,
output reg busy
); 
initial
begin
    finish <= 1'b0;
    busy <= 1'b0;
end
wire [31:0] a = MUL?a_u[31]?~a_u+32'b1:a_u:a_u;
wire [31:0] b = MUL?b_u[31]?~b_u+32'b1:b_u:b_u;
reg [2:0] count = 3'b000;
reg [63:0] temp = 0;
reg [63:0] store0 = 0;
reg [63:0] store1 = 0;
reg [63:0] store2 = 0;
reg [63:0] store3 = 0;
reg [63:0] store4 = 0;
reg [63:0] store5 = 0;
reg [63:0] store6 = 0;
reg [63:0] store7 = 0;
reg [63:0] store8 = 0;
reg [63:0] store9 = 0;
reg [63:0] store10 = 0;
reg [63:0] store11 = 0;
reg [63:0] store12 = 0;
reg [63:0] store13 = 0;
reg [63:0] store14 = 0;
reg [63:0] store15 = 0;
reg [63:0] store16 = 0;
reg [63:0] store17 = 0;
reg [63:0] store18 = 0;
reg [63:0] store19 = 0;
reg [63:0] store20 = 0;
reg [63:0] store21 = 0;
reg [63:0] store22 = 0;
reg [63:0] store23 = 0;
reg [63:0] store24 = 0;
reg [63:0] store25 = 0;
reg [63:0] store26 = 0;
reg [63:0] store27 = 0;
reg [63:0] store28 = 0;
reg [63:0] store29 = 0;
reg [63:0] store30 = 0;
reg [63:0] store31 = 0;
reg [63:0] store0t1 = 0;
reg [63:0] store2t3 = 0;
reg [63:0] store4t5 = 0;
reg [63:0] store6t7 = 0;
reg [63:0] store8t9 = 0;
reg [63:0] store10t11 = 0;
reg [63:0] store12t13 = 0;
reg [63:0] store14t15 = 0;
reg [63:0] store16t17 = 0;
reg [63:0] store18t19 = 0;
reg [63:0] store20t21 = 0;
reg [63:0] store22t23 = 0;
reg [63:0] store24t25 = 0;
reg [63:0] store26t27 = 0;
reg [63:0] store28t29 = 0;
reg [63:0] store30t31 = 0;
reg [63:0] store0t3 = 0;
reg [63:0] store4t7 = 0;
reg [63:0] store8t11 = 0;
reg [63:0] store12t15 = 0;
reg [63:0] store16t19 = 0;
reg [63:0] store20t23 = 0;
reg [63:0] store24t27 = 0;
reg [63:0] store28t31 = 0;
reg [63:0] store0t7 = 0;
reg [63:0] store8t15 = 0;
reg [63:0] store16t23 = 0;
reg [63:0] store24t31 = 0;
reg [63:0] store0t15 = 0;
reg [63:0] store16t31 = 0;
always @ (posedge clk)
    begin
    if(reset)
        begin
        busy<=1'b0;
        count<=3'b000;
        temp <= 0;
        store0 <= 0;
        store1 <= 0;
        store2 <= 0;
        store3 <= 0;
        store4 <= 0;
        store5 <= 0;
        store6 <= 0;
        store7 <= 0;
        store8 <= 0;
        store9 <= 0;
        store10 <= 0;
        store11 <= 0;
        store12 <= 0;
        store13 <= 0;
        store14 <= 0;
        store15 <= 0;
        store16 <= 0;
        store17 <= 0;
        store18 <= 0;
        store19 <= 0;
        store20 <= 0;
        store21 <= 0;
        store22 <= 0;
        store23 <= 0;
        store24 <= 0;
        store25 <= 0;
        store26 <= 0;
        store27 <= 0;
        store28 <= 0;
        store29 <= 0;
        store30 <= 0;
        store31 <= 0;
        store0t1 <= 0;
        store2t3 <= 0;
        store4t5 <= 0;
        store6t7 <= 0;
        store8t9 <= 0;
        store10t11 <= 0;
        store12t13 <= 0;
        store14t15 <= 0;
        store16t17 <= 0;
        store18t19 <= 0;
        store20t21 <= 0;
        store22t23 <= 0;
        store24t25 <= 0;
        store26t27 <= 0;
        store28t29 <= 0;
        store30t31 <= 0;
        store0t3 <= 0;
        store4t7 <= 0;
        store8t11 <= 0;
        store12t15 <= 0;
        store16t19 <= 0;
        store20t23 <= 0;
        store24t27 <= 0;
        store28t31 <= 0;
        store0t7 <= 0;
        store8t15 <= 0;
        store16t23 <= 0;
        store24t31 <= 0;
        store0t15 <= 0;
        store16t31 <= 0;
        end 
    else if(busy|(start&ena))
        begin
        store0 <= b[0]? {32'b0,a} : 64'b0;
        store1 <= b[1]? {31'b0,a,1'b0} : 64'b0;
        store2 <= b[2]? {30'b0,a,2'b0} : 64'b0;
        store3 <= b[3]? {29'b0,a,3'b0} : 64'b0;
        store4 <= b[4]? {28'b0,a,4'b0} : 64'b0;
        store5 <= b[5]? {27'b0,a,5'b0} : 64'b0;
        store6 <= b[6]? {26'b0,a,6'b0} : 64'b0;
        store7 <= b[7]? {25'b0,a,7'b0} : 64'b0;
        store8 <= b[8]? {24'b0,a,8'b0} : 64'b0;
        store9 <= b[9]? {23'b0,a,9'b0} : 64'b0;
        store10 <= b[10]? {22'b0,a,10'b0} : 64'b0;
        store11 <= b[11]? {21'b0,a,11'b0} : 64'b0;
        store12 <= b[12]? {20'b0,a,12'b0} : 64'b0;
        store13 <= b[13]? {19'b0,a,13'b0} : 64'b0;
        store14 <= b[14]? {18'b0,a,14'b0} : 64'b0;
        store15 <= b[15]? {17'b0,a,15'b0} : 64'b0;
        store16 <= b[16]? {16'b0,a,16'b0} : 64'b0;
        store17 <= b[17]? {15'b0,a,17'b0} : 64'b0;
        store18 <= b[18]? {14'b0,a,18'b0} : 64'b0;
        store19 <= b[19]? {13'b0,a,19'b0} : 64'b0;
        store20 <= b[20]? {12'b0,a,20'b0} : 64'b0;
        store21 <= b[21]? {11'b0,a,21'b0} : 64'b0;
        store22 <= b[22]? {10'b0,a,22'b0} : 64'b0;
        store23 <= b[23]? {9'b0,a,23'b0} : 64'b0;
        store24 <= b[24]? {8'b0,a,24'b0} : 64'b0;
        store25 <= b[25]? {7'b0,a,25'b0} : 64'b0;
        store26 <= b[26]? {6'b0,a,26'b0} : 64'b0;
        store27 <= b[27]? {5'b0,a,27'b0} : 64'b0;
        store28 <= b[28]? {4'b0,a,28'b0} : 64'b0;
        store29 <= b[29]? {3'b0,a,29'b0} : 64'b0;
        store30 <= b[30]? {2'b0,a,30'b0} : 64'b0;
        store31 <= b[31]? {1'b0,a,31'b0} : 64'b0;
        store0t1 <= store0 + store1;
        store2t3 <= store2 + store3;
        store4t5 <= store4 + store5;
        store6t7 <= store6 + store7;
        store8t9 <= store8 + store9;
        store10t11 <= store10 + store11;
        store12t13 <= store12 + store13;
        store14t15 <= store14 + store15;
        store16t17 <= store16 + store17;
        store18t19 <= store18 + store19;
        store20t21 <= store20 + store21;
        store22t23 <= store22 + store23;
        store24t25 <= store24 + store25;
        store26t27 <= store26 + store27;
        store28t29 <= store28 + store29;
        store30t31 <= store30 + store31;
        store0t3 <= store0t1+store2t3;
        store4t7 <= store4t5+store6t7;
        store8t11 <= store8t9+store10t11;
        store12t15 <= store12t13+store14t15;
        store16t19 <= store16t17+store18t19;
        store20t23 <= store20t21+store22t23;
        store24t27 <= store24t25+store26t27;
        store28t31 <= store28t29+store30t31;
        store0t7 <= store0t3 + store4t7;
        store8t15 <= store8t11 + store12t15;
        store16t23 <= store16t19 + store20t23;
        store24t31 <= store24t27 + store28t31;
        store0t15 <= store0t7 + store8t15;
        store16t31 <= store16t23 + store24t31;
        temp <= store0t15 + store16t31;
        count <= (count[2]&count[0])?3'b000:count+1'b1;
        finish <= (count[2]&count[0])?1'b1:1'b0;
        busy <= (count[2]&count[0])?1'b0:1'b1;
        end
    else 
        begin
        finish<=1'b0;
        end
    end
assign z =MUL?((~a[31]&b[31])|(a[31]&~b[31]))? ~temp+32'b1 :temp :temp;
endmodule        