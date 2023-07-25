module Instruction_Register(
    input clk, // clock input
    input IR_write, // instruction register write enable
    input [31:0] Input, // instruction input
    output reg [31:0] Output // instruction output
);
always @(posedge clk) begin
    if (IR_write) begin
       Output <= Input;
    end
end

endmodule
