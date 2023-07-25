module sign_extension(in,out);
input[15:0]in; 
output reg [31:0]out;
always@(in)
if(in[15]==1) 
begin
out<={{16{in[15]}},in}; 
end
else if (in[15]==0)
begin
out<={{16{in[15]}},in}; 
end
endmodule
