`timescale 1ns / 1ps
module DRAM(
input clk,   //存储器时钟信号，上升沿时向 ram 内部写入数据
input ena,   //存储器有效信号，高电平时存储器才运行，否则输出 z 
input [31:0] pre_addr,//输入地址，指定数据读写的地址 
input [31:0] data_in, 
input we,    //写使能信号，高电平可写
input [1:0] width,//表示读/写长度
input sign,//表示读出是否为有符号扩展 
output [31:0] data_out, //存储器读出的数据
output reg write_error
);
parameter LENGTH=1024;
reg [7:0]ram[LENGTH-1:0];
//output allocation
//If the addr is out of range, the corresponding output will be z
wire [31:0] addr = pre_addr - 32'h10010000;
wire [7:0] temp3 = (addr+1>LENGTH)?8'bz:ram[addr];
wire [7:0] temp2 = (addr+2>LENGTH)?8'bz:ram[addr+1];
wire [7:0] temp1 = (addr+3>LENGTH)?8'bz:ram[addr+2];
wire [7:0] temp0 = (addr+4>LENGTH)?8'bz:ram[addr+3];
assign data_out = ena?width[1]?{temp3,temp2,temp1,temp0}:
                        width[0]?{{16{sign&temp3[7]}},temp3,temp2}:
                            {{24{sign&temp3[7]}},temp3}:32'bz;
initial
begin
    //$readmemh("dram.txt",ram);
    write_error = 0;
end
//writing module
//If the addr is out of range, writing will not be executed 
always@(posedge clk)
    if(ena)
    begin
        if(we)
        begin
            write_error = 0;
            if(width[1]&&addr+3<LENGTH)
            begin
            ram[addr]<=data_in[31:24];
            ram[addr+1]<=data_in[23:16];
            ram[addr+2]<=data_in[15:8];
            ram[addr+3]<=data_in[7:0];
            end
            else if(width[0]&&addr+1<LENGTH)
            begin
            ram[addr]<=data_in[15:8];
            ram[addr+1]<=data_in[7:0];
            end
            else if(addr<LENGTH)
            begin
            ram[addr]<=data_in[7:0];
            end
            else write_error = 1;
        end
    end
endmodule
