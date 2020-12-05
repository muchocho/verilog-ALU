module subt_bit16 (
	input [15:0] aIn, bIn,
	input crIn,
	output [15:0] diffOut,
	output brw
);
wire w;
subt8bit ubt8bit0(aIn[7:0], bIn[7:0], crIn, diffOut[7:0], w);
subt8bit ubt8bit1(aIn[15:8], bIn[15:8], w, diffOut[15:8], brw);
endmodule


module subt8bit (
	input [7:0] aIn, bIn,
	input crIn,
	output [7:0] diffOut,
	output brw
);

wire w;
subt4bit sub4bit0(aIn[3:0], bIn[3:0], crIn, diffOut[3:0], w);
subt4bit sub4bit1(aIn[7:4], bIn[7:4], w, diffOut[7:4], brw);
endmodule



module subt4bit (
	input [3:0] aIn, bIn,
	input crIn,
	output [3:0] diffOut,
	output brw
);
wire [2:0] w;

fullsubt S0 (aIn[0], bIn[0], crIn, diffOut[0], w[0]);
fullsubt S1 (aIn[1], bIn[1], w[0], diffOut[1], w[1]);
fullsubt S2 (aIn[0], bIn[0], w[1], diffOut[2], w[2]);
fullsubt S3 (aIn[0], bIn[0], w[2], diffOut[3], brw);

endmodule






module fullsubt (
	input aIn, bIn,
	input crIn,
	output diffOut,
	output brw
); 

assign diffOut = aIn ^ bIn ^ crIn;
assign brw = ((~aIn)&bIn | ((~aIn)&crIn) | (bIn&crIn));
endmodule

 