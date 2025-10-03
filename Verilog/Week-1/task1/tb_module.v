module tb_adder;
    reg a, b, cin;
    wire sum, cout;

    adder uut (
        .a(a), .b(b), .cin(cin),
        .sum(sum), .cout(cout)
    );

    integer i;

    initial begin
        $dumpfile("wave.vcd");   // output VCD file
        $dumpvars(0, tb_adder);  // dump all variables in tb_adder
        $display("a b cin | cout sum");
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, cin} = i;
            #10 $display("%b %b  %b  |  %b    %b", a, b, cin, cout, sum);
        end
    end
endmodule
