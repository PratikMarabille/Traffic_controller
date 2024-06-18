`timescale 1ns / 1ps

module traffic_controller_tb;

    // Inputs
    reg clk;
    reg reset;

    // Outputs
    wire [2:0] north_light;
    wire [2:0] west_light;
    wire [2:0] south_light;
    wire [2:0] east_light;

    // Instantiate the Unit Under Test (UUT)
    traffic_controller uut (
        .north_light(north_light),
        .west_light(west_light),
        .south_light(south_light),
        .east_light(east_light),
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        reset = 1;
        #10;
        reset = 0;

        // Check each state transition
        check_state(3'b000, 16); // North Green
        check_state(3'b001, 4);  // North Yellow
        check_state(3'b010, 16); // West Green
        check_state(3'b011, 4);  // West Yellow
        check_state(3'b110, 16); // South Green
        check_state(3'b111, 4);  // South Yellow
        check_state(3'b100, 16); // East Green
        check_state(3'b101, 4);  // East Yellow

        // Let the simulation run for an additional cycle to confirm repeatability
        check_state(3'b000, 16); // North Green again

        $finish;
    end

    // Task to check each state and its duration
    task check_state;
        input [2:0] expected_state;
        input integer duration;

        integer i;
        begin
            for (i = 0; i < duration; i = i + 1) begin
                @(posedge clk);
                if (uut.state !== expected_state) begin
                    $display("Error at time %0t: expected state %b but got %b", $time, expected_state, uut.state);
                    $stop;
                end
            end
            $display("State %b verified for %0d cycles", expected_state, duration);
        end
    endtask

    // Monitor the outputs
    initial begin
        $monitor("Time: %0t | State: %b | North Light: %b | West Light: %b | South Light: %b | East Light: %b", 
                 $time, uut.state, north_light, west_light, south_light, east_light);
    end

endmodule
