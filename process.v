`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:12:27 02/01/2022 
// Design Name: 
// Module Name:    process 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//module cla_16(a, b, cin, s, cout
//    );
//	 input [15:0] a, b;
//	 input cin;
//	 output reg [15:0] s;
//	 output reg cout;
//	 
//	 reg [15:0] p, g;
//	 reg [16:0] carry;
//	 integer i;
//	 
//	 	 /*xor x1 (p[0], a[0], b[0]);
//		 xor x2 (p[1], a[1], b[1]);
//		 xor x3 (p[2], a[2], b[2]);
//		 xor x4 (p[3], a[3], b[3]);
//		 
//		 and y1 (g[0], a[0], b[0]);
//		 and y2 (g[1], a[1], b[1]);
//		 and y3 (g[2], a[2], b[2]);
//		 and y4 (g[3], a[3], b[3]);*/
//		 
//		 always @(a or b or cin)
//			begin
//				
//				for(i=0;i<=15;i = i+1)
//				begin
//					p[i] = a[i]^b[i];
//					g[i] = a[i]&b[i];				
//				
//				end
//				 carry[0] = cin;
//				 
//				 for(i=0;i<=15;i=i+1)
//					 begin
//						
//						s[i] = p[i]^carry[i];
//						carry[i+1] = g[i]|(p[i]&carry[i]);	 
//					 
//					 
//					 end
//			 
//				cout = carry[16];
//			
//			end
//	 
//
//
//endmodule
//
///*
//module cla_16(a, b, cin, sum, cout
//    );
//	 
//	 input [15:0] a, b;
//	 input cin;
//	 output [15:0] sum; 
//	 output cout;
//	 
//	 reg [3:0] s0, s1, s2, s3;
//	 reg c1, c2, c3;
//	 
//	 cla_4 add1 (a[3:0], b[3:0], cin, s0, c1);
//	 cla_4 add2 (a[7:4], b[7:4], c1, s1, c2);
//	 cla_4 add3 (a[11:8], b[11:8], c2, s2, c3);
//	 cla_4 add4 (a[15:12], b[15:12], c3, s3, cout);
//	 
//	 sum <= {s3, s2, s1, s0};	
//
//endmodule
//*/

module process(
     IP, I,
	 OP,A,B,C,D,E,F,G,H
    );
	 input [0:7] IP, I;
	 //input clk;
	 //input clk;
    reg [0:7] nums [0:8];		//nums is a 2D register; consists of 9 <OP, A to H> 8-bit registers
	 reg cout;
	 output reg [0:7] OP, A, B, C, D, E, F, G, H;
	integer x,y,z;

	always @(I)	//for source register
		
		begin
		if(~I[5]&~I[6]&~I[7])
		  x=0;
		else if(~I[5]&~I[6]&I[7])
		  x=1;
		else if(~I[5]&I[6]&~I[7])
		  x=2;
		else if(~I[5]&I[6]&I[7])
		  x=3;
		else if(I[5]&~I[6]&~I[7])
		  x=4;
		else if(I[5]&~I[6]&I[7])
		  x=5;
		else if(I[5]&I[6]&~I[7])
		  x=6;
		else if(I[5]&I[6]&I[7])
		  x=7;
		
		end

	always @(I)			//for destination register
		begin
		if(~I[2]&~I[3]&~I[4])
		  y=0;
		else if(~I[2]&~I[3]&I[4])
		  y=1;
		else if(~I[2]&I[3]&~I[4])
		  y=2;
		else if(~I[2]&I[3]&I[4])
		  y=3;
		else if(I[2]&~I[3]&~I[4])
		  y=4;
		else if(I[2]&~I[3]&I[4])
		  y=5;
		else if(I[2]&I[3]&~I[4])
		  y=6;
		else if(I[2]&I[3]&I[4])
		  y=7;
		end


	always @(I)		//kind of instruction
		begin
		if(~I[0]&~I[1])		//input
		  z=0;
		else if(~I[0]&I[1])		//add
		  z=1;
		else if(I[0]&~I[1])		/* move....actually copy */
		  z=2;
		else if(I[0]&I[1])		//output
		  z=3;
		end
	
	always @(I)
		begin

		if(z==0)
			begin
			 nums[x]=IP;		//take input into register x
			end

		else if(z==3)
			begin
			 OP=nums[x];		//output to OP register 
			end

		else if(z==2)
			begin
			 nums[y]=nums[x];	//copy content of register X to register Y
			end

		else if(z==1)
			begin
			nums[8]=nums[0];
			{cout,nums[0]}=nums[8]+nums[x];
			
			end

		end

	always @(I)
		begin
		 A=nums[0];
		 B=nums[1];
		 C=nums[2];
		 D=nums[3];
		 E=nums[4];
		 F=nums[5];
		 G=nums[6];
		 H=nums[7];
		end 

endmodule
