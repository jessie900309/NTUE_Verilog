module musicGameWithoutMusic(clk,reset,left,center,right,segout,scanout);

input clk,reset;
input left,center,right;
output reg[7:0] segout;
output reg[2:0] scanout;

reg clk1;
reg [25:0] cnt_scan;
reg [25:0] cnt_num = 12500000; //時脈速度

//reg [63:0] q;
//reg [2:0] L1,L2,L3,C1,C2,R1,R2,R3;
//L1=L2=L3,C1=C2,R1=R2=R3;

reg [7:0] score = 8'b00000000; //0~31

//hw3的動畫作法
reg [7:0] q[0:7];
reg [2:0] Mode = 0; //000~110
reg [3:0] mode = 0; //0~15

//block
reg [7:0] Lblock = 8'b00011111;
reg [7:0] Cblock = 8'b11100111;
reg [7:0] Rblock = 8'b11111000;
reg [7:0] dark = 8'b11111111;


//------------------ clock running -----------------------
	always@(posedge clk) begin
		cnt_scan<=cnt_scan+1;
		if (cnt_scan == cnt_num) begin
			cnt_scan <=0;
			clk1 = ~clk1;
		end
	end

//------------------ main() ------------------------------

	always @(posedge clk1, negedge reset) begin
			if (reset == 0) begin
				// reset matrix
				q[0] = 8'b11111111; q[1] = 8'b11111111; q[2] = 8'b11111111; q[3] = 8'b11111111;
				q[4] = 8'b11111111; q[5] = 8'b11111111; q[6] = 8'b11111111; q[7] = 8'b11111111;
				// reset mode&clock
				Mode <= 3'b000;
				mode <= 0;
				cnt_num <= 12500000;
				score <= 8'b00000000;
			end
			else begin
			
				case(Mode)
				
					3'b000:
						if(mode==0)begin
							q[0] = score;
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
							q[0] = score;
							q[1] = dark;
							q[2] = dark;
							q[3] = dark;
							q[4] = dark;
							q[5] = dark;
							q[6] = dark;
							q[7] = dark;
							mode <=2;
						end
						else if(mode==2)begin
							q[0] = score;
							q[1] = dark;
							q[2] = Lblock;
							q[3] = dark;
							q[4] = dark;
							q[5] = dark;
							q[6] = dark;
							q[7] = dark;
							mode <=3;
						end
						else if(mode==3)begin
							q[0] = score;
							q[1] = dark;
							q[2] = Cblock;
							q[3] = Lblock;
							q[4] = dark;
							q[5] = dark;
							q[6] = dark;
							q[7] = dark;
							mode <=4;
						end
						else if(mode==4)begin
							q[0] = score;
							q[1] = dark;
							q[2] = Cblock;
							q[3] = Cblock;
							q[4] = Lblock;
							q[5] = dark;
							q[6] = dark;
							q[7] = dark;
							mode <=5;
						end
						else if(mode==5)begin
							q[0] = score;
							q[1] = dark;
							q[2] = Rblock;
							q[3] = Cblock;
							q[4] = Cblock;
							q[5] = Lblock;
							q[6] = dark;
							q[7] = dark;
							mode <=6;
						end
						else if(mode==6)begin
							q[0] = score;
							q[1] = dark;
							q[2] = Rblock;
							q[3] = Rblock;
							q[4] = Cblock;
							q[5] = Cblock;
							q[6] = Lblock;
							q[7] = dark;
							mode <=7;
						end
						else if(mode==7)begin
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
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
					//000 end
					
					3'b001:
						if(mode==0)begin
							q[0] = score;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
							q[2] = Rblock;
							q[3] = Cblock;
							q[4] = Cblock;
							q[5] = Lblock;
							q[6] = dark;
							q[7] = dark;
							mode <=6;
						end
						else if(mode==6)begin
							q[0] = score;
							q[1] = dark;
							q[2] = Rblock;
							q[3] = Rblock;
							q[4] = Cblock;
							q[5] = Cblock;
							q[6] = Lblock;
							q[7] = dark;
							mode <=7;
						end
						else if(mode==7)begin
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
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
					//001 end
					
					3'b010:
						if(mode==0)begin 
							q[0] = score;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
							q[2] = Rblock;
							q[3] = Lblock;
							q[4] = Cblock;
							q[5] = Rblock;
							q[6] = dark;
							q[7] = dark;
							mode <=6;
						end
						else if(mode==6)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = Rblock;
							q[3] = Rblock;
							q[4] = Lblock;
							q[5] = Cblock;
							q[6] = Rblock;
							q[7] = dark;
							mode <=7;
						end
						else if(mode==7)begin 
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
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
					//010 end
					
					3'b011:
						if(mode==0)begin 
							q[0] = score;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
							q[2] = Cblock;
							q[3] = Rblock;
							q[4] = Rblock;
							q[5] = Cblock;
							q[6] = dark;
							q[7] = dark;
							mode <=6;
						end
						else if(mode==6)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = Rblock;
							q[3] = Cblock;
							q[4] = Rblock;
							q[5] = Rblock;
							q[6] = Cblock;
							q[7] = dark;
							mode <=7;
						end
						else if(mode==7)begin 
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
							q[1] = dark;
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
							q[0] = score;
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
							Mode <=3'b100;
							mode <=0;
						end
					//011 end
					
					3'b100:
						if(mode==0)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = dark;
							q[3] = Lblock;
							q[4] = Rblock;
							q[5] = Rblock;
							q[6] = Cblock;
							q[7] = Rblock;
							if(right==0)begin
								score <= score+1;
							end
							mode <=1;
						end
						else if(mode==1)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = dark;
							q[3] = dark;
							q[4] = Lblock;
							q[5] = Rblock;
							q[6] = Rblock;
							q[7] = Cblock;
							if(center==0)begin
								score <= score+1;
							end
							mode <=2;
						end
						else if(mode==2)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = Lblock;
							q[3] = dark;
							q[4] = dark;
							q[5] = Lblock;
							q[6] = Rblock;
							q[7] = Rblock;
							if(right==0)begin
								score <= score+1;
							end
							mode <=3;
						end
						else if(mode==3)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = Lblock;
							q[3] = Lblock;
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
							q[0] = score;
							q[1] = dark;
							q[2] = Lblock;
							q[3] = Lblock;
							q[4] = Lblock;
							q[5] = dark;
							q[6] = dark;
							q[7] = Lblock;
							if(left==0)begin
								score <= score+1;
							end
							mode <=5;
						end
						else if(mode==5)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = Lblock;
							q[3] = Lblock;
							q[4] = Lblock;
							q[5] = Lblock;
							q[6] = dark;
							q[7] = dark;
							mode <=6;
						end
						else if(mode==6)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = Rblock;
							q[3] = Lblock;
							q[4] = Lblock;
							q[5] = Lblock;
							q[6] = Lblock;
							q[7] = dark;
							mode <=7;
						end
						else if(mode==7)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = Cblock;
							q[3] = Rblock;
							q[4] = Lblock;
							q[5] = Lblock;
							q[6] = Lblock;
							q[7] = Lblock;
							if(left==0)begin
								score <= score+1;
							end
							mode <=8;
						end
						else if(mode==8)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = Cblock;
							q[3] = Cblock;
							q[4] = Rblock;
							q[5] = Lblock;
							q[6] = Lblock;
							q[7] = Lblock;
							if(left==0)begin
								score <= score+1;
							end
							mode <=9;
						end
						else if(mode==9)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = Lblock;
							q[3] = Cblock;
							q[4] = Cblock;
							q[5] = Rblock;
							q[6] = Lblock;
							q[7] = Lblock;
							if(left==0)begin
								score <= score+1;
							end
							mode <=10;
						end
						else if(mode==10)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = Lblock;
							q[3] = Lblock;
							q[4] = Cblock;
							q[5] = Cblock;
							q[6] = Rblock;
							q[7] = Lblock;
							if(left==0)begin
								score <= score+1;
							end
							mode <=11;
						end
						else if(mode==11)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = Rblock;
							q[3] = Lblock;
							q[4] = Lblock;
							q[5] = Cblock;
							q[6] = Cblock;
							q[7] = Rblock;
							if(right==0)begin
								score <= score+1;
							end
							Mode <=3'b111;
							mode <=0;
						end
					//100 end
					
					3'b111:
						if(mode==0)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = dark;
							q[3] = Rblock;
							q[4] = Lblock;
							q[5] = Lblock;
							q[6] = Cblock;
							q[7] = Cblock;
							if(left==0)begin
								score <= score+1;
							end
							mode <=1;
						end
						else if(mode==1)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = dark;
							q[3] = dark;
							q[4] = Rblock;
							q[5] = Lblock;
							q[6] = Lblock;
							q[7] = Cblock;
							if(left==0)begin
								score <= score+1;
							end
							mode <=2;
						end
						else if(mode==2)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = dark;
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
							q[0] = score;
							q[1] = dark;
							q[2] = dark;
							q[3] = dark;
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
							q[0] = score;
							q[1] = dark;
							q[2] = dark;
							q[3] = dark;
							q[4] = dark;
							q[5] = dark;
							q[6] = dark;
							q[7] = Rblock;
							if(center==0)begin
								score <= score+1;
							end
							mode <=5;
						end
						else if(mode==5)begin 
							q[0] = score;
							q[1] = dark;
							q[2] = dark;
							q[3] = dark;
							q[4] = dark;
							q[5] = dark;
							q[6] = dark;
							q[7] = dark;
							mode <=6;
						end
						//music END
						//END begin
						else if(mode==6)begin 
							q[0] = dark;
							q[1] = dark;
							q[2] = dark;
							q[3] = dark;
							q[4] = dark;
							q[5] = dark;
							q[6] = dark;
							q[7] = dark;
							mode <=7;
						end
						else if(mode==7)begin 
							q[0] = dark;
							q[1] = dark;
							q[2] = dark;
							q[3] = dark;
							q[4] = dark;
							q[5] = dark;
							q[6] = dark;
							q[7] = dark;
							Mode <=3'b000;
							mode <=0;
							cnt_num <= 12500000;
							score <= 0;
						end
						//END end
						
				endcase
			end
		end

//----------- scan and display -------------

	always@(cnt_scan[15:13]) begin
			scanout <= cnt_scan[15:13];
		end
		
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

//TODO:

//1. 計分
//2. 音樂(固定樂譜)
//3. 調速度(marquee隨速度跑)
//4. 難易度: S 隨機模式(超快) A 固定樂譜(超快) B 預設模式(快) C預設模式(慢)
//5. 

endmodule
