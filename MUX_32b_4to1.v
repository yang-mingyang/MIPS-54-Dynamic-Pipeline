`timescale 1ns / 1ps
module MUX_32b_4to1(
input [31:0] iData0,
input [31:0] iData1,
input [31:0] iData2,
input [31:0] iData3,
input [1:0] select,
output [31:0] oData
);
assign oData = (select[1]&select[0])?iData3:
                (select[1]&~select[0])?iData2:
                (~select[1]&select[0])?iData1:iData0;
endmodule
