module recoder ( input [2:0] y, output sign, one, two);

    assign one = (y[1] ^ y[0]);
    assign sign = y[2];
    assign two = ((~y[2]) & y[1] & y[0]) | (y[2] & (~y[1]) & (~y[0]));
    
endmodule

module muliplicand_gen(input [6:0] x, input one, two, sign, output [8:0] out);

    wire [8:0] temp_x, temp_x_2 , out_temp;

    assign temp_x = {x[6],x[6],x};
    assign temp_x_2 = {x[6],x,1'b0};

    assign out_temp = one ? temp_x : two ? temp_x_2 : 9'b0;
    assign out = sign? (~out_temp + 1) : out_temp;

endmodule

module FullAdder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));

endmodule

module RippleCarryAdder #(parameter WIDTH = 11) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [WIDTH-1:0] sum,
    output cout
);

    wire [WIDTH:0] carry;

    assign carry[0] = 1'b0;
    assign cout = carry[WIDTH];

    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : gen
            FullAdder FA (
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .sum(sum[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

endmodule


module multiplier (input [6:0] x,y, output [14:0] out);

    wire [8:0] y_temp = {y[6],y,1'b0};
    wire [8:0] multiplicand[3:0];

    wire [3:0] sign,one,two;

    recoder r1(y_temp[2:0], sign[0], one[0], two[0]);
    recoder r2(y_temp[4:2], sign[1], one[1], two[1]);
    recoder r3(y_temp[6:4], sign[2], one[2], two[2]);
    recoder r4(y_temp[8:6], sign[3], one[3], two[3]);


    muliplicand_gen m1(x, one[0], two[0], sign[0], multiplicand[0]);
    muliplicand_gen m2(x, one[1], two[1], sign[1], multiplicand[1]);
    muliplicand_gen m3(x, one[2], two[2], sign[2], multiplicand[2]);
    muliplicand_gen m4(x, one[3], two[3], sign[3], multiplicand[3]);

    wire [14:0] temp1,temp2;


    RippleCarryAdder #(15) cra1({{multiplicand[0][8]}, {multiplicand[0][8]}, {multiplicand[0][8]},{multiplicand[0][8]},{multiplicand[0][8]},{multiplicand[0][8]},multiplicand[0]},
                            {{multiplicand[1][8]}, {multiplicand[1][8]}, {multiplicand[1][8]},{multiplicand[1][8]},multiplicand[1], 2'b0}, temp1, );

    RippleCarryAdder #(15) cra2({{multiplicand[2][8]}, {multiplicand[2][8]}, multiplicand[2], 4'b0},
                                {multiplicand[3], 6'b0}, temp2,);

    RippleCarryAdder #(15) cra3(temp1, temp2, out,);

    // assign out = {{multiplicand[0][8]}, {multiplicand[0][8]}, {multiplicand[0][8]},{multiplicand[0][8]},{multiplicand[0][8]},{multiplicand[0][8]},multiplicand[0]} + 
    //              {{multiplicand[1][8]}, {multiplicand[1][8]}, {multiplicand[1][8]},{multiplicand[1][8]},multiplicand[1], 2'b0} + 
    //              {{multiplicand[2][8]}, {multiplicand[2][8]}, multiplicand[2], 4'b0} + 
    //              {multiplicand[3], 6'b0};s


    
endmodule