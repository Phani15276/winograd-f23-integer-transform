`timescale 1ns/1ps

module filtransform_2d #(parameter n=6)(
    input signed [n-1:0] 
        g00,g01,g02,
        g10,g11,g12,
        g20,g21,g22,

    output signed [n+3:0]
        u00,u01,u02,u03,
        u10,u11,u12,u13,
        u20,u21,u22,u23,
        u30,u31,u32,u33
);

wire signed [n+2:0]
    t00,t01,t02,t03,
    t10,t11,t12,t13,
    t20,t21,t22,t23;

// row transform using scaled G'ᵀ
assign t00 = g00 <<< 1;
assign t01 = g00 + g01 + g02;
assign t02 = g00 - g01 + g02;
assign t03 = g02 <<< 1;

assign t10 = g10 <<< 1;
assign t11 = g10 + g11 + g12;
assign t12 = g10 - g11 + g12;
assign t13 = g12 <<< 1;

assign t20 = g20 <<< 1;
assign t21 = g20 + g21 + g22;
assign t22 = g20 - g21 + g22;
assign t23 = g22 <<< 1;

// column transform using scaled G'
assign u00 = t00 <<< 1;
assign u01 = t01 <<< 1;
assign u02 = t02 <<< 1;
assign u03 = t03 <<< 1;

assign u10 = t00 + t10 + t20;
assign u11 = t01 + t11 + t21;
assign u12 = t02 + t12 + t22;
assign u13 = t03 + t13 + t23;

assign u20 = t00 - t10 + t20;
assign u21 = t01 - t11 + t21;
assign u22 = t02 - t12 + t22;
assign u23 = t03 - t13 + t23;

assign u30 = t20 <<< 1;
assign u31 = t21 <<< 1;
assign u32 = t22 <<< 1;
assign u33 = t23 <<< 1;

endmodule
