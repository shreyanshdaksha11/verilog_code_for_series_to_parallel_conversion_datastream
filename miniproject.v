module mux(I,S,Y);
input [3:0]I;
input [1:0]S;
output Y;
assign Y=S[1] ? (S[0]?I[3]:I[2]) : (S[0]?I[1]:I[0]);
endmodule	


module decoder(input [1:0]S,output reg[3:0] Y);
always @(*) 
begin
case(S)
	2'b00: Y=4'b0001;
	2'b01: Y=4'b0010;
	2'b10: Y=4'b0100;
	2'b11: Y=4'b1000;
endcase
end
endmodule


module latch(input D ,input EN ,output reg Q);
always @(*) begin
if(EN)
	Q=D;
end
endmodule

 
module miniproject(input [3:0]I,input CLK, input EN,output [3:0]Y);
reg [1:0] counter=0;
wire muxout;
wire [3:0]decoderout;
wire [3:0]latchout;
always @(posedge CLK)
begin
counter<=counter+1;
end
mux m1(.I(I),.S(counter),.Y(muxout));
decoder m2(.S(counter),.Y(decoderout));
genvar i;
generate for(i=0; i<4;i=i+1)
begin :latcharray
latch l(.D(muxout),.EN(decoderout[i] & EN),.Q(latchout[i]));
end
endgenerate
assign Y=latchout;
endmodule








