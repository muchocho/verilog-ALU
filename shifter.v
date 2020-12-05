module shifter (
	output reg[15:0] listOut,
	input [15:0] listIn,
	input [2:0] nShift
);

always @(listIn or nShift)
begin
	case(nShift) 
	3'b000: begin // default
	listOut[15:0] <= listIn[15:0]; 
	end
	
	3'b001: begin // linear shift(left)
	listOut[15:1] <= listIn[14:0]; 
	listOut[0] <= 0;
	end
	
	3'b010: begin // linear shift(right)
	listOut[14:0] <= listIn[15:1]; 
	listOut[15] <= 0;
	end
	
	3'b011: begin // circular shift(left)
	listOut[15:1] <= listIn[14:0]; 
	listOut[0] <= listIn[15];
	end
	
	3'b100: begin // circular shift (right)
	listOut[14:0] <= listIn[15:1]; 
	listOut[15] <= listIn[0];
	end
	
	default: listOut[15:0] <= listIn[15:0];
	
	endcase
end
endmodule