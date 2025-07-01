module tb_washing_machine;

    reg clk, rst, start, door_closed;
    wire [2:0] state;
    wire water_valve, motor, drain_valve, done;

    washing_machine uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .door_closed(door_closed),
        .state(state),
        .water_valve(water_valve),
        .motor(motor),
        .drain_valve(drain_valve),
        .done(done)
    );

    initial begin
        $dumpfile("washing_machine.vcd");
        $dumpvars(0, tb_washing_machine);

        clk = 0; rst = 1; start = 0; door_closed = 1;
        #10 rst = 0;
        #10 start = 1;
        #500 $finish;
    end

    always #5 clk = ~clk;

endmodule
