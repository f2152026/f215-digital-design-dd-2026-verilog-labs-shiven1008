module and_beh_intra (input wire a, input wire b, output reg y);
    always @(*) begin
        y = #DELAY a & b; // Evaluates (a & b) immediately, delays updating y
    end
endmodule