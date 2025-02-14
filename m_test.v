`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:26:41 07/17/2022
// Design Name:   Main
// Module Name:   C:/Users/amirali/Desktop/Verilog-HW3/FinalProj/m_test.v
// Project Name:  FinalProj
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module m_test;

	// Inputs
	reg [19:0] inp;
	reg clk;

	// Outputs
	wire zero_a;
	wire sign_a;
	
	// Instantiate the Unit Under Test (UUT)
	Main uut (
		.inp(inp), 
		.clk(clk), 
		.zero_a(zero_a), 
		.sign_a(sign_a)
	);

	integer fp; //file descriptor

	initial begin
	
		clk = 0;
		inp = 0;
		
		#100;

		fp=$fopen("code.txt","r");   //"r" means reading and "w" means writing
    //read line by line.
		while (! $feof(fp) ) begin //read until an "end of file" is reached.
        $fscanf(fp, "%b\n", inp); //scan each line and get the value as an hexadecimal, use %b for binary and %d for decimal.
		  clk = 1;
        #10; //wait some time as needed.
		  clk = 0;
		  #10;
		end 
    //once reading and writing is finished, close the file.
		$fclose(fp);
	end	
      
endmodule


