module Register_32bit(
    input clock,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

always @(posedge clock) begin
   begin
        out <= in;
    end
     end
 endmodule
