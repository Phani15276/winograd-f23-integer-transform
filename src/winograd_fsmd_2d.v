

module winograd_fsmd_2d #(parameter n=6)(
    input clk,
    input reset,
    input start,

    input signed [n-1:0]
        d00,d01,d02,d03,
        d10,d11,d12,d13,
        d20,d21,d22,d23,
        d30,d31,d32,d33,

    input signed [n-1:0]
        g00,g01,g02,
        g10,g11,g12,
        g20,g21,g22,

    output reg signed [(2*n)+7:0]
        y00,y01,
        y10,y11,

    output reg done
);

wire signed [(2*n)+7:0] y00_w,y01_w,y10_w,y11_w;
reg [2:0] count;
reg active;

allconn_2d #(n) core (
    .d00(d00),.d01(d01),.d02(d02),.d03(d03),
    .d10(d10),.d11(d11),.d12(d12),.d13(d13),
    .d20(d20),.d21(d21),.d22(d22),.d23(d23),
    .d30(d30),.d31(d31),.d32(d32),.d33(d33),

    .g00(g00),.g01(g01),.g02(g02),
    .g10(g10),.g11(g11),.g12(g12),
    .g20(g20),.g21(g21),.g22(g22),

    .y00(y00_w),.y01(y01_w),
    .y10(y10_w),.y11(y11_w)
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
        active <= 0;
        done <= 0;
        y00 <= 0; y01 <= 0; y10 <= 0; y11 <= 0;
    end
    else begin
        done <= 0;

        if (start && !active) begin
            active <= 1;
            count <= 0;
        end
        else if (active) begin
            count <= count + 1;

            if (count == 5) begin
                y00 <= y00_w;
                y01 <= y01_w;
                y10 <= y10_w;
                y11 <= y11_w;
                done <= 1;
                active <= 0;
            end
        end
    end
end

endmodule