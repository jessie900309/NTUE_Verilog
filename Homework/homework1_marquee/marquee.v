module marquee(reset,clk,Q);

input reset, clk; //clk 50MHz
output [11:0] Q;
reg [26:0] cntForClk1;
reg [26:0] numForClk1 = 1200000;
reg clk1 = 1'b0;
reg [2:0] modeCtrl = 3'b000;
reg [11:0] marquee    = 12'b111111111111;
//Mode 000
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
reg [11:0] State_init_ = 12'b111111111111;
reg [11:0] State_01_   = 12'b011111111111;
reg [11:0] State_02_   = 12'b001111111111;
reg [11:0] State_03_   = 12'b000111111111;
reg [11:0] State_04_   = 12'b000011111111;
reg [11:0] State_05_   = 12'b000001111111;
reg [11:0] State_06_   = 12'b000000111111;
reg [11:0] State_07_   = 12'b000000011111;
reg [11:0] State_08_   = 12'b000000001111;
reg [11:0] State_09_   = 12'b000000000111;
reg [11:0] State_10_   = 12'b000000000011;
reg [11:0] State_11_   = 12'b000000000001;
reg [11:0] State_12_   = 12'b000000000000;
//Mode 002
reg OuO = 1'b0;
reg OuOcount = 3'b000;

//clk1 1200000 -> 1250000
	always @(posedge clk) begin
		cntForClk1 <= cntForClk1 + 1;
		if(cntForClk1 == numForClk1) begin
			cntForClk1 <= 0;
			clk1 <= ~clk1;
		end
	end

//Mode 000 use clk1
	always @(posedge clk1, negedge reset) begin
		if(reset == 0) begin
			numForClk1 <= 1200000;
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
					numForClk1 = 1900000; //CLK!!!
					modeCtrl <= 3'b001; //go to next Mode
				end
				else begin //left shift
					marquee[11:1] <= marquee[10:0];
					marquee[0] <= marquee[11];
				end
			end //Mode 000
			
			//Mode 001
			else if(modeCtrl == 3'b001) begin
				if(marquee == State_12)              marquee <= State_init_;
				else if(marquee == State_init_)      marquee <= State_01_; //12'b011111111111;
				else if(marquee == 12'b111111111110) marquee <= State_02_; //12'b001111111111;
				else if(marquee == 12'b011111111110) marquee <= State_03_;
				else if(marquee == 12'b001111111110) marquee <= State_04_;
				else if(marquee == 12'b000111111110) marquee <= State_05_;
				else if(marquee == 12'b000011111110) marquee <= State_06_;
				else if(marquee == 12'b000001111110) marquee <= State_07_;
				else if(marquee == 12'b000000111110) marquee <= State_08_;
				else if(marquee == 12'b000000011110) marquee <= State_09_;
				else if(marquee == 12'b000000001110) marquee <= State_10_;
				else if(marquee == 12'b000000000110) marquee <= State_11_;
				else if(marquee == 12'b000000000010) begin
					marquee <= State_12_;
					numForClk1 = 12500000; //CLK!!!!!
					modeCtrl <= 3'b010; //go to next Mode
				end
				else begin //right shift
					marquee[10:0] <= marquee[11:1];
					marquee[11] <= marquee[0];
				end
			end //Mode 001
			
			//Mode 002
			else if(modeCtrl == 3'b010) begin
				if(marquee == State_12_) begin
					marquee <= 12'b111111111111;//init
				end
				else if(marquee == 12'b111111111111) begin
					marquee <= 12'b101010101010;
				end
				else if(marquee == 12'b101010101010) begin
					marquee <= 12'b010101010101;
				end
				else if(marquee == 12'b010101010101) begin
					marquee <= 12'b010110000011; //smile:)
				end
				else begin
					marquee <= 12'b111111111111;//init
				end
				
				
			end //Mode 002
			
		end //else
	end //always @(posedge clk1, negedge reset)

//show LED
	assign Q = marquee[11:0];

endmodule
