module and_df (input wire a, input wire b, output wire y);
    assign #5 y = a & b; // Replace #DELAY with #1, #2, or #3
endmodule