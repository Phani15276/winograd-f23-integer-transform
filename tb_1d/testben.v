module testbe();
parameter n=2;

reg clk,reset,start;
reg signed [n-1:0] d0,d1,d2,d3,g0,g1,g2;
wire signed [2*(n+3)-1:0] y0,y1;
wire done;

top #(n) t(.clk(clk),
	.start(start),
	.reset(reset),
	.done(done),
	.d0(d0),
	.d1(d1),
	.d2(d2),
	.d3(d3),
	.g0(g0),
	.g1(g1),
	.g2(g2),
	.y0(y0),
	.y1(y1)
);


always #10 clk=~clk;

initial begin
	start=0;
	reset=1;
	clk=0;
	#100;
	reset=0;
	d0 = 1;
	d1 = 0;
	d2 = 0;
	d3 = 1;
	g0 = 1;
	g1 = 0;
	g2 = 1;

	#40;
	start=1;
	
	#200;
$finish;
end
endmodule




