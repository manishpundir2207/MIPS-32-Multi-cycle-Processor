module ALU_Main( input [31:0] R_data1,
  input [31:0] R_data2,
  input [2:0] ALU_control,
  output reg [31:0] ALU_Result,
  output reg zero
);
     always @(*)
  begin
    case(ALU_control)
      3'b000: ALU_Result = R_data1 & R_data2;
      3'b001: ALU_Result = R_data1 | R_data2;
      3'b010: ALU_Result = R_data1 + R_data2;
      3'b110: ALU_Result = R_data1 - R_data2;
      3'b111: ALU_Result = (R_data1 < R_data2) ? 32'd1 : 32'd0;
      default: ALU_Result = R_data1 + R_data2;
    endcase

    zero = (ALU_Result == 0)? 1'b1: 1'b0; 
  end
endmodule

