module MIPS_Multicycle(input Clock,Reset);
wire [31:0] i1,i2,i3,i4,i5,alu_out_w,i6,i7,i8,i9,pc_o,i10,i11,i12,i13,i14,
i15,i16,i17,i18;
wire w1,w2,w3,w4,w5,w6,w7,w11,w12,w13,w14,w15,w16;
wire [1:0] w8,w9,w10;
wire [2:0] c1;
wire [4:0] f1;
wire [27:0] e1;
reg [31:0] m = 32'd4;

Control_Unit m0 (.clock(Clock),.Opcode(i4[31:26]),.Reset(Reset),
.PCWrite(w1),.PCWriteCond(w2),.IorD(w3),.MemRead(w4),.MemWrite(w5),
.IRWrite(w6),.MemtoReg(w7),.PCSource1(w8[1]),. PCSource0(w8[0]),
.ALUOp1(w9[1]),.ALUOp0(w9[0]),.ALUSrcB1(w10[1]),.ALUSrcB0(w10[0]),
.ALUSrcA(w11),.RegWrite(w12),.RegDst(w13)); // Control Unit Instantiation

AND_Gate m1 (.in1(w14),.in2(w2),.out(w15)); //And Gate Instantiation

OR_Gate m2 (.in1(w15),.in2(w1),.out(w16));  // OR Gate Instantiation

Memory m3 (.Mem_Write(w5),.Mem_Read(w4),.clock(Clock),.Address(i1),
.Write_data(i2),.Mem_Data(i3));  // Instruction Memory Instantiation

Instruction_Register m4(.clk(Clock),.IR_write(w6),.Input(i3),
.Output(i4));           // Instruction Register Instantiation

Register_32bit m5 (.clock(Clock),.reset(Reset),.in(i3),
.out(i5)); //Memory Data Register Instantiation

MUX_2to1_32bit m6 (.in0(i4[20:16]),.in1(i4[15:11]),.sel(w13),
.out(f1));//MUx 1 between Instruction Register and Register File

MUX_2to1_32bit m7 (.in0(alu_out_w),.in1(i5),.sel(w7),
.out(i6)); //MUx 2 between Instruction Register and Register File

register_file m8 (.clock(Clock),.rs(i4[25:21]),.rt(i4[20:16]),.rd(f1),
.write_data(i6),.Read_data1(i7),.Read_data2(i8),.Reg_write(w12),
.PC_in(i9),.OR_PC_in(w16),.PC_out(pc_o)); // Register File Instantiation

sign_extension m9 (.in(i4[15:0]),.out(i10)); //Sign Extension Instantiation

shift_left_32bit m10 (.in(i10),.out(i11)); //shift left by 2 Instantiation

Register_32bit m11 (.clock(Clock),.reset(Reset),.in(i7),
.out(i12)); //Register A Instantiation

Register_32bit m12 (.clock(Clock),.reset(Reset),.in(i8),
.out(i2)); // Register B Instantiation

MUX_2to1_32bit m13 (.in0(pc_o),.in1(i12),.sel(w11),
.out(i14));//2x1 mux before ALU Instantiation

MUX_4to1_32bit m14 (.in0(i2),.in1(m),.in2(i10),.in3(i11),.sel(w10),
.out(i15));//4x1 mux before ALU Instantiation

ALU_Control m15 (.ALU_Op1(w9[1]),.ALU_Op2(w9[0]),.Funct(i4[5:0]),
.ALU_Control(c1)); // ALU Control Instantiation

ALU_Main m16 (.R_data1(i14),.R_data2(i15),.ALU_control(c1),
.ALU_Result(i16),.zero(w14)); // ALU Main Instantiation

Shift_left_28bit m17 (.in(i4[25:0]),.out(e1)); //shift left Instantiation

Concatenation m18 (.in1(pc_o[31:28]),.in2(e1),
.out(i17)); // Concatenation Instantiation

Register_32bit m19 (.clock(Clock),.reset(Reset),.in(i16),
.out(alu_out_w));//ALU out Register Instantiation

MUX_4to1_32bit m20 (.in0(i16),.in1(alu_out_w),.in2(i17),.in3(),
.sel(w8),.out(i9));//4X1 MUX after ALU instantiation

MUX_2to1_32bit m21 (.in0(pc_o),.in1(alu_out_w),.sel(w3),
.out(i1)); //2X1 MUX after PC Instantiation
endmodule
