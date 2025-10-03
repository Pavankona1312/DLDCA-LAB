module tb_compare_wire_reg;
    reg clk;
    reg d;
    wire q_comb;
    wire q_ff;

    buffer u_comb (.d(d), .q(q_comb));
    dFlipFlop u_ff (.clk(clk), .d(d), .q(q_ff));

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns clock

    initial begin
        $dumpfile("wave.vcd");   // output VCD file
        $dumpvars(0, tb_compare_wire_reg);  // dump all variables in tb_compare_wire_reg
        $display("Time | clk d | comb q | flipflop q");
        $monitor("%4t |  %b   %b |    %b     |     %b", $time, clk, d, q_comb, q_ff);
        
        d = 0; #7;
        d = 1; #10;
        d = 0; #10;
        d = 1; #10;
        $finish;
    end
endmodule
