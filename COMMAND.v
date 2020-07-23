`timescale 1ns / 1ps
//COMMAND is the temporary instruction storage used for simulation
//When gernerating bitstrean, use IP dist_mem_gen_0 for instruction storage
module COMMAND(
input [31:0] pc,
output [31:0] command
);
reg [31:0] temp [2047:0];

initial
    $readmemh("command2.txt",temp);
assign command = temp[pc];
endmodule
