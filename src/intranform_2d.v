module intransform_2d #(parameter n=5)(
input signed [n-1:0] 
    d00,d01,d02,d03,
    d10,d11,d12,d13,
    d20,d21,d22,d23,
    d30,d31,d32,d33,

output signed [n+1:0]
    v00,v01,v02,v03,
    v10,v11,v12,v13,
    v20,v21,v22,v23,
    v30,v31,v32,v33
);

wire signed [n:0]
    x00,x01,x02,x03,
    x10,x11,x12,x13,
    x20,x21,x22,x23,
    x30,x31,x32,x33;

// row transform: d * B
assign x00 = d00 - d02;
assign x01 = d01 + d02;
assign x02 = d02 - d01;
assign x03 = d01 - d03;

assign x10 = d10 - d12;
assign x11 = d11 + d12;
assign x12 = d12 - d11;
assign x13 = d11 - d13;

assign x20 = d20 - d22;
assign x21 = d21 + d22;
assign x22 = d22 - d21;
assign x23 = d21 - d23;

assign x30 = d30 - d32;
assign x31 = d31 + d32;
assign x32 = d32 - d31;
assign x33 = d31 - d33;

// column transform: B^T * (d * B)
assign v00 = x00 - x20;
assign v10 = x10 + x20;
assign v20 = x20 - x10;
assign v30 = x10 - x30;

assign v01 = x01 - x21;
assign v11 = x11 + x21;
assign v21 = x21 - x11;
assign v31 = x11 - x31;

assign v02 = x02 - x22;
assign v12 = x12 + x22;
assign v22 = x22 - x12;
assign v32 = x12 - x32;

assign v03 = x03 - x23;
assign v13 = x13 + x23;
assign v23 = x23 - x13;
assign v33 = x13 - x33;

initial begin
    $display(">>> CORRECT intransform LOADED <<<");
#1;
    $display("d31=%0d d33=%0d", d31, d33);
    $display("x30=%0d x31=%0d x32=%0d x33=%0d", x30, x31, x32, x33);
end
    


endmodule