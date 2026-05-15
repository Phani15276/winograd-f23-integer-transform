module data #(parameter n=2)(
input signed [n-1:0] d0,d1,d2,d3,g0,g1,g2,
input ld_m1,ld_m2,ld_m3,ld_m4,clk,ld_fine,
input [1:0]sel,
output reg signed [2*(n+3)-1:0] y0,y1
);

//ld_fine=output

wire signed [2*(n+2)-1:0] mul_out;
wire signed [n+1:0] t0,t1,t2,t3,t4,t5;//we taken n+2 because for t4,t5 we need n+2 so for all we have taken n+2 for simplification purpose
wire signed [n+1:0] mul_a,mul_b;
reg signed [2*(n+2)-1:0] m3,m1,m2,m4;

assign t0=d0-d2;
assign t1=d1+d2;
assign t2=d2-d1;
assign t3=d1-d3;
assign t4=g0+g1+g2;
assign t5=g0-g1+g2;


assign mul_a=(sel==0)?t0:
	     (sel==1)?t1:
	     (sel==2)?t2:
	      t3;
	     


assign mul_b=(sel==0)?g0:
	     (sel==1)?t4:
	     (sel==2)?t5:
	      g2;
	
assign mul_out=mul_a*mul_b;	

always @(posedge clk) begin
	if(ld_m1)
		m1<=mul_out;
	else if(ld_m2)
		m2<=mul_out;
	else if(ld_m3)
		m3<=mul_out;
	else if(ld_m4)
		m4<=mul_out;
		
end


always @(posedge clk) begin
	if(ld_fine) begin
		y0<=m1+m2+m3;
		y1<=m2-m3-m4;
	end
	else begin
		y0<=0;
		y1<=0;
	end
end

endmodule
