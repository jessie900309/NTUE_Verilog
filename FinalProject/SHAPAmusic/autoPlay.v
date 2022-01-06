module autoPlay(reset, clk, autoPlayIndex);
input reset, clk; //50MHz
output reg [4:0] autoPlayIndex;

reg jiepai, clk1;
reg [4:0] j = 0;
reg [16:0] clkCount = 0;
reg [7:0] count;

always @(posedge clk)begin
	if(clkCount == 48828)begin // 50MHz / 48828 = 1024
		clkCount = 0;
		clk1 = !clk1; //1024 / 2 = 512
	end
	else
		clkCount = clkCount + 1;
end

always @(posedge clk1)begin
	if(j == 15)begin // 512/ 16 = 32
		j <= 0;
		jiepai <= !jiepai; // 32/2 = 16
	end
	else
		j <= j+1;
end

always @(posedge jiepai, negedge reset)begin
	if(!reset) count <= 0;
	else begin
		if(jiepai)
			if(count == 127) count <= 0;
			else count <= count+1;
	end
end

always @(count)begin // Canon
	case(count)
	
		0   : autoPlayIndex<=5'b11001; //1
		1   : autoPlayIndex<=5'b11001; 
		2   : autoPlayIndex<=5'b11001; 
		3   : autoPlayIndex<=5'b00000; 
		4   : autoPlayIndex<=5'b11001; //1
		5   : autoPlayIndex<=5'b11001; 
		6   : autoPlayIndex<=5'b11001; 
		7   : autoPlayIndex<=5'b00000; 
		8   : autoPlayIndex<=5'b11101; //5
		9   : autoPlayIndex<=5'b11101; 
		10  : autoPlayIndex<=5'b11101; 
		11  : autoPlayIndex<=5'b00000; 
		12  : autoPlayIndex<=5'b11101; //5
		13  : autoPlayIndex<=5'b11101; 
		14  : autoPlayIndex<=5'b11101; 
		15  : autoPlayIndex<=5'b00000; 
		16  : autoPlayIndex<=5'b11110; //6
		17  : autoPlayIndex<=5'b11110; 
		18  : autoPlayIndex<=5'b11110; 
		19  : autoPlayIndex<=5'b00000; 
		20  : autoPlayIndex<=5'b11110; //6
		21  : autoPlayIndex<=5'b11110; 
		22  : autoPlayIndex<=5'b11110; 
		23  : autoPlayIndex<=5'b00000; 
		24  : autoPlayIndex<=5'b11101; //5
		25  : autoPlayIndex<=5'b11101; 
		26  : autoPlayIndex<=5'b11101; 
		27  : autoPlayIndex<=5'b11101; 
		28  : autoPlayIndex<=5'b11101; 
		29  : autoPlayIndex<=5'b11101; 
		30  : autoPlayIndex<=5'b11101; 
		31  : autoPlayIndex<=5'b00000; 

		32  : autoPlayIndex<=5'b11100; //4
		33  : autoPlayIndex<=5'b11100; 
		34  : autoPlayIndex<=5'b11100; 
		35  : autoPlayIndex<=5'b00000;
		36  : autoPlayIndex<=5'b11100; //4
		37  : autoPlayIndex<=5'b11100;
		38  : autoPlayIndex<=5'b11100;
		39  : autoPlayIndex<=5'b00000;
		40  : autoPlayIndex<=5'b11011; //3
		41  : autoPlayIndex<=5'b11011;
		42  : autoPlayIndex<=5'b11011;
		43  : autoPlayIndex<=5'b00000; 
		44  : autoPlayIndex<=5'b11011; //3
		45  : autoPlayIndex<=5'b11011;
		46  : autoPlayIndex<=5'b11011;
		47  : autoPlayIndex<=5'b00000; 
		48  : autoPlayIndex<=5'b11010; //2
		49  : autoPlayIndex<=5'b11010; 
		50  : autoPlayIndex<=5'b11010; 
		51  : autoPlayIndex<=5'b00000; 
		52  : autoPlayIndex<=5'b11010; //2
		53  : autoPlayIndex<=5'b11010; 
		54  : autoPlayIndex<=5'b11010; 
		55  : autoPlayIndex<=5'b00000; 
		56  : autoPlayIndex<=5'b11001; //1
		57  : autoPlayIndex<=5'b11001;
		58  : autoPlayIndex<=5'b11001;
		59  : autoPlayIndex<=5'b11001;
		60  : autoPlayIndex<=5'b11001;
		61  : autoPlayIndex<=5'b11001;
        62  : autoPlayIndex<=5'b11001;
		63  : autoPlayIndex<=5'b00000; 
		
		64  : autoPlayIndex<=5'b11101; //5
		65  : autoPlayIndex<=5'b11101; 
		66  : autoPlayIndex<=5'b11101; 
		67  : autoPlayIndex<=5'b00000; 
		68  : autoPlayIndex<=5'b11101; //5
		69  : autoPlayIndex<=5'b11101; 
		70  : autoPlayIndex<=5'b11101; 
		71  : autoPlayIndex<=5'b00000; 
		72  : autoPlayIndex<=5'b11100; //4
		73  : autoPlayIndex<=5'b11100; 
		74  : autoPlayIndex<=5'b11100; 
		75  : autoPlayIndex<=5'b00000; 
		76  : autoPlayIndex<=5'b11100; //4
		77  : autoPlayIndex<=5'b11100; 
		78  : autoPlayIndex<=5'b11100; 
		79  : autoPlayIndex<=5'b00000; 
		80  : autoPlayIndex<=5'b11011; //3
		81  : autoPlayIndex<=5'b11011; 
		82  : autoPlayIndex<=5'b11011; 
		83  : autoPlayIndex<=5'b00000; 
		84  : autoPlayIndex<=5'b11011; //3
		85  : autoPlayIndex<=5'b11011; 
		86  : autoPlayIndex<=5'b11011; 
		87  : autoPlayIndex<=5'b00000; 
		88  : autoPlayIndex<=5'b11010; //2
		89  : autoPlayIndex<=5'b11010; 
		90  : autoPlayIndex<=5'b11010;
		91  : autoPlayIndex<=5'b11010;
		92  : autoPlayIndex<=5'b11010;
		93  : autoPlayIndex<=5'b11010;
		94  : autoPlayIndex<=5'b11010;
		95  : autoPlayIndex<=5'b00000;
		
		96  : autoPlayIndex<=5'b11101; //5
		97  : autoPlayIndex<=5'b11101; 
		98  : autoPlayIndex<=5'b11101; 
		99  : autoPlayIndex<=5'b00000; 
		100 : autoPlayIndex<=5'b11101; //5
		101 : autoPlayIndex<=5'b11101; 
		102 : autoPlayIndex<=5'b11101; 
		103 : autoPlayIndex<=5'b00000; 
		104 : autoPlayIndex<=5'b11100; //4
		105 : autoPlayIndex<=5'b11100; 
		106 : autoPlayIndex<=5'b11100; 
		107 : autoPlayIndex<=5'b00000; 
		108 : autoPlayIndex<=5'b11100; //4
		109 : autoPlayIndex<=5'b11100; 
		110 : autoPlayIndex<=5'b11100; 
		111 : autoPlayIndex<=5'b00000; 
		112 : autoPlayIndex<=5'b11011; //3
		113 : autoPlayIndex<=5'b11011; 
		114 : autoPlayIndex<=5'b11011; 
		115 : autoPlayIndex<=5'b00000; 
		116 : autoPlayIndex<=5'b11011; //3
		117 : autoPlayIndex<=5'b11011; 
		118 : autoPlayIndex<=5'b11011; 
		119 : autoPlayIndex<=5'b00000; 
		120 : autoPlayIndex<=5'b11010; //2
		121 : autoPlayIndex<=5'b11010; 
		122 : autoPlayIndex<=5'b11010;
		123 : autoPlayIndex<=5'b11010;
		124 : autoPlayIndex<=5'b11010;
		125 : autoPlayIndex<=5'b11010;
		126 : autoPlayIndex<=5'b11010;
		127 : autoPlayIndex<=5'b00000;
		
		128 : autoPlayIndex<=5'b11001; //1
		129 : autoPlayIndex<=5'b11001; 
		130 : autoPlayIndex<=5'b11001; 
		131 : autoPlayIndex<=5'b00000; 
		132 : autoPlayIndex<=5'b11001; //1
		133 : autoPlayIndex<=5'b11001; 
		134 : autoPlayIndex<=5'b11001; 
		135 : autoPlayIndex<=5'b00000; 
		136 : autoPlayIndex<=5'b11101; //5
		137 : autoPlayIndex<=5'b11101; 
		138 : autoPlayIndex<=5'b11101; 
		139 : autoPlayIndex<=5'b00000; 
		140 : autoPlayIndex<=5'b11101; //5
		141 : autoPlayIndex<=5'b11101; 
		142 : autoPlayIndex<=5'b11101; 
		143 : autoPlayIndex<=5'b00000; 
		144 : autoPlayIndex<=5'b11110; //6
		145 : autoPlayIndex<=5'b11110; 
		146 : autoPlayIndex<=5'b11110; 
		147 : autoPlayIndex<=5'b00000; 
		148 : autoPlayIndex<=5'b11110; //6
		149 : autoPlayIndex<=5'b11110; 
		150 : autoPlayIndex<=5'b11110; 
		151 : autoPlayIndex<=5'b00000; 
		152 : autoPlayIndex<=5'b11101; //5
		153 : autoPlayIndex<=5'b11101; 
		154 : autoPlayIndex<=5'b11101; 
		155 : autoPlayIndex<=5'b11101; 
		156 : autoPlayIndex<=5'b11101; 
		157 : autoPlayIndex<=5'b11101; 
		158 : autoPlayIndex<=5'b11101; 
		159 : autoPlayIndex<=5'b00000; 

		160 : autoPlayIndex<=5'b11100; //4
		161 : autoPlayIndex<=5'b11100; 
		162 : autoPlayIndex<=5'b11100; 
		163 : autoPlayIndex<=5'b00000;
		164 : autoPlayIndex<=5'b11100; //4
		165 : autoPlayIndex<=5'b11100;
		166 : autoPlayIndex<=5'b11100;
		167 : autoPlayIndex<=5'b00000;
		168 : autoPlayIndex<=5'b11011; //3
		169 : autoPlayIndex<=5'b11011;
		170 : autoPlayIndex<=5'b11011;
		171 : autoPlayIndex<=5'b00000; 
		172 : autoPlayIndex<=5'b11011; //3
		173 : autoPlayIndex<=5'b11011;
		174 : autoPlayIndex<=5'b11011;
		175 : autoPlayIndex<=5'b00000; 
		176 : autoPlayIndex<=5'b11010; //2
		177 : autoPlayIndex<=5'b11010; 
		178 : autoPlayIndex<=5'b11010; 
		179 : autoPlayIndex<=5'b00000; 
		180 : autoPlayIndex<=5'b11010; //2
		181 : autoPlayIndex<=5'b11010; 
		182 : autoPlayIndex<=5'b11010; 
		183 : autoPlayIndex<=5'b00000; 
		184 : autoPlayIndex<=5'b11001; //1
		185 : autoPlayIndex<=5'b11001;
		186 : autoPlayIndex<=5'b11001;
		187 : autoPlayIndex<=5'b11001;
		188 : autoPlayIndex<=5'b11001;
		189 : autoPlayIndex<=5'b11001;
        190 : autoPlayIndex<=5'b11001;
		191 : autoPlayIndex<=5'b00000; 
		
		default : autoPlayIndex <= 0;
	endcase
end

endmodule
