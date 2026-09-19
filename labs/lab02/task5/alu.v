module alu (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       op, // 0: ADD, 1: SUB
    output reg  [3:0] result
);
    reg [3:0] b_inv;
    reg [3:0] b_twos;

    // FIX 1: Use @(*) for complete combinational sensitivity list
    always @(*) begin
        if (op == 1'b0) begin
            result = a + b;
        end else begin
            // FIX 2: Use blocking assignments (=) for sequential combinational dependence
            b_inv  = ~b;
            b_twos = b_inv + 1'b1;
            result = a + b_twos;
        end
    end
endmodule
