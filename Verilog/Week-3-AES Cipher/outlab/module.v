module Encrypt(
    input [63:0]  plaintext  ,
    input [63:0]  secretKey  ,
    output [63:0] ciphertext 
);
genvar i;
wire [63:0] state[0:10];
wire [63:0] key[0:10];
AddRoundKey encr1(plaintext,secretKey,state[0]);
NextKey encr2(secretKey,key[0]);
generate
    for(i=0;i<10;i=i+1) begin : encryptloop
        Round encr3(state[i],key[i],state[i+1]);
        NextKey encr4(key[i],key[i+1]);
    end
endgenerate
assign ciphertext = state[10];

endmodule

module Round(
    input  [63:0] currentState ,
    input  [63:0] roundKey     ,
    output [63:0] nextState    
);
genvar i;
wire [63:0] tmp, tmp1;
generate
    for(i=0;i<16;i=i+1) begin : roundloop
        wire [3:0] in,out;
        assign in[3:0] = currentState[63-4*i:60-4*i];
        SBox roun1(in,out);
        assign tmp[63-4*i:60-4*i] = out[3:0];
    end
endgenerate
ShiftRows roun2(tmp,tmp1);
AddRoundKey roun3(tmp1,roundKey,nextState);
endmodule

module SBox(
    input [3:0]in ,
    output [3:0]out
);
assign out[3] = (~in[3]&~in[2]&~in[1]&in[0])|(in[3]&~in[2]&~in[1]&~in[0])|(~in[3]&in[2]&~in[0])|(in[3]&in[2]&in[0])|(in[2]&in[1]&in[0])|(in[1]&in[0]&in[3]);
assign out[2] = (~in[3]&~in[2]&in[1]&in[0])|(~in[3]&~in[1]&~in[0])|(in[3]&~in[2]&in[1])|(in[3]&in[2]&~in[1])|(~in[3]&in[2]&~in[0]);
assign out[1] = (~in[3]&in[2]&in[1]&~in[0])|(~in[1]&in[0])|(~in[3]&~in[2]&~in[1])|(in[3]&~in[2]&~in[0]);
assign out[0] = (~in[3]&in[0]&~in[1])|(~in[0]&in[2]&~in[1])|(~in[3]&in[2]&~in[0])|(in[3]&in[2]&in[1])|(in[3]&in[1]&~in[0]);
endmodule

module NextKey(
    input  [63:0] currentKey,
    output [63:0] nextKey
);
assign nextKey[63:4] = currentKey[59:0];
assign nextKey[3:0] = currentKey[63:60];
endmodule

module ShiftRows(
    input  [63:0] currentState ,
    output [63:0] nextState    
);
assign nextState[15:0] = currentState[15:0];

assign nextState[19:16] = currentState[31:28];
assign nextState[31:20] = currentState[27:16];

assign nextState[39:32] = currentState[47:40];
assign nextState[47:40] = currentState[39:32];

assign nextState[59:48] = currentState[63:52];
assign nextState[63:60] = currentState[51:48];
endmodule

module AddRoundKey(
    input  [63:0] currentState ,
    input  [63:0] roundKey     ,
    output [63:0] nextState    
);
assign nextState = currentState^roundKey;
endmodule
