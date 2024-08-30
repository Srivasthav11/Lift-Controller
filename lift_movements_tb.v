`timescale 10ms / 1ms


module stepper_motor_tb;

	// Inputs
	reg clk;
	reg [1:0] direction;


	// Outputs
	wire [3:0] q;

	// Instantiate the Unit Under Test (UUT)
	stepper_motor uut (
		.clk(clk), 
		.direction(direction), 
		.q(q)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		direction = 2;

		// Wait 100 ns for global reset to finish
		#100;direction = 3;
		#300;direction = 2;
		

        
		// Add stimulus here

	end
      always #5 clk=~clk;
endmodule

