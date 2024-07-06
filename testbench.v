module testbench;

    reg [6:0] x, y;
    wire [14:0] res;

    multiplier mult (
        .x(x),
        .y(y),
        .out(res)
    );

    initial begin
        x = 7'b0000011;
        y = 7'b0000001;
        #10
        x = 7'b0001011;
        y = 7'b1000001;
        #100 $stop; 
    end

endmodule