`timescale 1ns/1ps

module tb;
    parameter TEST_WIDTH = 8;
    parameter TEST_DEPTH = 8;

    reg  [$clog2(TEST_DEPTH)-1:0] t_sel;
    wire [TEST_WIDTH-1:0]         t_dout;

    // Instantiate module using parameter override syntax
    lut #(
        .WIDTH(TEST_WIDTH),
        .DEPTH(TEST_DEPTH)
    ) U1 (
        .sel(t_sel),
        .dout(t_dout)
    );

    integer i;

    initial begin
        $display("--- Testing Parameterized ROM (DEPTH=%0d, WIDTH=%0d) ---", TEST_DEPTH, TEST_WIDTH);
        
        for (i = 0; i < TEST_DEPTH; i = i + 1) begin
            t_sel = i;
            #5; // Wait for combinational delay
            
            if (t_dout !== (i * i)) begin
                $display("FAIL at address %0d: Expected %0d, Got %0d", i, (i * i), t_dout);
            end else begin
                $display("PASS at address %0d: Data = %0d", i, t_dout);
            end
        end

        $finish;
    end
endmodule
