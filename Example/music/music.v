module music (clk, reset, buzz);
input clk, reset;
output buzz;
 
wire [4:0] playIndex;
wire [12:0] tone;
 
	autoPlay play(reset, clk, playIndex);
	toneTable toneOut(playIndex, tone);
	toneOut speeker(clk,tone,buzz);
 
endmodule
 