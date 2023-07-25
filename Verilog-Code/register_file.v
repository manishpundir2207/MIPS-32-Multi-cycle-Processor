module register_file(clock,rs,rt,rd,write_data,Read_data1,
Read_data2,Reg_write,PC_in,OR_PC_in,PC_out);
input[4:0]rs,rt,rd;
input[31:0]write_data,PC_in; 
output [31:0]Read_data1,Read_data2; 
output [31:0]PC_out;
input Reg_write,OR_PC_in;
input clock; 
reg[31:0] Reg_File[0:31];
integer i;
initial 
begin
for(i=0;i<32;i=i+1)
begin
Reg_File[i]<=32'b0;
end
end
initial
begin
Reg_File[10]<=32'd0;
Reg_File[11]<=32'd0;
Reg_File[12]<=32'd0; 
Reg_File[13]<=32'd0; 
Reg_File[14]<=32'd0; 
Reg_File[15]<=32'd0; 
Reg_File[16]<=32'd0; 
Reg_File[17]<=32'd0; 
Reg_File[18]<=32'd0; 
Reg_File[19]<=32'd15; 
Reg_File[20]<=32'd30;
Reg_File[21]<=32'd15;
end
assign PC_out = Reg_File[31];
always@(posedge clock)
begin 
if(OR_PC_in)
Reg_File[31]=PC_in;
if(Reg_write) 
begin
Reg_File[rd]<=write_data; 
end
end
assign Read_data1 = Reg_File[rs]; 
assign  Read_data2 = Reg_File[rt]; 
endmodule