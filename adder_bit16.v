module adder_bit16 (
	input [15:0] aIn, bIn,
	input crIn,
	output [15:0] sumOut,
	output crOut
);
wire w;

bit8adder bit8add0 (aIn[7:0], bIn[7:0], crIn, sumOut[7:0], w);
bit8adder bit8add1 (aIn[15:8], bIn[15:8], w, sumOut[15:8], crOut);
endmodule

module bit8adder (
	input [7:0] aIn, bIn,
	input crIn,
	output [7:0] sumOut,
	output crOut
);
wire w;
bit4adder bit4add0 (aIn[3:0], bIn[3:0], crIn, sumOut[3:0], w);
bit4adder bit4add1 (aIn[7:4], bIn[7:4], w, sumOut[7:4], cout);
endmodule


module bit4adder (
	input [3:0] aIn, bIn,
	input crIn,
	output [3:0] sumOut,
	output crOut
);

wire [2:0] w;

fullAdder AD0 (aIn[0], bIn[0], crIn, sumOut[0], w[0]);
fullAdder AD1 (aIn[1], bIn[1], w[0], sumOut[1], w[1]);
fullAdder AD2 (aIn[2], bIn[2], w[1], sumOut[2], w[2]);
fullAdder AD3 (aIn[3], bIn[3], w[2], sumOut[3], crout);
endmodule


module fullAdder (
	input aIn, bIn,
	input crIn,
	output sumOut, crOut
);

wire [2:0] w;

assign crOut = (aIn&&bIn) || (aIn&&crIn) || (bIn&&crIn);
assign sumOut = aIn ^ bIn ^ crIn;
endmodule

	



//module halfadder (
	//input aIn,
	//input bIn,
	//output sumOut,
	//output crOut
//);

//xor (sumOut, aIn, bIn);
//and (crOut, aIn, bIn);

//endmodule

