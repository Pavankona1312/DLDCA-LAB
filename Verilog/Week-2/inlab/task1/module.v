module dFlipFlop (
    input clk,
    input d,
    output reg q
);
    // Register logic must be written in an always block
    // This block is triggered on the rising edge of the clock
    always @(posedge clk) begin
        q = d;
    end

endmodule

module buffer (
    input d,
    output wire q
);

   assign q = d;

endmodule
