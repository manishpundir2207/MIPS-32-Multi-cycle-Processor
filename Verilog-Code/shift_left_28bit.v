module Shift_left_28bit(
    input [25:0] in,
    output reg [27:0] out
    );

always @(in)
	begin
	 out = in << 2;
	 end
	endmodule
