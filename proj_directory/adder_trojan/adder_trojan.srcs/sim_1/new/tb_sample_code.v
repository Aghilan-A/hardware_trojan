`timescale 1ns / 1ps

module SequenceDetectorAndAdder_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg clk;
    reg reset;
    reg in_data;
    wire sum;
    wire carry;

    // Instantiate the unit under test (UUT)
    SequenceDetectorAndAdder dut (
        .clk(clk),
        .reset(reset),
        .in_data(in_data),
        .sum(sum),
        .carry(carry)
    );

    // Clock generation
    always #((CLK_PERIOD / 2)) clk = ~clk;

    // Reset generation
    initial begin
        reset = 1;
        #100;
        reset = 0;
    end

    // Stimulus
    initial begin
        #10; // Wait for a few clock cycles before providing input

        // Test case 1: No sequence detected
        in_data = 0;
        #20; // Wait
        in_data = 1;
        #20; // Wait
        in_data = 0;
        #20; // Wait
        in_data = 1;
        #20; // Wait

        // Test case 2: Sequence detected
        in_data = 1;
        #20; // Wait
        in_data = 0;
        #20; // Wait
        in_data = 1;
        #20; // Wait
        in_data = 1; // Sequence detected
        #20; // Wait

        // End simulation
        $finish;
    end

endmodule
