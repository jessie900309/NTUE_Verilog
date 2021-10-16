module marquee(reset,clk,Q);

input reset, clk; //clk 50MHz
output [11:0] Q;
reg [26:0] cntForClk1;
//reg [26:0] cntForClk2;
//reg [26:0] cntForClk3;
reg clk1 = 1'b0;
//reg clk2 = 1'b0;
//reg clk3 = 1'b0;
reg [2:0] modeCtrl = 3'b000;
//Mode 000
reg [11:0] marquee    = 12'b111111111111;
reg [11:0] State_init = 12'b111111111111;
reg [11:0] State_01   = 12'b111111111110;
reg [11:0] State_02   = 12'b111111111100;
reg [11:0] State_03   = 12'b111111111000;
reg [11:0] State_04   = 12'b111111110000;
reg [11:0] State_05   = 12'b111111100000;
reg [11:0] State_06   = 12'b111111000000;
reg [11:0] State_07   = 12'b111110000000;
reg [11:0] State_08   = 12'b111100000000;
reg [11:0] State_09   = 12'b111000000000;
reg [11:0] State_10   = 12'b110000000000;
reg [11:0] State_11   = 12'b100000000000;
reg [11:0] State_12   = 12'b000000000000;
//Mode 001
reg OuO = 1'b0;
reg OuOcount = 3'b000;
//Mode 002

//clk1 12500000
	always @(posedge clk) begin
		cntForClk1 <= cntForClk1 + 1;
		if(cntForClk1 == 12500000)
		begin
			cntForClk1 <= 0;
			clk1 <= ~clk1;
		end
	end

//Mode 000 use clk1
	always @(posedge clk1, negedge reset) begin
		if(reset == 0) begin
			marquee <= State_init;
			modeCtrl <= 3'b000;
		end
		else begin
		
			//Mode 000
			if(modeCtrl == 3'b000) begin 
				if(marquee == State_init)            marquee <= State_01;
				else if(marquee == 12'b011111111111) marquee <= State_02;
				else if(marquee == 12'b011111111110) marquee <= State_03;
				else if(marquee == 12'b011111111100) marquee <= State_04;
				else if(marquee == 12'b011111111000) marquee <= State_05;
				else if(marquee == 12'b011111110000) marquee <= State_06;
				else if(marquee == 12'b011111100000) marquee <= State_07;
				else if(marquee == 12'b011111000000) marquee <= State_08;
				else if(marquee == 12'b011110000000) marquee <= State_09;
				else if(marquee == 12'b011100000000) marquee <= State_10;
				else if(marquee == 12'b011000000000) marquee <= State_11;
				else if(marquee == 12'b010000000000) begin
					marquee <= State_12;
					//modeCtrl <= 3'b001; //go to next Mode //QAQ defeat
				end
				else begin //Mode 000 left shift
					marquee[11:1] <= marquee[10:0];
					marquee[0] <= marquee[11];
				end
			end //Mode 000
			
			//Mode 001
			else if(modeCtrl == 3'b001) begin
				if(marquee == State_12) begin
					marquee <= 12'b111111111111;
					OuO <= 1'b0; //init
				end
				else if(marquee == 12'b111111111111 && OuO == 1'b0) begin
					marquee <= 12'b101010101010;
					OuO <= 1'b1;
				end
				else if(marquee == 12'b101010101010) begin
					marquee <= 12'b111111111111; 
					OuOcount <= OuOcount+1; //OuOcount++ until 7
				end
				else if(marquee == 12'b111111111111 && OuO == 1'b1) begin
					marquee <= 12'b010101010101; 
					OuO <= 1'b0;
				end
				else if(marquee == 12'b010101010101) begin
					marquee <= 12'b111111111111;
					OuOcount <= OuOcount+1; //OuOcount++ until 7
				end
				else marquee <= 12'b111111111111; OuO <= 1'b0; //init
			end //Mode 001
			
			//Mode 002
			//else if(modeCtrl == 3'b010) begin
				
				// pu ji pu ji OuO!!!
				
			//end //Mode 002
			
		end //else
	end //always @(posedge clk1, negedge reset)

//show LED
	assign Q = marquee[11:0];

endmodule
