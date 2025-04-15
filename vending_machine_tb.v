// Testbench for Vending Machine Module
`timescale 1ns/1ps

module vending_machine_tb;
    // Testbench signals
    reg clk;
    reg reset;
    reg N;    // Nickel (5 cents)
    reg D;    // Dime (10 cents)
    wire open; // Output signal indicating item dispensed
    
    // Instantiate the vending machine module
    vending_machine uut (
        .clk(clk),
        .reset(reset),
        .N(N),
        .D(D),
        .open(open)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end
    
    // Testing procedure
    initial begin
        // Initialize waveform dump for visualization
        $dumpfile("vending_machine.vcd");
        $dumpvars(0, vending_machine_tb);
        
        // Initialize signals
        reset = 1;
        N = 0;
        D = 0;
        
        // Reset the machine
        #10 reset = 0;
        
        // Test Case 1: Insert nickel, then dime (5+10=15 cents)
        #10 N = 1;
        #10 N = 0;
        #10 D = 1;
        #10 D = 0;
        #10 $display("Test Case 1: Open = %b (Expected: 1)", open);
        
        // Reset for next test
        #10 reset = 1;
        #10 reset = 0;
        
        // Test Case 2: Insert two nickels, then another nickel (5+5+5=15 cents)
        #10 N = 1;
        #10 N = 0;
        #10 N = 1;
        #10 N = 0;
        #10 N = 1;
        #10 N = 0;
        #10 $display("Test Case 2: Open = %b (Expected: 1)", open);
        
        // Reset for next test
        #10 reset = 1;
        #10 reset = 0;
        
        // Test Case 3: Insert dime, then nickel (10+5=15 cents)
        #10 D = 1;
        #10 D = 0;
        #10 N = 1;
        #10 N = 0;
        #10 $display("Test Case 3: Open = %b (Expected: 1)", open);
        
        // Reset for next test
        #10 reset = 1;
        #10 reset = 0;
        
        // Test Case 4: Insert dime + dime (more than enough money)
        #10 D = 1;
        #10 D = 0;
        #10 D = 1;
        #10 D = 0;
        #10 $display("Test Case 4: Open = %b (Expected: 1)", open);
        
        // Run for a little longer to see the results
        #20;
        
        // End simulation
        $display("Simulation complete!");
        $finish;
    end
    
    // Monitor state changes
    always @(posedge clk) begin
        if (open)
            $display("Time %t: Vending machine door is now open!", $time);
    end
endmodule