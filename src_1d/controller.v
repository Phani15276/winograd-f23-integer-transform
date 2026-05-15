module control (
input clk,reset,start,
output reg [1:0]sel,
output reg ld_m1,ld_m2,ld_m3,ld_m4,ld_fine,done
);

parameter ideal=3'b000,
	     s1=3'b001,
	     s2=3'b010,
	     s3=3'b011,
	     s4=3'b100,
	     s5=3'b101,
	     ok=3'b111;

reg [2:0] state,nextstate;


always @(posedge clk) begin
	if(reset)
		state<=ideal;
	else
		state<=nextstate;
end


always @(*) begin
	case(state)
		ideal:
			if(start)
			nextstate=s1;
			else 
			nextstate=ideal;
		s1:
			nextstate=s2;	
		s2:
			nextstate=s3;	
		s3:
			nextstate=s4;
		s4:
			nextstate=s5;
		s5:
			nextstate=ok;
		ok:
			nextstate=ideal;

	default : nextstate=ideal;
	endcase
end

//output declaration

always @(*) begin
	ld_m1=0;
	ld_m2=0;
	ld_m3=0;
	ld_m4=0;
	ld_fine=0;
	done=0;
	sel=0;

	case(state)
	ideal: begin
		
	end
	s1:begin 
		ld_m1=1;sel=2'b00;
	end
	s2:begin 
		ld_m2=1;sel=2'b01;
	end
	s3:begin 
		ld_m3=1;sel=2'b10;
	end
	s4:begin 
		ld_m4=1;sel=2'b11;
	end
	s5:begin 
		ld_fine=1;
	end
	ok:begin
		done=1;
	end
	default:begin
		
	end
	endcase
end
endmodule












	  