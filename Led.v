module Led(output reg [5:0] out, input [5:0] in);

always @(in)
begin
	if(in[0]) out[0]=1;
	else out[0]=0;
	if(in[1]) out[1]=1;
	else out[1]=0;
	if(in[2]) out[2]=1;
	else out[2]=0;
	if(in[3]) out[3]=1;
	else out[3]=0;
	if(in[4]) out[4]=1;
	else out[4]=0;
	if(in[5]) out[5]=1;
	else out[5]=0;
end
endmodule
