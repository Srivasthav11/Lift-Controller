`timescale 10ms / 1ms

module lift_tb();

  // Declare testbench signals
  reg clk, rst;
  reg [5:0] move_up_call, move_down_call, req_floor;
  reg [14:0] weight_data;
  reg sensor_failure, open_door, close_door, over_weight, rod_detect_sensor;
  wire [1:0] current_floor, direction;
  wire door_state, over_weight_alert;
  wire fan_state, light_state, rod_activate_sensor, brake_controller;

   // Instantiate the elevator module
  lift_controller dut (
    .move_up_call(move_up_call),  
    .move_down_call(move_down_call),
    .req_floor(req_floor),
    .weight_data(weight_data),
    .sensor_failure(sensor_failure),
    .brake_controller(brake_controller),
    .clk(clk),
    .rst(rst),
    .open_door(open_door),
    .close_door(close_door),
    .over_weight(over_weight),
    .rod_detect_sensor(rod_detect_sensor),
    .current_floor(current_floor),
    .direction(direction),
    .door_state(door_state),
    .over_weight_alert(over_weight_alert),
    .fan_state(fan_state),
    .light_state(light_state),
    .rod_activate_sensor(rod_activate_sensor)
  );

  // Generate a clock signal
  initial clk = 0;
  always #5 clk = ~clk; 

  // Initial values and reset
  initial begin
    rst = 1;
    move_up_call = 0;
    move_down_call = 0;
    req_floor = 0; 
    weight_data = 0;
    sensor_failure = 0;
    open_door = 0;
    close_door = 1;  // Ensure door starts closed
    over_weight = 0;
    rod_detect_sensor = 0;

    #15 rst = 0; 
  end

  // Test Scenarios
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    // Normal movement
    #20 move_up_call[2] = 1;  // Request to go up from floor 2
    #50 move_up_call[2] = 0; 
    #100 req_floor[0] = 1;   // Request from inside to go to floor 0
    #50 req_floor[0] = 0;

    // Overweight scenario
    #200 weight_data = 14'b11011010110100; // Exceed weight limit
    #50 weight_data = 0; 

    // Sensor failure scenario
    #300 sensor_failure = 1;
    #50 sensor_failure = 0;
    
    #50     
    //brake_controller = 0;
    rod_detect_sensor = 1;
    
    #50     rod_detect_sensor = 0;

    
    #100
    $finish;


    // Add more test cases as needed...

    #500 $finish;
  end

endmodule

