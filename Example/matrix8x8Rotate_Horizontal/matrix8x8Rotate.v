module matrix8x8Rotate_Horizontal (clk,reset,segout,scanout);

input clk,reset;
output reg[7:0] segout;
output reg[2:0] scanout;

reg[25:0] cnt_scan;
reg[3:0] i=0;

reg clk1;
reg [15:0] q[0:7] ;
reg [7:0] dispreg;
	
	//------------------ clock running -----------------------
	always@(posedge clk or negedge reset) begin
		if(!reset) begin
			cnt_scan<=0;
		end
		else begin
			cnt_scan<=cnt_scan+1;
			if (cnt_scan == 12500000) begin
				cnt_scan <=0;
				clk1 = ~clk1;
			end
		end
	end
	
	//---------modify display digit ----------
	always @(posedge clk1 , negedge reset) begin
		if (reset == 0) begin
			q[0] = 16'b1111111111111111;
			q[1] = 16'b1000000111101111;
			q[2] = 16'b1110111111101111;
			q[3] = 16'b1000000100000000;
			q[4] = 16'b1110110111011011;
			q[5] = 16'b1101110110111101;
			q[6] = 16'b1101110101111110;
			q[7] = 16'b0000000001111110;
		end
		else begin
			for(i=0;i<8;i=i+1) begin
				q[i] = q[i]<< 1;
				q[i][0] <= q[i][15];
			end
		end
	end
	//-----------scan and display 7-SEG-------------
	always@(cnt_scan[15:13]) begin
		scanout <= cnt_scan[15:13];
	end

	always@(scanout) begin
		case(scanout)
			0: segout=q[0][15:8];
			1: segout=q[1][15:8];
			2: segout=q[2][15:8];
			3: segout=q[3][15:8];
			4: segout=q[4][15:8];
			5: segout=q[5][15:8];
			6: segout=q[6][15:8];
			7: segout=q[7][15:8];
		default:
			segout=8'b11111111;
		endcase
	end

endmodule