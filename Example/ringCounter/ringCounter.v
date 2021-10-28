module ringCounter(
reset,
clk,
scan_out
);

input reset,clk;
output [7:0] scan_out;

reg [7:0] ring_counter;
reg [25:0] cnt;
reg clk1;

	always @(posedge clk)
	begin 
		cnt <= cnt + 1;
		if(cnt == 12500000)
		begin
			cnt <= 0;
			clk1 <= ~clk1;
		end
	end

	always @(posedge clk1, negedge reset)
	if(reset == 0)
		ring_counter <= 8'b11111110; //0:on, 1:off
	else if(clk1 == 1)
		begin
			ring_counter[0] <= ring_counter[7];
			ring_counter[7:1] <= ring_counter[6:0];
		end

//------------------------------------Output scan signal--------------------------------------------

	assign scan_out = ring_counter;

endmodule
