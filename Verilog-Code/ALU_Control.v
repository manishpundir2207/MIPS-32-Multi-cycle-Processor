module ALU_Control(
input ALU_Op1, ALU_Op2,
input [5:0] Funct,
output reg [2:0] ALU_Control);
always @(*)
begin
case ({ALU_Op1, ALU_Op2})
2'b00: ALU_Control = 3'b010; // add
2'b01: ALU_Control = 3'b110; // add
2'b10:
case (Funct)
6'b100100: ALU_Control = 3'b000; // and
6'b100101: ALU_Control = 3'b001; // or
6'b100000: ALU_Control = 3'b010; // add
6'b100010: ALU_Control = 3'b110; // sub
6'b101010: ALU_Control = 3'b111; // slt
default: ALU_Control = 3'b000;
endcase
default: ALU_Control = 3'b000;
endcase
end
endmodule
