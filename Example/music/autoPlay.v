module autoPlay(reset, clk, autoPlayIndex);
input reset, clk; //50MHz
output reg [4:0] autoPlayIndex;

reg jiepai,clk1;
reg [4:0] j = 0;
reg [16:0] clkCount=0;
reg [7:0] count;

always @(posedge clk)begin
	if (clkCount == 48828)begin // 50MHz / 48828 = 1024
		clkCount = 0;
		clk1 = !clk1; //1024 / 2 = 512
		end
		else
			clkCount = clkCount + 1;
end

always @(posedge clk1)begin
	if (j == 15)begin // 512/ 16 = 32
	j <= 0;
	jiepai <= !jiepai; // 32/2 = 16
	end 
	else
		j <= j+1;
end

always @(posedge jiepai, negedge reset)begin
	if (!reset)
		count <= 0;
	else
	if (jiepai)
		if (count==127 )
			count<=0;
		else
			count<=count+1;
end

always @(count)begin // Canon
	case (count)
		0 : autoPlayIndex<=5'b11101; //55
		1 : autoPlayIndex<=5'b11101; //55
		2 : autoPlayIndex<=5'b11101; //55
		3 : autoPlayIndex<=5'b11101; //55
		4 : autoPlayIndex<=5'b11101; //55
		5 : autoPlayIndex<=5'b11101; //55
		6 : autoPlayIndex<=5'b11101; //55
		7 : autoPlayIndex<=5'b00000; //0
		8 : autoPlayIndex<=5'b11011; //33
		9 : autoPlayIndex<=5'b11011; //33
		10 : autoPlayIndex<=5'b11011; //33
		11 : autoPlayIndex<=5'b00000; //0
		12 : autoPlayIndex<=5'b11100; //44
		13 : autoPlayIndex<=5'b11100; //44 
		14 : autoPlayIndex<=5'b11100; //44
		15 : autoPlayIndex<=5'b00000; //0
		16 : autoPlayIndex<=5'b11101; //55
		17 : autoPlayIndex<=5'b11101; //55
		18 : autoPlayIndex<=5'b11101; //55
		19 : autoPlayIndex<=5'b11101; //55
		20 : autoPlayIndex<=5'b11101; //55
		21 : autoPlayIndex<=5'b11101; //55
		22 : autoPlayIndex<=5'b11101; //55
		23 : autoPlayIndex<=5'b00000; //0
		24 : autoPlayIndex<=5'b11011; //33
		25 : autoPlayIndex<=5'b11011; //33
		26 : autoPlayIndex<=5'b11011; //33
		27 : autoPlayIndex<=5'b00000; //0
		28 : autoPlayIndex<=5'b11100; //44
		29 : autoPlayIndex<=5'b11100; //44
		30 : autoPlayIndex<=5'b11100; //44
		31 : autoPlayIndex<=5'b00000; //0
		32 : autoPlayIndex<=5'b11101; //55
		33 : autoPlayIndex<=5'b11101; //55
		34 : autoPlayIndex<=5'b11101; //55
		35 : autoPlayIndex<=5'b00000; //0
		36 : autoPlayIndex<=5'b01101; //5
		37 : autoPlayIndex<=5'b01101; //5
		38 : autoPlayIndex<=5'b01101; //5
		39 : autoPlayIndex<=5'b00000; //0
		40 : autoPlayIndex<=5'b01110; //6
		41 : autoPlayIndex<=5'b01110; //6
		42 : autoPlayIndex<=5'b01110; //6
		43 : autoPlayIndex<=5'b00000; //0
		44 : autoPlayIndex<=5'b01111; //7
		45 : autoPlayIndex<=5'b01111; //7
		46 : autoPlayIndex<=5'b01111; //7
		47 : autoPlayIndex<=5'b00000; //0
		48 : autoPlayIndex<=5'b11001; //11
		49 : autoPlayIndex<=5'b11001; //11
		50 : autoPlayIndex<=5'b11001; //11
		51 : autoPlayIndex<=5'b00000; //0
		52 : autoPlayIndex<=5'b11010; //22
		53 : autoPlayIndex<=5'b11010; //22
		54 : autoPlayIndex<=5'b11010; //22
		55 : autoPlayIndex<=5'b00000; //0
		56 : autoPlayIndex<=5'b11011; //33
		57 : autoPlayIndex<=5'b11011; //33
		58 : autoPlayIndex<=5'b11011; //33
		59 : autoPlayIndex<=5'b00000; //0
		60 : autoPlayIndex<=5'b11100; //44
		61 : autoPlayIndex<=5'b11100; //44
		62 : autoPlayIndex<=5'b11100; //44
		63 : autoPlayIndex<=5'b00000; //0
		64 : autoPlayIndex<=5'b11011; //33
		65 : autoPlayIndex<=5'b11011; //33
		66 : autoPlayIndex<=5'b11011; //33
		67 : autoPlayIndex<=5'b11011; //33
		68 : autoPlayIndex<=5'b11011; //33
		69 : autoPlayIndex<=5'b11011; //33
		70 : autoPlayIndex<=5'b11011; //33
		71 : autoPlayIndex<=5'b00000; //0
		72 : autoPlayIndex<=5'b11001; //11 
		73 : autoPlayIndex<=5'b11001; //11
		74 : autoPlayIndex<=5'b11001; //11
		75 : autoPlayIndex<=5'b00000; //0
		76 : autoPlayIndex<=5'b11010; //22
		77 : autoPlayIndex<=5'b11010; //22
		78 : autoPlayIndex<=5'b11010; //22
		79 : autoPlayIndex<=5'b00000; //0
		80 : autoPlayIndex<=5'b11011; //33
		81 : autoPlayIndex<=5'b11011; //33
		82 : autoPlayIndex<=5'b11011; //33
		83 : autoPlayIndex<=5'b11011; //33
		84 : autoPlayIndex<=5'b11011; //33
		85 : autoPlayIndex<=5'b11011; //33
		86 : autoPlayIndex<=5'b11011; //33
		87 : autoPlayIndex<=5'b00000; //0
		88 : autoPlayIndex<=5'b01011; //3
		89 : autoPlayIndex<=5'b01011; //3
		90 : autoPlayIndex<=5'b01011; //3
		91 : autoPlayIndex<=5'b00000; //0
		92 : autoPlayIndex<=5'b01100; //4
		93 : autoPlayIndex<=5'b01100; //4
		94 : autoPlayIndex<=5'b01100; //4
		95 : autoPlayIndex<=5'b00000; //0
		96 : autoPlayIndex<=5'b01101; //5
		97 : autoPlayIndex<=5'b01101; //5
		98 : autoPlayIndex<=5'b01101; //5
		99 : autoPlayIndex<=5'b00000; //0
		100 : autoPlayIndex<=5'b01110; //6
		101 : autoPlayIndex<=5'b01110; //6
		102 : autoPlayIndex<=5'b01110; //6
		103 : autoPlayIndex<=5'b01100; //0
		104 : autoPlayIndex<=5'b01101; //5
		105 : autoPlayIndex<=5'b01101; //5
		106 : autoPlayIndex<=5'b01101; //5
		107 : autoPlayIndex<=5'b00000; //0
		108 : autoPlayIndex<=5'b01100; //4
		109 : autoPlayIndex<=5'b01100; //4
		110 : autoPlayIndex<=5'b01100; //4
		111 : autoPlayIndex<=5'b00000; //0
		112 : autoPlayIndex<=5'b01101; //5
		113 : autoPlayIndex<=5'b01101; //5
		114 : autoPlayIndex<=5'b01101; //5
		115 : autoPlayIndex<=5'b00000; //0
		116 : autoPlayIndex<=5'b01011; //3
		117 : autoPlayIndex<=5'b01011; //3
		118 : autoPlayIndex<=5'b01011; //3
		119 : autoPlayIndex<=5'b00000; //0
		120 : autoPlayIndex<=5'b01100; //4
		121 : autoPlayIndex<=5'b01100; //4
		123 : autoPlayIndex<=5'b01100; //4
		124 : autoPlayIndex<=5'b00000; //0
		125 : autoPlayIndex<=5'b01101; //5
		126 : autoPlayIndex<=5'b01101; //5
		127 : autoPlayIndex<=5'b01101; //5
		default : autoPlayIndex<=0;
	endcase
end

endmodule
