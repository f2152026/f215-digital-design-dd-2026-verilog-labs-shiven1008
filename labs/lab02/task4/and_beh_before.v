module and_beh_before (input wire a, input wire b, output reg y);
    always @(*) begin
        #5 y = a & b; // Delays execution before reading inputs and driving y
    end
endmodule