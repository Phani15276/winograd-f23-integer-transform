

module normal_conv_fsmd_2d #(parameter n=6)(
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

reg [5:0] count;
reg active;
reg signed [(2*n)+7:0] acc;

integer out_r, out_c, ker_r, ker_c;
reg signed [n-1:0] d_sel, g_sel;
reg signed [(2*n)-1:0] prod;

always @(*) begin
    out_r = (count / 9) / 2;
    out_c = (count / 9) % 2;
    ker_r = (count % 9) / 3;
    ker_c = (count % 9) % 3;

    d_sel = 0;
    g_sel = 0;
    prod  = 0;

    if (active && count < 36) begin
        case (out_r)
            0: case (out_c)
                0: case (ker_r)
                    0: case (ker_c) 0:d_sel=d00; 1:d_sel=d01; 2:d_sel=d02; endcase
                    1: case (ker_c) 0:d_sel=d10; 1:d_sel=d11; 2:d_sel=d12; endcase
                    2: case (ker_c) 0:d_sel=d20; 1:d_sel=d21; 2:d_sel=d22; endcase
                endcase
                1: case (ker_r)
                    0: case (ker_c) 0:d_sel=d01; 1:d_sel=d02; 2:d_sel=d03; endcase
                    1: case (ker_c) 0:d_sel=d11; 1:d_sel=d12; 2:d_sel=d13; endcase
                    2: case (ker_c) 0:d_sel=d21; 1:d_sel=d22; 2:d_sel=d23; endcase
                endcase
            endcase
            1: case (out_c)
                0: case (ker_r)
                    0: case (ker_c) 0:d_sel=d10; 1:d_sel=d11; 2:d_sel=d12; endcase
                    1: case (ker_c) 0:d_sel=d20; 1:d_sel=d21; 2:d_sel=d22; endcase
                    2: case (ker_c) 0:d_sel=d30; 1:d_sel=d31; 2:d_sel=d32; endcase
                endcase
                1: case (ker_r)
                    0: case (ker_c) 0:d_sel=d11; 1:d_sel=d12; 2:d_sel=d13; endcase
                    1: case (ker_c) 0:d_sel=d21; 1:d_sel=d22; 2:d_sel=d23; endcase
                    2: case (ker_c) 0:d_sel=d31; 1:d_sel=d32; 2:d_sel=d33; endcase
                endcase
            endcase
        endcase

        case (ker_r)
            0: case (ker_c) 0:g_sel=g00; 1:g_sel=g01; 2:g_sel=g02; endcase
            1: case (ker_c) 0:g_sel=g10; 1:g_sel=g11; 2:g_sel=g12; endcase
            2: case (ker_c) 0:g_sel=g20; 1:g_sel=g21; 2:g_sel=g22; endcase
        endcase

        prod = d_sel * g_sel;
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
        active <= 0;
        done <= 0;
        acc <= 0;
        y00 <= 0; y01 <= 0; y10 <= 0; y11 <= 0;
    end
    else begin
        done <= 0;

        if (start && !active) begin
            count <= 0;
            active <= 1;
            acc <= 0;
            y00 <= 0; y01 <= 0; y10 <= 0; y11 <= 0;
        end
        else if (active) begin
            if ((count % 9) == 0)
                acc <= prod;
            else
                acc <= acc + prod;

            if ((count % 9) == 8) begin
                case (count / 9)
                    0: y00 <= acc + prod;
                    1: y01 <= acc + prod;
                    2: y10 <= acc + prod;
                    3: y11 <= acc + prod;
                endcase
            end

            if (count == 35) begin
                active <= 0;
                done <= 1;
            end
            else
                count <= count + 1;
        end
    end
end

endmodule