`timescale 1ns/1ps

module tb;
    reg  [3:0] t_a, t_b;
    reg        t_op;
    wire [3:0] t_result;

    reg  [3:0] exp_result;
    integer    errors = 0;

    alu UUT (
        .a(t_a),
        .b(t_b),
        .op(t_op),
        .result(t_result)
    );

    initial begin
        $display("--- Starting ALU Bug Finding Test ---");

        // Test 1: Addition Test
        t_a = 4'd5; t_b = 4'd3; t_op = 1'b0; #5;
        exp_result = 4'd8;
        if (t_result !== exp_result) begin
            $display("FAIL ADD: A=%d B=%d | Got=%d Expected=%d", t_a, t_b, t_result, exp_result);
            errors = errors + 1;
        end

        // Test 2: Mode Toggle sensitivity check (Keep operands, toggle op)
        t_op = 1'b1; #5; // Subtraction (5 - 3 = 2)
        exp_result = 4'd2;
        if (t_result !== exp_result) begin
            $display("FAIL SUB (SENSITIVITY BUG): Op switched to SUB, Got=%d Expected=%d", t_result, exp_result);
            errors = errors + 1;
        end

        // Test 3: Subtraction non-blocking pipeline check
        t_a = 4'd9; t_b = 4'd4; t_op = 1'b1; #5; // (9 - 4 = 5)
        exp_result = 4'd5;
        if (t_result !== exp_result) begin
            $display("FAIL SUB (NON-BLOCKING BUG): A=%d B=%d | Got=%d Expected=%d", t_a, t_b, t_result, exp_result);
            errors = errors + 1;
        end

        $display("ALU Test completed with %0d errors.", errors);
        $finish;
    end
endmodule