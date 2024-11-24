`timescale 1ns / 1ps

module fsm_example_tb;

    // Testbench signals
    reg clk;
    reg pulse1;
    reg pulse2;
    wire increment;
    wire decrement;
   reg	 fail;

    // Instantiate the DUT (Device Under Test)
    fsm_example dut (
        .clk(clk),
        .pulse1(pulse1),
        .pulse2(pulse2),
        .increment(increment),
        .decrement(decrement)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Test procedure
    initial begin
        // Initialize inputs
        pulse1 = 0;
        pulse2 = 0;

        // Wait for a few clock cycles
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       
        // Test pulse1 followed by pulse2 (increment should activate)
        pulse1 = 1;        @(posedge clk);
        pulse1 = 0;        @(posedge clk);
        pulse2 = 1;        @(posedge clk);
        pulse2 = 0;        @(posedge clk);
       @(posedge clk);

        // Test pulse2 followed by pulse1 (decrement should activate)
        pulse2 = 1;        @(posedge clk);
        pulse2 = 0;        @(posedge clk);
        pulse1 = 1;        @(posedge clk);
        pulse1 = 0;        @(posedge clk);
       @(posedge clk);
       
        // Test no pulses (FSM stays in IDLE)
        #50;

        // End simulation
        $stop;
    end

    initial begin
       fail = 0;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 1 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 1) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);
       if (increment != 0 || decrement != 0) fail = 1;
       @(posedge clk);

       $finish_and_return(fail);
       
    end
   
    // Monitor outputs
    initial begin
        $monitor("Time: %0t | pulse1: %b | pulse2: %b | increment: %b | decrement: %b",
                 $time, pulse1, pulse2, increment, decrement);
        $monitor("Time: %0t | clk: %b | fail: %b ",
                 $time, clk, fail);
    end

endmodule
