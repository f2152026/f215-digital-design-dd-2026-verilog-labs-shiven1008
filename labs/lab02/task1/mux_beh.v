module mux_beh (
    input wire I0,
    input wire I1,
    input wire S,
    output reg Y    // FIXED: Must be 'reg' for always block assignment
);
    always @(*) begin
        if (S)
            Y = I1;
        else
            Y = I0;
    end
endmodule