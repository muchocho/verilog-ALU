module ALU_16bit (
	input [15:0] aIn, bIn,
	input [2:0] shifter,
	input clockIn,
	output [15:0] aShifted, bShifted, opCode,
	output crOut,
	output reg [15:0] accOut, tempDiffOut, diffOut,
	output reg zeroFlag
);

wire [15:0] wSum, wDiff;
wire wBrwOut, wCrIn, wCrOut;
wire wOpCode;

//shifting function
shifter shiftA (.listOut(aShifted[15:0]), .listIn(aIn[15:0]), .nShift(shifter));
shifter shiftB (.listOut(bShifted[15:0]), .listIn(bIn[15:0]), .nShift(shifter));

//addition
adder_bit16 add (.aIn(aShifted[15:0]), .bIn(bShifted[15:0]), .crIn(wCrIn), .sumOut(wSum), .crOut(WcROut));
//carry 
assign wCrIn = (wOpCode == 3'b110)? wCrOut: 0;
assign crOut = (wOpCode == 3'b101)? wCrOut: (wOpCode == 3'b110)? wCrOut: 0;



//subtraction
subt_bit16 subt (.aIn(aShifted[15:0]), .bIn(bShifted[15:0]), .crIn(0), .diffOut(wDiff), .brw(wBrwOut));


//Magnitude Comparator
always @(posedge(clockIn))
	begin
if (aIn[15:0] < bIn[15:0]) begin
	diffOut[15:0] = tempDiffOut[15:0];
	tempDiffOut[15:0] = tempDiffOut[15:0];
	end
else if (aIn[15:0] > bIn[15:0])
	begin
	diffOut[15:0] = wDiff[15:0];
	tempDiffOut[15:0] = wDiff[15:0];
	end
end

//opcodes
always @(aShifted[15:0] or bShifted[15:0] or opCode[2:0] or clockIn)
begin
	case({opCode})
	3'b000:accOut[15:0] = aShifted[15:0] & bShifted[15:0];
	3'b001:accOut[15:0] = aShifted[15:0] | bShifted[15:0];
	3'b010:accOut[15:0] = aShifted[15:0] ^ bShifted[15:0];
	3'b011:accOut[15:0] = ~aShifted[15:0];
	3'b100:accOut[15:0] = ~bShifted[15:0];
	3'b101:accOut[15:0] = wSum[15:0];
	3'b110:accOut[15:0] = wSum[15:0];
	3'b111:accOut[15:0] = wDiff[15:0];
	endcase
end

endmodule

