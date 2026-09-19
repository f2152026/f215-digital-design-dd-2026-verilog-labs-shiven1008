module lut #(
    parameter WIDTH = 8,
    parameter DEPTH = 4
)(
    input  wire [$clog2(DEPTH)-1:0] sel,
    output wire [WIDTH-1:0]        dout
);
    // Declare memory array: DEPTH elements, each WIDTH bits wide
    reg [WIDTH-1:0] mem [0:DEPTH-1];

    // TODO 1: Initialize mem[i] = i * i at time 0
    integer i;
    initial begin
        for (i = 0; i < DEPTH; i = i + 1) begin
            mem[i] = i * i;
        end
    end

    // TODO 2: Combinationally drive dout from mem[sel]
    assign dout = mem[sel];

endmodule