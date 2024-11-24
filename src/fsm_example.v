`timescale 1ns / 1ps
//
//  There are implementation problems with this implementation of the finite state machine!
//  This code will produce inferred latches.
//  Fix the code to remove the inferred latches.
//  ==> Recall that this means every always@(*) combinatorial block needs to define its outputs for every possible input.
//
//  The github tests will make sure your code: (1) still works and, (2) has no latches.
//  If it passes both tests, you will see a green check mark at the top of the repository.
//

module fsm_example(
    input clk,
    input pulse1,
    input pulse2,
    output reg increment,
    output reg decrement);

  localparam IDLE = 0;
  localparam P1FIRST = 1;
  localparam P2FIRST = 2;
  localparam INCOCC = 3;
  localparam DECOCC = 4;

  reg [2:0] state = IDLE;
  reg [2:0] next_state;

  always @(posedge clk)
  begin
    state <= next_state;
  end

  always @(*)
    case (state)
      IDLE:
        if (pulse1)
          next_state = P1FIRST;
        else if (pulse2)
          next_state = P2FIRST;

      P1FIRST:
        if (pulse2)
          next_state = INCOCC;

      P2FIRST:
        if (pulse1)
          next_state = DECOCC;

      INCOCC:
        next_state = IDLE;

      DECOCC:
        next_state = IDLE;

      default:
        next_state = IDLE;
    endcase

  always @(*)
  begin
     if (state == IDLE) begin
	increment = 0;
	decrement = 0;
     end
     if (state == INCOCC) increment = 1;
     if (state == DECOCC) decrement = 1;
  end

endmodule


