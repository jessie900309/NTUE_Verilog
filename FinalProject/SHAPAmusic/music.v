module music(clk, reset, buzz,left,center,right,segout,scanout,segoutLED, scanoutLED);

input clk, reset;
reg clk1;
reg [25:0] cnt_scan;
reg [25:0] cnt_num = 12500000; //?ɯ߳t??

//buzz
output buzz;
wire [4:0] playIndex;
wire [12:0] tone;

//7-SEG
output reg [7:0] segoutLED;//abcdefg no h
output reg [1:0] scanoutLED;//num
reg [4:0] score = 0; //0~31
reg [4:0] scoreTarget = 20;

//matrix
input left,center,right;
output reg[7:0] segout;
output reg[2:0] scanout;
reg [7:0] q[0:7];
reg [1:0] Mode = 0; //00~11
reg [3:0] mode = 0; //0~15
reg [7:0] Lblock = 8'b00011111;
reg [7:0] Cblock = 8'b11100111;
reg [7:0] Rblock = 8'b11111000;
reg [7:0] dark = 8'b11111111;

//----------------- music --------------------------------

	autoPlay play(reset, clk, playIndex);
	toneTable toneOut(playIndex, tone);
	toneOut speeker(clk, tone, buzz);
	
//------------------ clock running -----------------------

	always@(posedge clk) begin
		cnt_scan<=cnt_scan+1;
		if (cnt_scan == cnt_num) begin
			cnt_scan <=0;
			clk1 = ~clk1;
		end
	end

//------------------ matrix ------------------------------

	always @(posedge clk1, negedge reset) begin
			if (reset == 0) begin
				// reset matrix
				q[0] = 8'b11111111; q[1] = 8'b11111111; q[2] = 8'b11111111; q[3] = 8'b11111111;
				q[4] = 8'b11111111; q[5] = 8'b11111111; q[6] = 8'b11111111; q[7] = 8'b11111111;
				// reset mode&clock
				Mode <= 3'b000;
				mode <= 0;
				cnt_num <= 12500000;
				score <= 0;
			end
			else begin
				if(score>scoreTarget) begin //:D
					q[0] = dark;
					q[1] = 8'b00111100;
					q[2] = 8'b00111100;
					q[3] = 8'b00111100;
					q[4] = dark;
					q[5] = 8'b11000011;
					q[6] = 8'b11000011;
					q[7] = 8'b11100111;
				end
				else begin
					case(Mode)
						2'b00:
							if(mode==0)begin
								q[0] = Lblock;
								q[1] = dark;
								q[2] = dark;
								q[3] = dark;
								q[4] = dark;
								q[5] = dark;
								q[6] = dark;
								q[7] = dark;
								mode <=1;
							end
							else if(mode==1)begin
								q[0] = Cblock;
								q[1] = Lblock;
								q[2] = dark;
								q[3] = dark;
								q[4] = dark;
								q[5] = dark;
								q[6] = dark;
								q[7] = dark;
								mode <=2;
							end
							else if(mode==2)begin
								q[0] = Cblock;
								q[1] = Cblock;
								q[2] = Lblock;
								q[3] = dark;
								q[4] = dark;
								q[5] = dark;
								q[6] = dark;
								q[7] = dark;
								mode <=3;
							end
							else if(mode==3)begin
								q[0] = Rblock;
								q[1] = Cblock;
								q[2] = Cblock;
								q[3] = Lblock;
								q[4] = dark;
								q[5] = dark;
								q[6] = dark;
								q[7] = dark;
								mode <=4;
							end
							else if(mode==4)begin
								q[0] = Rblock;
								q[1] = Rblock;
								q[2] = Cblock;
								q[3] = Cblock;
								q[4] = Lblock;
								q[5] = dark;
								q[6] = dark;
								q[7] = dark;
								mode <=5;
							end
							else if(mode==5)begin
								q[0] = Rblock;
								q[1] = Rblock;
								q[2] = Rblock;
								q[3] = Cblock;
								q[4] = Cblock;
								q[5] = Lblock;
								q[6] = dark;
								q[7] = dark;
								mode <=6;
							end
							else if(mode==6)begin
								q[0] = Rblock;
								q[1] = Rblock;
								q[2] = Rblock;
								q[3] = Rblock;
								q[4] = Cblock;
								q[5] = Cblock;
								q[6] = Lblock;
								q[7] = dark;
								mode <=7;
							end
							else if(mode==7)begin
								q[0] = Cblock;
								q[1] = Rblock;
								q[2] = Rblock;
								q[3] = Rblock;
								q[4] = Rblock;
								q[5] = Cblock;
								q[6] = Cblock;
								q[7] = Lblock;
								if(left==0)begin
									score <= score+1;
								end
								mode <=8;
							end
							else if(mode==8)begin
								q[0] = Lblock;
								q[1] = Cblock;
								q[2] = Rblock;
								q[3] = Rblock;
								q[4] = Rblock;
								q[5] = Rblock;
								q[6] = Cblock;
								q[7] = Cblock;
								if(center==0)begin
									score <= score+1;
								end
								mode <=9;
							end
							else if(mode==9)begin
								q[0] = Lblock;
								q[1] = Lblock;
								q[2] = Cblock;
								q[3] = Rblock;
								q[4] = Rblock;
								q[5] = Rblock;
								q[6] = Rblock;
								q[7] = Cblock;
								if(center==0)begin
									score <= score+1;
								end
								mode <=10;
							end
							else if(mode==10)begin
								q[0] = Rblock;
								q[1] = Lblock;
								q[2] = Lblock;
								q[3] = Cblock;
								q[4] = Rblock;
								q[5] = Rblock;
								q[6] = Rblock;
								q[7] = Rblock;
								if(right==0)begin
									score <= score+1;
								end
								mode <=11;
							end
							else if(mode==11)begin
								q[0] = dark;
								q[1] = Rblock;
								q[2] = Lblock;
								q[3] = Lblock;
								q[4] = Cblock;
								q[5] = Rblock;
								q[6] = Rblock;
								q[7] = Rblock;
								if(right==0)begin
									score <= score+1;
								end
								mode <=12;
							end
							else if(mode==12)begin
								q[0] = dark;
								q[1] = dark;
								q[2] = Rblock;
								q[3] = Lblock;
								q[4] = Lblock;
								q[5] = Cblock;
								q[6] = Rblock;
								q[7] = Rblock;
								if(right==0)begin
									score <= score+1;
								end
								Mode <=3'b001;
								mode <=0;
							end
						//00 end
						
						2'b01:
							if(mode==0)begin
								q[0] = Lblock;
								q[1] = dark;
								q[2] = dark;
								q[3] = Rblock;
								q[4] = Lblock;
								q[5] = Lblock;
								q[6] = Cblock;
								q[7] = Rblock;
								if(right==0)begin
									score <= score+1;
								end
								mode <=1;
							end
							else if(mode==1)begin
								q[0] = Cblock;
								q[1] = Lblock;
								q[2] = dark;
								q[3] = dark;
								q[4] = Rblock;
								q[5] = Lblock;
								q[6] = Lblock;
								q[7] = Cblock;
								if(center==0)begin
									score <= score+1;
								end
								mode <=2;
							end
							else if(mode==2)begin
								q[0] = Cblock;
								q[1] = Cblock;
								q[2] = Lblock;
								q[3] = dark;
								q[4] = dark;
								q[5] = Rblock;
								q[6] = Lblock;
								q[7] = Lblock;
								if(left==0)begin
									score <= score+1;
								end
								mode <=3;
							end
							else if(mode==3)begin
								q[0] = Rblock;
								q[1] = Cblock;
								q[2] = Cblock;
								q[3] = Lblock;
								q[4] = dark;
								q[5] = dark;
								q[6] = Rblock;
								q[7] = Lblock;
								if(left==0)begin
									score <= score+1;
								end
								mode <=4;
							end
							else if(mode==4)begin
								q[0] = Rblock;
								q[1] = Rblock;
								q[2] = Cblock;
								q[3] = Cblock;
								q[4] = Lblock;
								q[5] = dark;
								q[6] = dark;
								q[7] = Rblock;
								if(right==0)begin
									score <= score+1;
								end
								mode <=5;
							end
							else if(mode==5)begin
								q[0] = Rblock;
								q[1] = Rblock;
								q[2] = Rblock;
								q[3] = Cblock;
								q[4] = Cblock;
								q[5] = Lblock;
								q[6] = dark;
								q[7] = dark;
								mode <=6;
							end
							else if(mode==6)begin
								q[0] = Rblock;
								q[1] = Rblock;
								q[2] = Rblock;
								q[3] = Rblock;
								q[4] = Cblock;
								q[5] = Cblock;
								q[6] = Lblock;
								q[7] = dark;
								mode <=7;
							end
							else if(mode==7)begin
								q[0] = Cblock;
								q[1] = Rblock;
								q[2] = Rblock;
								q[3] = Rblock;
								q[4] = Rblock;
								q[5] = Cblock;
								q[6] = Cblock;
								q[7] = Lblock;
								if(left==0)begin
									score <= score+1;
								end
								mode <=8;
							end
							else if(mode==8)begin
								q[0] = Lblock;
								q[1] = Cblock;
								q[2] = Rblock;
								q[3] = Rblock;
								q[4] = Rblock;
								q[5] = Rblock;
								q[6] = Cblock;
								q[7] = Cblock;
								if(center==0)begin
									score <= score+1;
								end
								mode <=9;
							end
							else if(mode==9)begin
								q[0] = Lblock;
								q[1] = Lblock;
								q[2] = Cblock;
								q[3] = Rblock;
								q[4] = Rblock;
								q[5] = Rblock;
								q[6] = Rblock;
								q[7] = Cblock;
								if(center==0)begin
									score <= score+1;
								end
								mode <=10;
							end
							else if(mode==10)begin
								q[0] = Rblock;
								q[1] = Lblock;
								q[2] = Lblock;
								q[3] = Cblock;
								q[4] = Rblock;
								q[5] = Rblock;
								q[6] = Rblock;
								q[7] = Rblock;
								if(right==0)begin
									score <= score+1;
								end
								mode <=11;
							end
							else if(mode==11)begin
								q[0] = dark;
								q[1] = Rblock;
								q[2] = Lblock;
								q[3] = Lblock;
								q[4] = Cblock;
								q[5] = Rblock;
								q[6] = Rblock;
								q[7] = Rblock;
								if(right==0)begin
									score <= score+1;
								end
								mode <=12;
							end
							else if(mode==12)begin
								q[0] = dark;
								q[1] = dark;
								q[2] = Rblock;
								q[3] = Lblock;
								q[4] = Lblock;
								q[5] = Cblock;
								q[6] = Rblock;
								q[7] = Rblock;
								if(right==0)begin
									score <= score+1;
								end
								Mode <=3'b010;
								mode <=0;
							end
						//01 end
						
					2'b10:
						if(mode==0)begin 
							q[0] = Rblock;
							q[1] = dark;
							q[2] = dark;
							q[3] = Rblock;
							q[4] = Lblock;
							q[5] = Lblock;
							q[6] = Cblock;
							q[7] = Rblock;
							if(right==0)begin
								score <= score+1;
							end
							mode <=1;
						end
						else if(mode==1)begin 
							q[0] = Cblock;
							q[1] = Rblock;
							q[2] = dark;
							q[3] = dark;
							q[4] = Rblock;
							q[5] = Lblock;
							q[6] = Lblock;
							q[7] = Cblock;
							if(center==0)begin
								score <= score+1;
							end
							mode <=2;
						end
						else if(mode==2)begin 
							q[0] = Lblock;
							q[1] = Cblock;
							q[2] = Rblock;
							q[3] = dark;
							q[4] = dark;
							q[5] = Rblock;
							q[6] = Lblock;
							q[7] = Lblock;
							if(left==0)begin
								score <= score+1;
							end
							mode <=3;
						end
						else if(mode==3)begin 
							q[0] = Rblock;
							q[1] = Lblock;
							q[2] = Cblock;
							q[3] = Rblock;
							q[4] = dark;
							q[5] = dark;
							q[6] = Rblock;
							q[7] = Lblock;
							if(left==0)begin
								score <= score+1;
							end
							mode <=4;
						end
						else if(mode==4)begin 
							q[0] = Rblock;
							q[1] = Rblock;
							q[2] = Lblock;
							q[3] = Cblock;
							q[4] = Rblock;
							q[5] = dark;
							q[6] = dark;
							q[7] = Rblock;
							if(right==0)begin
								score <= score+1;
							end
							mode <=5;
						end
						else if(mode==5)begin 
							q[0] = Cblock;
							q[1] = Rblock;
							q[2] = Rblock;
							q[3] = Lblock;
							q[4] = Cblock;
							q[5] = Rblock;
							q[6] = dark;
							q[7] = dark;
							mode <=6;
						end
						else if(mode==6)begin 
							q[0] = Rblock;
							q[1] = Cblock;
							q[2] = Rblock;
							q[3] = Rblock;
							q[4] = Lblock;
							q[5] = Cblock;
							q[6] = Rblock;
							q[7] = dark;
							mode <=7;
						end
						else if(mode==7)begin 
							q[0] = Lblock;
							q[1] = Rblock;
							q[2] = Cblock;
							q[3] = Rblock;
							q[4] = Rblock;
							q[5] = Lblock;
							q[6] = Cblock;
							q[7] = Rblock;
							if(right==0)begin
								score <= score+1;
							end
							mode <=8;
						end
						else if(mode==8)begin 
							q[0] = dark;
							q[1] = Lblock;
							q[2] = Rblock;
							q[3] = Cblock;
							q[4] = Rblock;
							q[5] = Rblock;
							q[6] = Lblock;
							q[7] = Cblock;
							if(center==0)begin
								score <= score+1;
							end
							mode <=9;
						end
						else if(mode==9)begin 
							q[0] = dark;
							q[1] = dark;
							q[2] = Lblock;
							q[3] = Rblock;
							q[4] = Cblock;
							q[5] = Rblock;
							q[6] = Rblock;
							q[7] = Lblock;
							if(left==0)begin
								score <= score+1;
							end
							Mode <=3'b011;
							mode <=0;
						end
					//10 end
					
					2'b11:
						if(mode==0)begin 
							q[0] = Cblock;
							q[1] = dark;
							q[2] = dark;
							q[3] = Lblock;
							q[4] = Rblock;
							q[5] = Cblock;
							q[6] = Rblock;
							q[7] = Rblock;
							if(right==0)begin
								score <= score+1;
							end
							mode <=1;
						end
						else if(mode==1)begin 
							q[0] = Rblock;
							q[1] = Cblock;
							q[2] = dark;
							q[3] = dark;
							q[4] = Lblock;
							q[5] = Rblock;
							q[6] = Cblock;
							q[7] = Rblock;
							if(right==0)begin
								score <= score+1;
							end
							mode <=2;
						end
						else if(mode==2)begin 
							q[0] = Rblock;
							q[1] = Rblock;
							q[2] = Cblock;
							q[3] = dark;
							q[4] = dark;
							q[5] = Lblock;
							q[6] = Rblock;
							q[7] = Cblock;
							if(center==0)begin
								score <= score+1;
							end
							mode <=3;
						end
						else if(mode==3)begin 
							q[0] = Cblock;
							q[1] = Rblock;
							q[2] = Rblock;
							q[3] = Cblock;
							q[4] = dark;
							q[5] = dark;
							q[6] = Lblock;
							q[7] = Rblock;
							if(right==0)begin
								score <= score+1;
							end
							mode <=4;
						end
						else if(mode==4)begin 
							q[0] = Rblock;
							q[1] = Cblock;
							q[2] = Rblock;
							q[3] = Rblock;
							q[4] = Cblock;
							q[5] = dark;
							q[6] = dark;
							q[7] = Lblock;
							if(left==0)begin
								score <= score+1;
							end
							mode <=5;
						end
						else if(mode==5)begin 
							q[0] = Rblock;
							q[1] = Rblock;
							q[2] = Cblock;
							q[3] = Rblock;
							q[4] = Rblock;
							q[5] = Cblock;
							q[6] = dark;
							q[7] = dark;
							mode <=6;
						end
						else if(mode==6)begin 
							q[0] = Cblock;
							q[1] = Rblock;
							q[2] = Rblock;
							q[3] = Cblock;
							q[4] = Rblock;
							q[5] = Rblock;
							q[6] = Cblock;
							q[7] = dark;
							mode <=7;
						end
						else if(mode==7)begin 
							q[0] = Rblock;
							q[1] = Cblock;
							q[2] = Rblock;
							q[3] = Rblock;
							q[4] = Cblock;
							q[5] = Rblock;
							q[6] = Rblock;
							q[7] = Cblock;
							if(center==0)begin
								score <= score+1;
							end
							mode <=8;
						end
						else if(mode==8)begin 
							q[0] = Rblock;
							q[1] = Rblock;
							q[2] = Cblock;
							q[3] = Rblock;
							q[4] = Rblock;
							q[5] = Cblock;
							q[6] = Rblock;
							q[7] = Rblock;
							if(right==0)begin
								score <= score+1;
							end
							mode <=9;
						end
						else if(mode==9)begin 
							q[0] = Lblock;
							q[1] = Rblock;
							q[2] = Rblock;
							q[3] = Cblock;
							q[4] = Rblock;
							q[5] = Rblock;
							q[6] = Cblock;
							q[7] = Rblock;
							if(right==0)begin
								score <= score+1;
							end
							mode <=10;
						end
						else if(mode==10)begin 
							q[0] = dark;
							q[1] = Lblock;
							q[2] = Rblock;
							q[3] = Rblock;
							q[4] = Cblock;
							q[5] = Rblock;
							q[6] = Rblock;
							q[7] = Cblock;
							if(center==0)begin
								score <= score+1;
							end
							mode <=11;
						end
						else if(mode==11)begin 
							q[0] = dark;
							q[1] = dark;
							q[2] = Lblock;
							q[3] = Rblock;
							q[4] = Rblock;
							q[5] = Cblock;
							q[6] = Rblock;
							q[7] = Rblock;
							if(right==0)begin
								score <= score+1;
							end
							Mode <=2'b00;
							mode <=0;
						end
					//11 end
					//music END
					endcase
				end 
			end
		end

//----------- display matrix -----------------------------

	always@(cnt_scan[15:13]) scanout <= cnt_scan[15:13];
	
	always@(scanout) begin
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
	
//----------- display 7-SEG -----------------------------

	always @(posedge cnt_scan[15]) scanoutLED <= scanoutLED + 1;

	always@(scanoutLED) begin 
		if(score>scoreTarget) begin
			case(scanoutLED) //OuO
				2'b00: segoutLED = {1'b1, 7'b1111111};
				2'b01: segoutLED = {1'b1, 7'b1000000};
				2'b10: segoutLED = {1'b1, 7'b1100011};
				2'b11: segoutLED = {1'b1, 7'b1000000};
			endcase
		end	
		else begin
			if(scanoutLED == 2'b11) segoutLED = {1'b1, 7'b1111111};
			if(scanoutLED == 2'b10) segoutLED = {1'b1, 7'b1111111};	
			if(score == 0) begin //0_
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b1000000};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111111};
			end
			if(score == 1) begin //1_
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b1111001};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111111};
			end
			if(score == 2) begin //2_
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0100100};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111111};
			end
			if(score == 3) begin //3_
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0110000};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111111};
			end
			if(score == 4) begin //4_
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0011001};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111111};
			end
			if(score == 5) begin //5_
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0010010};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111111};
			end
			if(score == 6) begin //6_
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0000010};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111111};
			end
			if(score == 7) begin //7_
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b1011000};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111111};
			end
			if(score == 8) begin //8_
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0000000};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111111};
			end
			if(score == 9) begin //9_
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0010000};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111111};
			end
			if(score ==10) begin //01
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b1000000};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111001};
			end
			if(score ==11) begin //11
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b1111001};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111001};
			end
			if(score ==12) begin //21
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0100100};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111001};
			end
			if(score ==13) begin //31
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0110000};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111001};
			end
			if(score ==14) begin //41
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0011001};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111001};
			end
			if(score ==15) begin //51
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0010010};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111001};
			end
			if(score ==16) begin //61
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0000010};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111001};
			end
			if(score ==17) begin //71
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b1011000};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111001};
			end
			if(score ==18) begin //81
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0000000};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111001};
			end
			if(score ==19) begin //91
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b0010000};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b1111001};
			end
			if(score ==20) begin //02
				if(scanoutLED == 2'b00) segoutLED = {1'b1, 7'b1000000};if(scanoutLED == 2'b01) segoutLED = {1'b1, 7'b0100100};
			end
		end
	end

endmodule
