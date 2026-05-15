module top #(parameter n=2)(
input clk,reset,start,
input signed [n-1:0] d0,d1,d2,d3,g0,g1,g2,
output signed [2*(n+3)-1:0] y0,y1,
output done
);

wire [1:0]sel;
wire ld_m1,ld_m2,ld_m3,ld_m4,ld_fine;

control u(.start(start),.reset(reset),.clk(clk),.sel(sel),.ld_m1(ld_m1),.ld_m2(ld_m2),.ld_m3(ld_m3),.ld_m4(ld_m4),.ld_fine(ld_fine),.done(done));

data #(n) d(.d0(d0),.d1(d1),.sel(sel),.d2(d2),.d3(d3),.clk(clk),.g0(g0),.g1(g1),.g2(g2),.y0(y0),.y1(y1),.ld_m1(ld_m1),.ld_m2(ld_m2),.ld_m3(ld_m3),.ld_m4(ld_m4),.ld_fine(ld_fine));

endmodule
