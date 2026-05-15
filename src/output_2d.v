`timescale 1ns/1ps

module output_2d #(parameter n=6)(
    input signed [(2*n)+7:0]
        m00,m01,m02,m03,
        m10,m11,m12,m13,
        m20,m21,m22,m23,
        m30,m31,m32,m33,

    output signed [(2*n)+7:0]
        y00,y01,
        y10,y11
);

wire signed [(2*n)+9:0]
    t00,t01,t02,t03,
    t10,t11,t12,t13;

wire signed [(2*n)+10:0]
    y00_s,y01_s,
    y10_s,y11_s;

// A^T * M
assign t00 = m00 + m10 + m20;
assign t01 = m01 + m11 + m21;
assign t02 = m02 + m12 + m22;
assign t03 = m03 + m13 + m23;

assign t10 = m10 - m20 - m30;
assign t11 = m11 - m21 - m31;
assign t12 = m12 - m22 - m32;
assign t13 = m13 - m23 - m33;

// (A^T * M) * A  -> this is scaled by 4
assign y00_s = t00 + t01 + t02;
assign y01_s = t01 - t02 - t03;
assign y10_s = t10 + t11 + t12;
assign y11_s = t11 - t12 - t13;

// divide by 4 using arithmetic shift
assign y00 = y00_s >>> 2;
assign y01 = y01_s >>> 2;
assign y10 = y10_s >>> 2;
assign y11 = y11_s >>> 2;

endmodule
