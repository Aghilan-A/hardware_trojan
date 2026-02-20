`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.01.2024 08:30:00
// Design Name: 
// Module Name: SequenceDetectorAndAdder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module carry_lookahead_adder (
  input wire [3:0] a,
  input wire [3:0] b,
  input wire cin,
  output wire [3:0] sum,
  output wire carry
);

  // Implement your 4-bit carry lookahead adder here
  
  // Internal signals
  wire [3:0] g, p, c;

  // Generate and Propagate signals
  assign g[0] = a[0] & b[0];
  assign p[0] = a[0] | b[0];
  assign g[1] = a[1] & b[1];
  assign p[1] = a[1] | b[1];
  assign g[2] = a[2] & b[2];
  assign p[2] = a[2] | b[2];
  assign g[3] = a[3] & b[3];
  assign p[3] = a[3] | b[3];

  // Carry calculation
  assign c[0] = g[0] | (p[0] & cin);
  assign c[1] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
  assign c[2] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
  assign c[3] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);

  // Sum calculation
  assign sum[0] = a[0] ^ b[0] ^ cin;
  assign sum[1] = a[1] ^ b[1] ^ c[0];
  assign sum[2] = a[2] ^ b[2] ^ c[1];
  assign sum[3] = a[3] ^ b[3] ^ c[2];

  // Output
  assign carry = c[3];
 
endmodule

module full_adder (
  input wire a,
  input wire b,
  input wire cin,
  output wire sum,
  output wire carry
);

  assign sum = a ^ b ^ cin;
  assign carry = (a & b) | (a & cin) | (b & cin);

endmodule

module ripple_carry_adder (
  input wire [3:0] a,
  input wire [3:0] b,
  input wire cin,
  output wire [3:0] sum,
  output wire carry
);

  // Implement your 4-bit ripple carry adder here
  // Internal signals
  wire [3:0] sum_internal;
  wire c0, c1, c2; // Carry bits between stages

  // Full Adder modules
  full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum_internal[0]), .carry(c0));
  full_adder fa1 (.a(a[1]), .b(b[1]), .cin(c0), .sum(sum_internal[1]), .carry(c1));
  full_adder fa2 (.a(a[2]), .b(b[2]), .cin(c1), .sum(sum_internal[2]), .carry(c2));
  full_adder fa3 (.a(a[3]), .b(b[3]), .cin(c2), .sum(sum_internal[3]), .carry(carry));

  // Output
  assign sum = sum_internal;


endmodule

module SequenceDetectorAndAdder (
    input wire clk,
    input wire reset,
    input wire in_data,
    output reg sum,
    output reg carry
);

    // Sequence Detector
    reg [3:0] state;
    parameter IDLE = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011, DETECTED = 4'b0100;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else begin
            case (state)
                IDLE: if (in_data) state <= S1; else state <= IDLE;
                S1: if (in_data) state <= S2; else state <= IDLE;
                S2: if (~in_data) state <= IDLE; else state <= S3;
                S3: if (in_data) state <= DETECTED; else state <= IDLE;
                DETECTED: state <= IDLE;
                default: state <= IDLE;
            endcase
        end
    end

    // 4-bit Full Adder
    wire [3:0] fa_sum;
    wire fa_carry;
    wire [3:0] a = 4'b1101; // Sequence to detect
    wire [3:0] b = 4'b0000; // Input to 4-bit full adder (modify as needed)

    carry_lookahead_adder cla (.a(a), .b(b), .cin(1'b0), .sum(fa_sum), .carry(fa_carry));
    ripple_carry_adder fa (.a(a), .b(b), .cin(1'b0), .sum(fa_sum), .carry(fa_carry));

    // Output assignment based on state
    always @* begin
        case (state)
            DETECTED: begin
                sum = 1'b1;
                carry = fa_carry;
            end
            default: begin
                sum = fa_sum[3]; // Output of ripple carry adder
                carry = fa_carry; // Output of ripple carry adder
            end
        endcase
    end

endmodule





