module GateControl(open_gate , position_1 , position_2 , position_3 , position_4 , position_5 , position_6 , infrared_input, clock_50MHz);
output reg open_gate;
input infrared_input, position_1 , position_2 , position_3 , position_4 , position_5 , position_6 , clock_50MHz;
reg open_clock, close_clock;
always @(infrared_input)
begin
	if(~infrared_input)
		begin
			if(position_1 | position_2 | position_3 | position_4 | position_5 | position_6)
				open_gate<=open_clock;
			else
				open_gate<=close_clock;
		end
	else
		open_gate<=close_clock;	
		
end

//not sure starting here
reg [20:0]counter_33Hz;


//generate the 33.33333333Hz clocks
initial
begin
counter_33Hz<=0;
open_clock<=0;
close_clock<=0;
end

always@(posedge clock_50MHz)
begin
if(counter_33Hz==1_500_000)
		counter_33Hz<=0;
else
	counter_33Hz<=counter_33Hz+1;
end

//generate the close_clock signal
always@(posedge clock_50MHz)
begin 
	if(counter_33Hz<26000)
		close_clock<=1;
	else
		close_clock<=0;
end

//generate the open_clock signal
always @(posedge clock_50MHz)
begin
	if(counter_33Hz<80000)
		open_clock<=1;
	else
		open_clock<=0;
end

endmodule