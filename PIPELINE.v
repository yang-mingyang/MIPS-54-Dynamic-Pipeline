`timescale 1ns / 1ps
module PIPELINE(
input clk_in,
input reset,
output [6:0]oData,
output [7:0]ctrl
);

//clock divider
wire clk;//=clk_in;
DIVIDER Divider(clk_in,reset,clk);

//wires and regs defined below
//IF section
reg IF_work = 1;
wire [31:0] pc_in;
wire [31:0] pc;
wire [31:0] physical_pc = (pc-32'h00400000)/4;
wire [31:0] inst;
//ID section
reg ID_isBreak = 0;
reg ID_work = 0;
reg [31:0] ID_pc = 0;
reg [31:0] ID_inst = 0;
reg ID_cancel = 0;
wire ADD=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b100000)?1:0:0;
wire ADDU=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b100001)?1:0:0;
wire SUB=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b100010)?1:0:0;
wire SUBU=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b100011)?1:0:0;
wire AND=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b100100)?1:0:0;
wire OR=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b100101)?1:0:0;
wire XOR=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b100110)?1:0:0;
wire NOR=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b100111)?1:0:0;
wire SLT=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b101010)?1:0:0;
wire SLTU=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b101011)?1:0:0;
wire SLL=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b000000)?1:0:0;
wire SRL=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b000010)?1:0:0;
wire SRA=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b000011)?1:0:0;
wire SLLV=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b000100)?1:0:0;
wire SRLV=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b000110)?1:0:0;
wire SRAV=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b000111)?1:0:0;
wire JR=(ID_inst[31:26]==6'b0)?(ID_inst[5:0]==6'b001000)?1:0:0;
wire ADDI=(ID_inst[31:26]==6'b001000)?1:0;
wire ADDIU=(ID_inst[31:26]==6'b001001)?1:0;
wire ANDI=(ID_inst[31:26]==6'b001100)?1:0;
wire ORI=(ID_inst[31:26]==6'b001101)?1:0;
wire XORI=(ID_inst[31:26]==6'b001110)?1:0;
wire LW=(ID_inst[31:26]==6'b100011)?1:0;
wire SW=(ID_inst[31:26]==6'b101011)?1:0;
wire BEQ=(ID_inst[31:26]==6'b000100)?1:0;
wire BNE=(ID_inst[31:26]==6'b000101)?1:0;
wire SLTI=(ID_inst[31:26]==6'b001010)?1:0;
wire SLTIU=(ID_inst[31:26]==6'b001011)?1:0;
wire LUI=(ID_inst[31:26]==6'b001111)?1:0;
wire J=(ID_inst[31:26]==6'b000010)?1:0;
wire JAL=(ID_inst[31:26]==6'b000011)?1:0;
wire CLZ=(ID_inst[31:26]==6'b011100)?(ID_inst[5:0]==6'b100000)?1:0:0;
wire JALR=(ID_inst[31:26]==6'b000000)?(ID_inst[5:0]==6'b001001)?1:0:0;
wire BGEZ=(ID_inst[31:26]==6'b000001)?1:0;
wire LB=(ID_inst[31:26]==6'b100000)?1:0;
wire LBU=(ID_inst[31:26]==6'b100100)?1:0;
wire LHU=(ID_inst[31:26]==6'b100101)?1:0;
wire SB=(ID_inst[31:26]==6'b101000)?1:0;
wire SH=(ID_inst[31:26]==6'b101001)?1:0;
wire LH=(ID_inst[31:26]==6'b100001)?1:0;
wire MFC0=(ID_inst[31:26]==6'b010000)?(ID_inst[25:21]==5'b00000)?1:0:0;
wire MTC0=(ID_inst[31:26]==6'b010000)?(ID_inst[25:21]==5'b00100)?1:0:0;
wire MFLO=(ID_inst[31:26]==6'b000000)?(ID_inst[5:0]==6'b010010)?1:0:0;
wire MFHI=(ID_inst[31:26]==6'b000000)?(ID_inst[5:0]==6'b010000)?1:0:0;
wire MTHI=(ID_inst[31:26]==6'b000000)?(ID_inst[5:0]==6'b010001)?1:0:0;
wire MTLO=(ID_inst[31:26]==6'b000000)?(ID_inst[5:0]==6'b010011)?1:0:0;
wire SYSCALL=(ID_inst[31:26]==6'b000000)?(ID_inst[5:0]==6'b001100)?1:0:0;
wire TEQ=(ID_inst[31:26]==6'b000000)?(ID_inst[5:0]==6'b110100)?1:0:0;
wire BREAK=(ID_inst[31:26]==6'b000000)?(ID_inst[5:0]==6'b001101)?1:0:0;
wire ERET=(ID_inst[31:26]==6'b010000)?(ID_inst[5:0]==6'b011000)?1:0:0;
wire MUL=(ID_inst[31:26]==6'b011100)?(ID_inst[5:0]==6'b000010)?1:0:0;
wire MULTU=(ID_inst[31:26]==6'b000000)?(ID_inst[5:0]==6'b011001)?1:0:0;
wire DIV=(ID_inst[31:26]==6'b000000)?(ID_inst[5:0]==6'b011010)?1:0:0;
wire DIVU=(ID_inst[31:26]==6'b000000)?(ID_inst[5:0]==6'b011011)?1:0:0;
wire [25:0] ID_address = ID_inst[25:0];
wire [31:0] ID_imme_s= {{16{ID_inst[15]}},ID_inst[15:0]};
wire [31:0] ID_imme_z= {16'b0,ID_inst[15:0]};
wire [31:0] ID_sa={27'b0,ID_inst[10:6]};
wire [4:0] ID_rs= ID_inst[25:21];
wire [4:0] ID_rt= ID_inst[20:16];
wire [4:0] ID_waddr= (JAL)? 5'b11111:LW||LH||LHU||LB||LBU||ADDI||ADDIU||ANDI||ORI||XORI||LUI||SLTI||SLTIU||MFC0? ID_rt:ID_inst[15:11];
wire [3:0] ID_aluc;
wire [1:0] ID_a_select;
wire [1:0] ID_b_select;
wire ID_jump; 
wire bubble;
wire ID_rena = (ID_cancel||bubble)?0:LW||LH||LHU||LB||LBU;
wire ID_wena =  (ID_cancel||bubble)?0:SB||SH||SW;
wire [1:0] ID_width;
wire ID_wsign = LB|LH|LW;
wire ID_wb_ena =  (ID_cancel||bubble)?0:MUL||MULTU?0:ADD||ADDU||SUB||SUBU||AND||OR||XOR||NOR||SLT||SLTU||SLL||SRL||SRA||SLLV||SRLV||SRAV||ADDI||ADDIU||ORI||XORI||LUI||LW||SLTI||SLTIU;
wire ID_wb_LO = (ID_cancel||bubble)?0:MTLO;
wire ID_wb_HI = (ID_cancel||bubble)?0:MTLO;
wire [31:0] rs_reg;
wire [31:0] rt_reg;
wire [31:0] ID_rs_reg;
wire [31:0] ID_rt_reg;
wire [1:0] ID_rs_reg_select;
wire [1:0] ID_rt_reg_select;
wire [31:0] a = SLL||SRL||SRA?ID_sa:ID_rs_reg;
wire [31:0] b = ADDI||ADDIU||LUI||LW||LH||LHU||LB||LBU||SW||SB||SH||SLTI? ID_imme_s:ANDI||ORI||XORI||SLTIU? ID_imme_z:ID_rt_reg;
wire [31:0] npc = pc+32'b100;
wire [31:0] ID_npc = ID_pc+32'b100;
wire [31:0] pc_offset1 = ID_npc+{ID_imme_s[29:0],2'b0};  
wire [31:0] pc_offset2 = {ID_npc[31:28],ID_address,2'b0};
wire [1:0] pc_select;
//EX section 
reg EX_work = 0;
reg EX_isMULTing = 0;
reg EX_isDIVing = 0;
reg EX_continue_mult = 0;
reg EX_continue_div = 0;
reg [4:0] EX_waddr = 0;
reg [4:0] EX_wb_ena = 0;
reg [4:0] EX_rena = 0;
reg [4:0] EX_wena = 0;
reg [1:0] EX_width = 0;
reg EX_wsign = 0;
reg [31:0] EX_rt_reg = 0;
reg [4:0] EX_mult_rd;
reg [4:0] EX_div_rd;
reg EX_wb_LO = 0;
reg EX_wb_HI = 0;
reg [31:0] EX_rs_reg = 0;
reg [31:0] EX_hi;
reg [31:0] EX_lo;
wire EX_conflict_rt = ~EX_work?0:(EX_wb_ena&ID_rt==EX_waddr)?1:0;
wire EX_conflict_rs = ~EX_work?0:(EX_wb_ena&ID_rs==EX_waddr)?1:0;
wire EX_conflict_lo = ~EX_work?0:(EX_wb_LO)?1:0;
wire EX_conflict_hi = ~EX_work?0:(EX_wb_HI)?1:0;
wire [31:0] alu_out;
wire zero;
wire carry;
wire negative;
wire overflow;
wire mult_busy;
wire div_busy;
wire [63:0] mult_out;
wire [31:0] q;
wire [31:0] r;
wire mult_finish;
wire div_finish;
wire [31:0] EX_result =MFLO?EX_lo:MFHI?EX_hi:EX_continue_div?q:EX_continue_mult?mult_out[31:0]:alu_out;
wire mult_conflict = EX_work&(((ID_rs==EX_mult_rd)|(ID_rt==EX_mult_rd)|MFLO|MFHI)&EX_isMULTing);
wire div_conflict = EX_work&(((ID_rs==EX_div_rd)|(ID_rt==EX_div_rd)|MFLO|MFHI)&EX_isDIVing);
//MEM section
reg MEM_work = 0;
reg [31:0] MEM_result = 0;
reg [4:0] MEM_waddr = 0;
reg MEM_wb_ena = 0;
reg MEM_rena = 0;
reg MEM_wb_LO = 0;
reg MEM_wb_HI = 0;
reg [31:0] MEM_LO_in = 0;
reg [31:0] MEM_HI_in = 0;
wire [31:0] MEM_out;
wire MEM_conflict_rt = ~MEM_work?0:(MEM_wb_ena)?(ID_rt==MEM_waddr)?1:0:0;
wire MEM_conflict_rs = ~MEM_work?0:(MEM_wb_ena)?(ID_rs==MEM_waddr)?1:0:0;
wire [31:0] reg_wdata = MEM_rena?MEM_out:MEM_result;
wire [31:0] hi;
wire [31:0] lo;
wire [31:0] hi_reg = EX_conflict_hi?EX_continue_div?r:EX_continue_mult?mult_out[63:32]:EX_rs_reg:hi;
wire [31:0] lo_reg = EX_conflict_lo?EX_continue_mult|EX_continue_div?EX_result:EX_rs_reg:lo;

assign pc_select[0] = ID_work&&~ID_cancel&&(((BNE||BEQ||BGEZ)&&ID_jump)||JR);
assign pc_select[1] = ID_work&&~ID_cancel&&(J||JAL||JR);
assign ID_jump = ~ID_work?0:ID_cancel?0:(J||JAL||JR)?1:(ID_rs_reg==ID_rt_reg && BEQ==1)?1:(ID_rs_reg!=ID_rt_reg && BNE==1)?1:(ID_rs_reg[31]==0 && BGEZ==1)?1:0;
assign bubble = ~ID_work?0:((EX_conflict_rt|EX_conflict_rs)&(EX_rena))|mult_finish|div_finish|div_conflict|mult_conflict; 
assign ID_rs_reg_select[0] = EX_conflict_rs||(MEM_conflict_rs&&MEM_rena);
assign ID_rs_reg_select[1] = MEM_conflict_rs&&~EX_conflict_rs;
assign ID_rt_reg_select[0] = EX_conflict_rt||(MEM_conflict_rt&&MEM_rena);
assign ID_rt_reg_select[1] = MEM_conflict_rt&&~EX_conflict_rt;
assign ID_aluc[0] = SUBU||SUB||OR||ORI||NOR||SLT||SLTI||SRL||SRLV||BEQ||BNE||TEQ;
assign ID_aluc[1] = ADD||ADDI||SUB||XOR||XORI||NOR||SLT||SLTI||SLTU||SLTIU||SLL||SLLV||BEQ||BNE||TEQ;
assign ID_aluc[2] = AND||OR||XOR||NOR||SLL||SRL||SRA||SLLV||SRAV||SRLV||ANDI||ORI||XORI;
assign ID_aluc[3] = SLT||SLTU||SLL||SRL||SRA||SLLV||SRAV||SRLV||SLTI||SLTIU||LUI;
//ID_a_select[0] = SLL||SRL||SRA;
//assign ID_a_select[1] = 0;
//assign ID_b_select[0] = ADDI||ADDIU||LUI||LW||LH||LHU||LB||LBU||SW||SB||SH||SLTI||ANDI||ORI||XORI||SLTIU;
//assign ID_b_select[1] = ADDI||ADDIU||LUI||LW||LH||LHU||LB||LBU||SW||SB||SH||SLTI;
assign ID_width[0] = LH|LHU|SH;
assign ID_width[1] = LW|SW;


PCREG Pc(clk,reset,1,bubble||~IF_work,pc_in,pc);
//dist_mem_gen_0 InitCmd(physical_pc,inst);
COMMAND TempCmd(physical_pc,inst);
MUX_32b_4to1 Pc_mux(npc,pc_offset1,pc_offset2,ID_rs_reg,pc_select,pc_in);
MUX_32b_4to1 ID_rs_reg_mux(rs_reg,EX_result,MEM_result,MEM_out,ID_rs_reg_select,ID_rs_reg);
MUX_32b_4to1 ID_rt_reg_mux(rt_reg,EX_result,MEM_result,MEM_out,ID_rt_reg_select,ID_rt_reg);
ALU Alu(clk,a,b,ID_aluc,alu_out,zero,carry,negative,overflow);
wire dram_write_error;
DRAM Dram(clk,EX_rena||EX_wena,EX_result,EX_rt_reg,EX_wena,EX_width,EX_wsign,MEM_out,dram_write_error);
wire [31:0] output_data;
REGFILES Regfiles(clk,reset,MEM_wb_ena,ID_rs,ID_rt,MEM_waddr,reg_wdata,rs_reg,rt_reg,output_data);

REG LO(clk,reset,MEM_wb_LO,32'h00000000,MEM_LO_in,hi);
REG HI(clk,reset,MEM_wb_HI,32'h00000000,MEM_HI_in,lo);

MULT Mult(clk,reset,~ID_cancel&~bubble&IF_work,MUL||MULTU,MUL,a,b,mult_out,mult_finish,mult_busy);
DIV Div(clk,reset,DIV,rs_reg,rt_reg,~ID_cancel&~bubble&IF_work&(DIV||DIVU),q,r,div_finish,div_busy);
always @ (posedge clk)
begin
    //IF section
    IF_work <= ~reset&~ID_isBreak;
    //ID section
    ID_work <= ~reset&IF_work;
    ID_pc <= bubble?ID_pc:pc;
    ID_inst <= bubble?ID_inst:inst;
    ID_cancel <= bubble?ID_cancel:ID_work&&ID_jump;
    ID_isBreak <= ~reset&~ID_cancel&(BREAK||ID_isBreak);
    //EX section
    EX_work <= ~reset&&ID_work;
    EX_isMULTing <= MUL|MULTU|mult_busy;
    EX_isDIVing <= DIV|DIVU|div_busy;
    EX_continue_mult <= mult_finish;
    EX_continue_div <= div_finish;
    EX_waddr <= div_finish?EX_div_rd:mult_finish?EX_mult_rd:ID_waddr;
    EX_rena <= div_finish|mult_finish?1'b0:ID_rena;
    EX_wena <= div_finish|mult_finish?1'b0:ID_wena;
    EX_width <= ID_width;
    EX_wsign <= ID_wsign;
    EX_rt_reg <= ID_rt_reg;
    EX_wb_ena <= div_finish|mult_finish?1'b1:ID_wb_ena;
    EX_wb_LO <= div_finish|mult_finish?1'b1:ID_wb_LO;
    EX_wb_HI <= div_finish|mult_finish?1'b1:ID_wb_HI;
    EX_mult_rd <= ~EX_isMULTing&(MUL|MULTU)?ID_waddr:EX_mult_rd;
    EX_div_rd <= ~EX_isDIVing&(DIV|DIVU)?ID_waddr:EX_div_rd;
    EX_rs_reg <= rs_reg;
    EX_hi <= hi_reg;
    EX_lo <= lo_reg;
    //MEM section
    MEM_work <= ~reset&&EX_work;
    MEM_result <= EX_result;
    MEM_wb_ena <= EX_wb_ena;
    MEM_wb_LO <= EX_wb_LO;
    MEM_wb_HI <= EX_wb_HI;
    MEM_LO_in <= EX_continue_mult|EX_continue_div?EX_result:EX_rs_reg;
    MEM_HI_in <= EX_continue_div?r:EX_continue_mult?mult_out[63:32]:EX_rs_reg;
    MEM_waddr <= EX_waddr;
    MEM_rena <= EX_rena;
    //WB section
end

//testbench
//reg [31:0] EX_pc;
//reg [31:0] MEM_pc;
//reg [31:0] WB_pc;

//always @ (posedge clk)
//begin
//    EX_pc <= ID_pc;
//    MEM_pc <= EX_pc;
//    WB_pc <= MEM_pc;
//end

//display module
seg7 display(clk_in, reset, 1'b1, output_data, oData, ctrl);
endmodule
