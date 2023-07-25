module Control_Unit (
    input [5:0] Opcode,input clock,input Reset,
    output reg PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite,
    MemtoReg, PCSource1, PCSource0, ALUOp1, ALUOp0, ALUSrcB1, ALUSrcB0,
     ALUSrcA,RegWrite, RegDst);
reg [3:0] state =4'b0, next_state;
parameter Inst_Fetch=4'b0000,Inst_Dec=4'b0001,Mem_addr_comp=4'b0010,
Mem_acc_lw=4'b0011,Write_back=4'b0100,Mem_acc_sw=4'b0101,Exec=4'b0110,
R_type_comp=4'b0111,Branch_comp=4'b1000,Jump_comp=4'b1001;
always@(*)
begin
case(state)
Inst_Fetch: next_state = Inst_Dec;
Inst_Dec: 
begin
case (Opcode)
6'b100011: next_state = Mem_addr_comp;
6'b101011: next_state = Mem_addr_comp;
6'b000000: next_state = Exec;
6'b000010: next_state = Jump_comp;
6'b000100: next_state = Branch_comp;
endcase
end
Mem_addr_comp:
begin
case (Opcode)
6'b100011 : next_state = Mem_acc_lw;
6'b101011 :next_state = Mem_acc_sw;
endcase
end
Mem_acc_lw:next_state=Write_back;
Write_back:next_state=Inst_Fetch;
Mem_acc_sw:next_state=Inst_Fetch;
Exec:next_state=R_type_comp;
R_type_comp:next_state=Inst_Fetch;
Branch_comp:next_state=Inst_Fetch;
Jump_comp:next_state=Inst_Fetch;
endcase
end
always@(posedge clock or posedge Reset)
begin
if(Reset)
state<=Inst_Fetch;
else
begin
state<=next_state;
end
end
always @(*)
begin
case(state)
Inst_Fetch: 
begin
PCWrite = 1;PCWriteCond = 0;IorD = 0;MemRead = 1;MemWrite = 0;IRWrite = 1;
MemtoReg = 0;PCSource1 = 0; PCSource0 = 0;ALUOp1 = 0 ;ALUOp0 = 0; 
ALUSrcB1 = 0;ALUSrcB0 = 1;ALUSrcA = 0;RegWrite = 0; RegDst = 0;
end
Inst_Dec:
begin
PCWrite = 0;PCWriteCond = 0;IorD = 0;MemRead = 0;MemWrite = 0;IRWrite = 0;
MemtoReg = 0;PCSource1 = 0; PCSource0 = 0;ALUOp1 = 0 ;ALUOp0 = 0;
 ALUSrcB1 = 1;ALUSrcB0 = 1;ALUSrcA = 0;RegWrite = 0; RegDst = 0;
end
Mem_addr_comp:
begin
PCWrite = 0;PCWriteCond = 0;IorD = 0;MemRead = 0;MemWrite = 0;IRWrite = 0;
MemtoReg = 0;PCSource1 = 0; PCSource0 = 0;ALUOp1 = 0 ;ALUOp0 = 0; 
ALUSrcB1 = 1;ALUSrcB0 = 0;ALUSrcA = 1;RegWrite = 0; RegDst = 0;
end
Mem_acc_lw:
begin
PCWrite = 0;PCWriteCond = 0;IorD = 1;MemRead = 1;MemWrite = 0;IRWrite = 0;
MemtoReg = 0;PCSource1 = 0; PCSource0 = 0;ALUOp1 = 0 ;ALUOp0 = 0; 
ALUSrcB1 = 0;ALUSrcB0 = 0;ALUSrcA = 0;RegWrite = 0; RegDst = 0;
end
Write_back:
begin
PCWrite = 0;PCWriteCond = 0;IorD = 0;MemRead = 0;MemWrite = 0;IRWrite = 0;
MemtoReg = 1;PCSource1 = 0; PCSource0 = 0;ALUOp1 = 0 ;ALUOp0 = 0; 
ALUSrcB1 = 0;ALUSrcB0 = 0;ALUSrcA = 0;RegWrite = 1; RegDst = 0;
end
Mem_acc_sw:
begin
PCWrite = 0;PCWriteCond = 0;IorD = 1;MemRead = 0;MemWrite = 1;IRWrite = 0;
MemtoReg = 0;PCSource1 = 0; PCSource0 = 0;ALUOp1 = 0 ;ALUOp0 = 0;
 ALUSrcB1 = 0;ALUSrcB0 = 0;ALUSrcA = 0;RegWrite = 0; RegDst = 0;
end
Exec:
begin
PCWrite = 0;PCWriteCond = 0;IorD = 0;MemRead = 0;MemWrite = 0;IRWrite = 0;
MemtoReg = 0;PCSource1 = 0; PCSource0 = 0;ALUOp1 = 1 ;ALUOp0 = 0;
 ALUSrcB1 = 0;ALUSrcB0 = 0;ALUSrcA = 1;RegWrite = 0; RegDst = 0;
end
R_type_comp:
begin
PCWrite = 0;PCWriteCond = 0;IorD = 0;MemRead = 0;MemWrite = 0;IRWrite = 0;
MemtoReg = 0;PCSource1 = 0; PCSource0 = 0;ALUOp1 = 0;ALUOp0 = 0;
 ALUSrcB1 = 0;ALUSrcB0 = 0;ALUSrcA = 0;RegWrite = 1; RegDst = 1;
end
Branch_comp:
begin
PCWrite = 0;PCWriteCond = 1;IorD = 0;MemRead = 0;MemWrite = 0;IRWrite = 0;
MemtoReg = 0;PCSource1 = 0; PCSource0 = 1;ALUOp1 = 0;ALUOp0 = 1;
 ALUSrcB1 = 0;ALUSrcB0 = 0;ALUSrcA = 1;RegWrite = 0; RegDst = 0;
end
Jump_comp:
begin
PCWrite = 1;PCWriteCond = 0;IorD = 0;MemRead = 0;MemWrite = 0;IRWrite = 0;
MemtoReg = 0;PCSource1 = 1; PCSource0 = 0;ALUOp1 = 0;ALUOp0 = 0;
 ALUSrcB1 = 0;ALUSrcB0 = 0;ALUSrcA = 0;RegWrite = 0; RegDst = 0;
end
endcase
end
endmodule