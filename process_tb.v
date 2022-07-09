`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:56:47 02/01/2022
// Design Name:   process
// Module Name:   C:/Xilinx/Documents/vlsi_2/process_tb.v
// Project Name:  vlsi_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: process
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module process_tb;

	// Inputs
	reg [0:7] IP;
	reg [0:7] I;
	reg clk;
	// Outputs
	wire [0:7] OP;
	wire [0:7] A;
	wire [0:7] B;
	wire [0:7] C;
	wire [0:7] D;
	wire [0:7] E;
	wire [0:7] F;
	wire [0:7] G;
	wire [0:7] H;

	// Instantiate the Unit Under Test (UUT)
	process uut (
		.IP(IP), 
		.I(I), 
		.OP(OP), 
		.A(A), 
		.B(B), 
		.C(C), 
		.D(D), 
		.E(E), 
		.F(F), 
		.G(G), 
		.H(H)
	);

	initial begin
		// Initialize Inputs
		IP = 0;				//IP is the input provided to some register
		I = 0;
		//clk = 1'b0;
		// Wait 100 ns for global reset to finish
		#100;
		
		
        
		// Add stimulus here
		IP = 8'd24;
		#5;
		I = 8'b00111000;	//IN A
		#10;
		
		
		I = 8'b10001000;	//MOV B, A
		#10;
		I = 8'b01111000;	//ADD A
		#10;
		I = 8'b10010000;  //MOV C, A; this is an extra instruction, which won't disrupt the final summation
		#10;					//added so that the stimulus for changing I is present
		I = 8'b01111000;	//ADD A
		#10;
		I = 8'b01111001;	//ADD B
		#10;
		I = 8'b11111000;	//OUT A
		
//		The following set of instructions is for getting 3 times the input number (here, 24).
//    Instead of storing results in A some other register can also be used.
//		However, for that purpose, the last 3 bits have to be changed from '000' (for A) to something different
//		Also, in that case, we need certain MOV instructions, since the addition result is always stored in A (which acts as accumulator)		
//		IP = 8'd24;
//		#5;
//		I = 8'b00111000;	//IN A
//		#10;
//		
//		
//		I = 8'b10001000;	//MOV B, A
//		#10;
//		I = 8'b01111000;	//ADD A
//		#10;
//		I = 8'b01111001;	//ADD B
//		#10;
//		I = 8'b11111000;	//OUT A
		

	end
	
	
      
endmodule

