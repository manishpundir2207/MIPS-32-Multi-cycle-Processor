module Memory(input Mem_Write,Mem_Read,clock,
input[31:0]Address,Write_data,output reg [31:0] Mem_Data);
reg[7:0] Data_Mem [0:4095]; 
initial
begin
//add $10(t2) $19(s3) $20(s4)
Data_Mem[0]=8'h02;
Data_Mem[1]=8'h74;
Data_Mem[2]=8'h50;
Data_Mem[3]=8'h20;

//sub $10(t2) $20(s4) $19(s3)
Data_Mem[4]=8'h02;
Data_Mem[5]=8'h93;
Data_Mem[6]=8'h50;
Data_Mem[7]=8'h22;

//or $10(t2) $20(s4) $19(s3)
Data_Mem[8]=8'h02;
Data_Mem[9]=8'h93;
Data_Mem[10]=8'h50;
Data_Mem[11]=8'h25;

//and $10(t2) $20(s4) $19(s3)
Data_Mem[12]=8'h02;
Data_Mem[13]=8'h93;
Data_Mem[14]=8'h50;
Data_Mem[15]=8'h24;

//slt $10(t2) $20(s4) $19(s3)
Data_Mem[16]=8'h02;
Data_Mem[17]=8'h93;
Data_Mem[18]=8'h50; 
Data_Mem[19]=8'h2a;

// lw $t2 0x28($zero) load 40 41 42 43 place data in the register
Data_Mem[20]=8'h8c;
Data_Mem[21]=8'h0a;
Data_Mem[22]=8'h00; 
Data_Mem[23]=8'h28;

// sw $t2 0x30($zero) load 48 49 50 51 place data in the register
Data_Mem[24]=8'hac;
Data_Mem[25]=8'h0a;
Data_Mem[26]=8'h00; 
Data_Mem[27]=8'h30;

// beq $t3(19) $t5(21) 0x002
Data_Mem[28]=8'h11;
Data_Mem[29]=8'h6d;
Data_Mem[30]=8'h00; 
Data_Mem[31]=8'h03;

Data_Mem[40]=8'h33;
Data_Mem[41]=8'h22;
Data_Mem[42]=8'h11; 
Data_Mem[43]=8'h00;

//j 0x00 i.e. jump to zero
Data_Mem[44]=8'h08;
Data_Mem[45]=8'h00;
Data_Mem[46]=8'h00; 
Data_Mem[47]=8'h00;

end
always@(*)
begin 
case(Mem_Read)
  1'b1: begin
    Mem_Data[31:24] = Data_Mem[Address];
    Mem_Data[23:16] = Data_Mem[Address+32'd1];
    Mem_Data[15:8] = Data_Mem[Address+32'd2];        
    Mem_Data[7:0] = Data_Mem[Address+32'd3];
  end
endcase
end 
always@(posedge clock)
begin
case(Mem_Write)
  1'b1: begin
    Data_Mem[Address] = Write_data[31:24];
    Data_Mem[Address+32'd1] = Write_data[23:16];
    Data_Mem[Address+32'd2] = Write_data[15:8];
    Data_Mem[Address+32'd3] = Write_data[7:0];
  end 
endcase
end
endmodule
