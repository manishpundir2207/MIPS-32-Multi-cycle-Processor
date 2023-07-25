


module AND_Gate( in1,in2,out);
 input in1,in2;
output reg out;
always@(*)
begin
out =in1 & in2;
end
endmodule
