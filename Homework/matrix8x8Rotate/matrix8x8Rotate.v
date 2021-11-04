module matrix8x8Rotate(clk,reset,segout,scanout);

input clk, reset;
output reg[7:0] segout;
output reg[2:0] scanout;
reg[25:0] cnt_scan;
reg[3:0] i=0;
reg clk1;
//reg [7:0] q[0:15]; //V
reg [7:0] q[0:7];

reg [2:0] Mode = 0; //000:start 001:fish 010:end
reg [3:0] mode = 0;


//------------------ clock running -----------------------
	always@(posedge clk or negedge reset) begin
		if(!reset) begin
			cnt_scan<=0;
		end
		else begin
			cnt_scan<=cnt_scan+1;
			if(cnt_scan == 12500000) begin
				cnt_scan <=0;
				clk1 = ~clk1;
			end
		end
	end
//---------modify display digit ----------
	always @(posedge clk1, negedge reset) begin
		if (reset == 0) begin
			//example
			//q[0]  = 8'b11111111;q[1]  = 8'b10000001;q[2]  = 8'b11101111;q[3]  = 8'b10000001;q[4]  = 8'b11101101;q[5]  = 8'b11011101;q[6]  = 8'b11011101;q[7]  = 8'b00000000;
			//q[8]  = 8'b11111111;q[9]  = 8'b11101111;q[10] = 8'b11101111;q[11] = 8'b00000000;q[12] = 8'b11011011;q[13] = 8'b10111101;q[14] = 8'b01111110;q[15] = 8'b01111110;
			
			Mode <= 0;
			mode <= 0;
		end
		else begin
			//i = i + 1;
			//for(i=0;i<8;i=i+1) begin
			//	q[i] = q[i]<< 1;
			//	q[i][0] <= q[i][29];
			//	marqueeCount <= marqueeCount +1;
			//	if(marqueeCount == 22) begin
			//		mode <= mode +1;
			//	end
			//end
			
			case(Mode)
				3'b000://START
					if(mode==0)begin//S
						q[0] = 8'b11100111;
						q[1] = 8'b11011011;
						q[2] = 8'b11011111;
						q[3] = 8'b11101111;
						q[4] = 8'b11110111;
						q[5] = 8'b11111011;
						q[6] = 8'b11011011;
						q[7] = 8'b11100111;
						mode <=1;
					end
					else if(mode==1)begin//T
						q[0] = 8'b11000001;
						q[1] = 8'b11110111;
						q[2] = 8'b11110111;
						q[3] = 8'b11110111;
						q[4] = 8'b11110111;
						q[5] = 8'b11110111;
						q[6] = 8'b11110111;
						q[7] = 8'b11110111;
						mode <=2;
					end
					else if(mode==2)begin//A
						q[0] = 8'b11100111;
						q[1] = 8'b11011011;
						q[2] = 8'b11011011;
						q[3] = 8'b11011011;
						q[4] = 8'b11000011;
						q[5] = 8'b11011011;
						q[6] = 8'b11011011;
						q[7] = 8'b11011011;
						mode <=3;
					end
					else if(mode==3)begin//R
						q[0] = 8'b10000111;
						q[1] = 8'b10111011;
						q[2] = 8'b10111011;
						q[3] = 8'b10000111;
						q[4] = 8'b10011111;
						q[5] = 8'b10101111;
						q[6] = 8'b10110111;
						q[7] = 8'b10111011;
						mode <=4;
					end
					else if(mode==4)begin//T
						q[0] = 8'b11000001;
						q[1] = 8'b11110111;
						q[2] = 8'b11110111;
						q[3] = 8'b11110111;
						q[4] = 8'b11110111;
						q[5] = 8'b11110111;
						q[6] = 8'b11110111;
						q[7] = 8'b11110111;
						Mode <= 3'b010;
						mode <=0;
					end
				
				3'b010: //END
					if(mode==0) begin//E
						q[0] = 8'b11000001;
						q[1] = 8'b11011111;
						q[2] = 8'b11011111;
						q[3] = 8'b11000011;
						q[4] = 8'b11011111;
						q[5] = 8'b11011111;
						q[6] = 8'b11011111;
						q[7] = 8'b11000001;
						mode <=1;
					end
					else if(mode==1) begin//N
						q[0] = 8'b11011101;
						q[1] = 8'b11011101;
						q[2] = 8'b11001101;
						q[3] = 8'b11010101;
						q[4] = 8'b11011001;
						q[5] = 8'b11011101;
						q[6] = 8'b11011101;
						q[7] = 8'b11011101;
						mode <=2;
					end
					else if(mode==2) begin//D
						q[0] = 8'b11000111;
						q[1] = 8'b11011011;
						q[2] = 8'b11011101;
						q[3] = 8'b11011101;
						q[4] = 8'b11011101;
						q[5] = 8'b11011101;
						q[6] = 8'b11011011;
						q[7] = 8'b11000111;
					end
				
				
			endcase

		end
	end
//-----------scan and display -------------
	always@(cnt_scan[15:13]) begin
		scanout <= cnt_scan[15:13];
	end
	
	always@(scanout) begin
		//case(scanout)
		//	0: segout=q[(i)];
		//	1: segout=q[(i+1) % 30];
		//	2: segout=q[(i+2) % 30];
		//	3: segout=q[(i+3) % 30];
		//	4: segout=q[(i+4) % 30];
		//	5: segout=q[(i+5) % 30];
		//	6: segout=q[(i+6) % 30];
		//	7: segout=q[(i+7) % 30];
		//	default:
		//		segout=8'b11111111;
		//endcase
		case(scanout)
			0: segout=q[0];
			1: segout=q[1];
			2: segout=q[2];
			3: segout=q[3];
			4: segout=q[4];
			5: segout=q[5];
			6: segout=q[6];
			7: segout=q[7];
			default: segout=8'b11111111;
		endcase 
	end
	
endmodule
