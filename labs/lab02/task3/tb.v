`timescale 1ns/1ps

module tb;
    reg  [1:0] t_a, t_b;
    wire       t_gt, t_lt, t_eq;

    reg        exp_gt, exp_lt, exp_eq;
    integer    errors = 0;
    integer    i;

    // Instantiate 2-bit comparator
    comp2 UUT (
        .A(t_a),
        .B(t_b),
        .GT(t_gt),
        .LT(t_lt),
        .EQ(t_eq)
    );

    initial begin
        $display("Starting Comparator Self-Checking Test...");

        for (i = 0; i < 16; i = i + 1) begin
            {t_a, t_b} = i[3:0];
            #5;

            // Golden Reference Model calculated independently
            exp_gt = (t_a > t_b);
            exp_lt = (t_a < t_b);
            exp_eq = (t_a == t_b);

            // Self-checking condition using !==
            if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
                $display("FAIL at time %0t: A=%b B=%b | Got (GT=%b, LT=%b, EQ=%b) Expected (GT=%b, LT=%b, EQ=%b)",
                         $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
                errors = errors + 1;
            end
        end

        $write("Testbench Complete: ");
        $display("%0d / 16 passed. Total Errors = %0d", (16 - errors), errors);
        $finish;
    end
endmodule
