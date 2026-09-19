module mux_df (
    input wire I0,
    input wire I1,
    input wire S,
    output wire Y   // FIXED: Must be 'wire' for continuous assign
);
    assign Y = S ? I1 : I0;
endmodule