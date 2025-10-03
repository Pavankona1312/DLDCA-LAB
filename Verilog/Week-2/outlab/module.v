module getNextState(
    input [2:0] currentState,
    output [2:0] nextState
);
        assign nextState[0] = ~currentState[0];
        assign nextState[1] = currentState[0] ^ currentState[1];
        assign nextState[2] = currentState[2] ^ (currentState[1] & currentState[0]);
endmodule

module threeBitCounter (
    input clk,
    input reset,
    output reg [2:0] count  
);
    wire[2:0] tmp;
    getNextState uut1(count,tmp);
always @(posedge clk) begin
    if (reset==1'b1) begin
        count = 3'b000;
    end
    else begin
    count <= tmp;
    end
end
endmodule

module counterToLights (
    input [2:0] count,
    output [2:0] rgb
);
    assign rgb[2] = ((~count[2])&count[1]&count[0]) | ((~count[1])&(~count[0])) | ((~count[1])&count[2]);
    assign rgb[1] = ~((count[2]|count[1])&(count[1]|count[0])&(count[0]|count[2]));
    assign rgb[0] = ((~count[2])&(~count[0])) | ((~count[0])&count[1]) | ((~count[1])&count[0]&count[2]);
endmodule

module rgbLighter (
    input clk,
    input reset,
    output reg [2:0] rgb
);
    wire[2:0] state;
    wire[2:0] out;
    threeBitCounter uut1(clk,reset,state);
    counterToLights map(state,out);
    always @(posedge clk) begin
        rgb <= out;
    end
endmodule
