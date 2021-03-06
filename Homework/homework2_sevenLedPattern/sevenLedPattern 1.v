module sevenLedPattern(clk, reset, segout, scanout);

input clk, reset;
output reg [7:0] segout;//abcdefg no h
output reg [2:0] scanout;//num
//clk to clk1
reg clk1;
reg [25:0] cnt_scan;
reg [25:0] clkCNT = 1250000;
//7-SEG
reg [6:0] q[0:7];
reg [2:0] num = 3'b000;
reg modeS_done =0;


//---------------------------------------clock running---------------------------------------------
	always @(posedge clk, negedge reset)
	begin
		if(reset == 0) begin
			cnt_scan <= 0;
		end
		else begin
			cnt_scan <= cnt_scan + 1;
			if(cnt_scan == clkCNT) begin
				cnt_scan <= 0;
				clk1 = ~clk1;
			end
		end
	end

//-----------------------------------modify display digit-----------------------------------------
	always @(posedge clk1, negedge reset) begin
		if(reset == 0) begin
			q[0] = 7'b1111111; q[1] = 7'b1111111;
			q[2] = 7'b1111111; q[3] = 7'b1111111;
			q[4] = 7'b1111111; q[5] = 7'b1111111;
			q[6] = 7'b1111111; q[7] = 7'b1111111;
			num <= 3'b000;
			clkCNT <= 1250000;
			modeS_done <= 0;
		end
		else if(modeS_done==0) begin
			case(num)
				3'b000:
					     if(q[0]==7'b1111111) q[0] <= 7'b1111001;
					else if(q[0]==7'b1111001) q[0] <= 7'b1111100;
					else if(q[0]==7'b1111100) begin 
						q[0] <= 7'b1111110;
						q[1] <= 7'b1111101;
						num <= 3'b001;
					end
				3'b001: 
					if(q[1]==7'b1111101) begin
						q[1] <= 7'b1111001;
						q[0] <= 7'b1111111;
					end
					else if(q[1]==7'b1111001) q[1] <= 7'b1110011;
					else if(q[1]==7'b1110011) begin
						q[1] <= 7'b1110111;
						q[2] <= 7'b1111011;
						num <= 3'b010;
					end
				3'b010:
					if(q[2]==7'b1111011) begin
						q[2] <= 7'b1111001;
						q[1] <= 7'b1111111;
					end
					else if(q[2]==7'b1111001) q[2]<= 7'b1111100;
					else if(q[2]==7'b1111100) begin 
						q[2] <= 7'b1111110;
						q[3] <= 7'b1111101;
						num <= 3'b011;
					end
				3'b011:
					if(q[3]==7'b1111101) begin
						q[3] <= 7'b1111001;
						q[2] <= 7'b1111111;
					end
					else if(q[3]==7'b1111001) q[3] <= 7'b1110011;
					else if(q[3]==7'b1110011) begin
						q[3] <= 7'b1110111;
						q[4] <= 7'b1111011;
						num <= 3'b100;
					end
				3'b100:
					if(q[4]==7'b1111011) begin
						q[4] <= 7'b1111001;
						q[3] <= 7'b1111111;
					end
					else if(q[4]==7'b1111001) q[4] <= 7'b1111100;
					else if(q[4]==7'b1111100) begin 
						q[4] <= 7'b1111110;
						q[5] <= 7'b1111101;
						num <= 3'b101;
					end
				3'b101:
					if(q[5]==7'b1111101) begin
						q[5] <= 7'b1111001;
						q[4] <= 7'b1111111;
					end
					else if(q[5]==7'b1111001) q[5] <= 7'b1110011;
					else if(q[5]==7'b1110011) begin
						q[5] <= 7'b1110111;
						q[6] <= 7'b1111011;
						num <= 3'b110;
					end
				3'b110:
					if(q[6]==7'b1111011) begin
						q[6] <= 7'b1111001;
						q[5] <= 7'b1111111;
					end
					else if(q[6]==7'b1111001) q[6] <= 7'b1111100;
					else if(q[6]==7'b1111100) begin 
						q[6] <= 7'b1111110;
						q[7] <= 7'b1111101;
						num <= 3'b111;
					end
				3'b111:
					if(q[7]==7'b1111101) begin
						q[7] <= 7'b1111001;
						q[6] <= 7'b1111111;
					end
					else if(q[7]==7'b1111001) q[7] <= 7'b1110011;
					else if(q[7]==7'b1110011) q[7] <= 7'b1100111;
					else if(q[7]==7'b1100111) begin
						q[7] <= 7'b0111111;
						modeS_done <=1;// go to shu
					end
				default: q[0] <= 7'b1111111;
			endcase
		end //else if(modeS_done==0)
		else if(modeS_done==1) begin 
			clkCNT <= 1000000;
			if(q[7]==7'b0111111) q[6]<=7'b0111111;
			if(q[6]==7'b0111111) q[5]<=7'b0111111;
			if(q[5]==7'b0111111) q[4]<=7'b0111111;
			if(q[4]==7'b0111111) q[3]<=7'b0111111;
			if(q[3]==7'b0111111) q[2]<=7'b0111111;
			if(q[2]==7'b0111111) q[1]<=7'b0111111;
			if(q[1]==7'b0111111) q[0]<=7'b0111111;
			if(q[0]==7'b0111111) begin
				q[0]<=7'b0000000; q[1]<=7'b0000000;
				q[2]<=7'b0000000; q[3]<=7'b0000000;
				q[4]<=7'b0000000; q[5]<=7'b0000000;
				q[6]<=7'b0000000; q[7]<=7'b0000000;
			end
		end //else if(modeS_done==1)
	end

//----------------------------------scan and display 7-SEG---------------------------------------------
	always @(posedge cnt_scan[15])
		scanout <= scanout + 1;
	
	always @(scanout) begin
		case(scanout)
			3'b000: segout = {1'b1, q[0]};
			3'b001: segout = {1'b1, q[1]};
			3'b010: segout = {1'b1, q[2]};
			3'b011: segout = {1'b1, q[3]};
			3'b100: segout = {1'b1, q[4]};
			3'b101: segout = {1'b1, q[5]};
			3'b110: segout = {1'b1, q[6]};
			3'b111: segout = {1'b1, q[7]};
			default: segout = 8'b11111111;
		endcase
	end
	
endmodule
