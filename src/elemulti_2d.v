`timescale 1ns/1ps

module ele_multi_2d #(parameter n=6)(
    input signed [n+3:0]
        u00,u01,u02,u03,
        u10,u11,u12,u13,
        u20,u21,u22,u23,
        u30,u31,u32,u33,

    input signed [n+1:0]
        v00,v01,v02,v03,
        v10,v11,v12,v13,
        v20,v21,v22,v23,
        v30,v31,v32,v33,

    output signed [(2*n)+7:0]
        m00,m01,m02,m03,
        m10,m11,m12,m13,
        m20,m21,m22,m23,
        m30,m31,m32,m33
);

assign m00 = u00*v00;
assign m01 = u01*v01;
assign m02 = u02*v02;
assign m03 = u03*v03;

assign m10 = u10*v10;
assign m11 = u11*v11;
assign m12 = u12*v12;
assign m13 = u13*v13;

assign m20 = u20*v20;
assign m21 = u21*v21;
assign m22 = u22*v22;
assign m23 = u23*v23;

assign m30 = u30*v30;
assign m31 = u31*v31;
assign m32 = u32*v32;
assign m33 = u33*v33;

endmodule
