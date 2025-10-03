module adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    // Fill in the logic for the adder
    assign cout = (a&b)|(cin&a)|(cin&b);
    assign sum = (!a&b&!cin)|(!a&!b&cin)|(a&b&cin)|(a&!b&!cin);
endmodule
