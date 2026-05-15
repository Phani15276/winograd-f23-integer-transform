

module tb_compare_2d;

parameter n = 6;

reg clk, reset, start;

reg signed [n-1:0]
    d00,d01,d02,d03,
    d10,d11,d12,d13,
    d20,d21,d22,d23,
    d30,d31,d32,d33;

reg signed [n-1:0]
    g00,g01,g02,
    g10,g11,g12,
    g20,g21,g22;

wire signed [(2*n)+7:0]
    y00_w,y01_w,y10_w,y11_w,
    y00_n,y01_n,y10_n,y11_n;

wire done_w, done_n;

always #5 clk = ~clk;

winograd_fsmd_2d #(n) DUT_WIN(
    .clk(clk), .reset(reset), .start(start),
    .d00(d00),.d01(d01),.d02(d02),.d03(d03),
    .d10(d10),.d11(d11),.d12(d12),.d13(d13),
    .d20(d20),.d21(d21),.d22(d22),.d23(d23),
    .d30(d30),.d31(d31),.d32(d32),.d33(d33),
    .g00(g00),.g01(g01),.g02(g02),
    .g10(g10),.g11(g11),.g12(g12),
    .g20(g20),.g21(g21),.g22(g22),
    .y00(y00_w),.y01(y01_w),.y10(y10_w),.y11(y11_w),
    .done(done_w)
);

normal_conv_fsmd_2d #(n) DUT_NORM(
    .clk(clk), .reset(reset), .start(start),
    .d00(d00),.d01(d01),.d02(d02),.d03(d03),
    .d10(d10),.d11(d11),.d12(d12),.d13(d13),
    .d20(d20),.d21(d21),.d22(d22),.d23(d23),
    .d30(d30),.d31(d31),.d32(d32),.d33(d33),
    .g00(g00),.g01(g01),.g02(g02),
    .g10(g10),.g11(g11),.g12(g12),
    .g20(g20),.g21(g21),.g22(g22),
    .y00(y00_n),.y01(y01_n),.y10(y10_n),.y11(y11_n),
    .done(done_n)
);

initial begin
    clk = 0;
    reset = 1;
    start = 0;

    d00=1;  d01=2;  d02=3;  d03=4;
    d10=5;  d11=6;  d12=7;  d13=8;
    d20=9;  d21=10; d22=11; d23=12;
    d30=13; d31=14; d32=15; d33=16;

    g00 = 2; g01 = -1; g02 = 3;
    g10 = 0; g11 = 1;  g12 = -2;
    g20 = 1; g21 = 4;  g22 = 0;

    #12 reset = 0;
    #8  start = 1;
    #10 start = 0;

    #500 $finish;
end

endmodule