`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:14:01 07/13/2022 
// Design Name: 
// Module Name:    Main 
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
module Main(
	input [19:0]inp,
	input clk,
	output reg zero_a,
	output reg sign_a
    );
	 
	reg [3:0]code;
	reg [7:0]p1;
	reg [7:0]p2;
	reg [15:0]multmp;
	reg [15:0]result;
	
	reg [12:0]floating_point_3digit;
	reg [15:0] binary_floating_point;
	reg [7:0] exp_value; 
	reg [7:0] decimal_point;
	reg condition;
	reg sign;
   reg [7:0] exp;
   reg [6:0] mantissa;
	integer i;
	


	
	reg [7:0]Ra = 0;
	reg [7:0]Rb = 0;
	reg [7:0]Rc = 0;
	reg [7:0]Rd = 0;
	 
	parameter Ra_id = 8'b00000001;
	parameter Rb_id = 8'b00000010;
	parameter Rc_id = 8'b00000100;
	parameter Rd_id = 8'b00001000;
	
	parameter load_op_reg = 4'b0001;
	parameter load_reg_reg = 4'b0010;
	parameter add_op_reg = 4'b0011;
	parameter add_reg_reg = 4'b0100;
	parameter sub_op_reg = 4'b0101;
	parameter sub_reg_reg = 4'b0110;
	parameter mult_op_reg = 4'b0111;
	parameter mult_reg_reg = 4'b1000;
	parameter shr_op_reg = 4'b1011;
	parameter shl_op_rep = 4'b1100;
	parameter fraction = 4'b1101;
		
	always @(posedge clk)begin
		code = inp[19:16];
		p2 = inp[15:8];
		p1 = inp[7:0];
		multmp = 0;
		
		$display("code = %b / p1 = %b / p2 = %b", code, p1, p2);
		
		if (code == load_op_reg)begin
		
			$display("Code 1");
		
			if (p2 == Ra_id)
				Ra = p1;
			
			else if (p2 == Rb_id)
				Rb = p1;
			
			else if (p2 == Rc_id)
				Rc = p1;
			
			else if (p2 == Rd_id)
				Rd = p1;
				
			multmp = p1;
							
		end
		
		else if (code == load_reg_reg)begin
			
			$display("Code 2");
			
			if (p2 == Ra_id)begin
			
				if (p1 == Rb_id)
					Ra = Rb;
					
				else if (p1 == Rc_id)
					Ra = Rc;
					
				else if (p1 == Rd_id)
					Ra = Rd;
					
				multmp = Ra;
				
			end
			
			else if (p2 == Rb_id)begin
				
				if (p1 == Ra_id)
					Rb = Ra;
					
				else if (p1 == Rc_id)
					Rb = Rc;
					
				else if (p1 == Rd_id)
					Rb = Rd;
					
				multmp = Rb;
					
			end
			
			else if (p2 == Rc_id)begin
				
				if (p1 == Ra_id)
					Rc = Ra;
					
				else if (p1 == Rb_id)
					Rc = Rb;
					
				else if (p1 == Rd_id)
					Rc = Rd;
				
				multmp = Rc;
				
			end
			
			else if (p2 == Rd_id)begin
				
				if (p1 == Ra_id)
					Rd = Ra;
					
				else if (p1 == Rc_id)
					Rd = Rc;
					
				else if (p1 == Rb_id)
					Rd = Rb;
				
				multmp = Rd;
				
			end				
		
		end
		
		else if (code == add_op_reg)begin
			
			$display("Code 3");
			
			if (p2 == Ra_id)begin
				Ra = Ra + p1;
				multmp = Ra;
			end
			
			else if (p2 == Rb_id)begin
				Rb = Rb + p1;
				multmp = Rb;
			end
				
			else if (p2 == Rc_id)begin
				Rc = Rc + p1;
				multmp = Rc;
			end
			
			else if (p2 == Rd_id)begin
				Rd = Rd + p1;
				multmp = Rd;
			end
			
		end
		
		else if (code == add_reg_reg)begin
			
			$display("Code 4");
			
			if (p2 == Ra_id)begin
				
				if (p1 == Rb_id)
					Ra = Rb + Ra;
				
				else if (p1 == Rc_id)
					Ra = Rc + Ra;
				
				else if (p1 == Rd_id)
					Ra = Rd + Ra;
					
				else if (p1 == Ra_id)
					Ra = Ra + Ra;
									
				multmp = Ra;
				
			end
			
			else if (p2 == Rb_id)begin
				
				if (p1 == Ra_id)
					Rb = Ra + Rb;
					
				else if (p1 == Rc_id)
					Rb = Rc + Rb;
					
				else if (p1 == Rd_id)
					Rb = Rd + Rb;
					
				else if (p1 == Rb_id)
					Rb = Rb + Rb;
				
				multmp = Rb;
				
			end
			
			else if (p2 == Rc_id)begin
				
				if (p1 == Ra_id)
					Rc = Ra + Rc;
					
				else if (p1 == Rb_id)
					Rc = Rb + Rc;
					
				else if (p1 == Rd_id)
					Rc = Rd + Rc;
					
				else if (p1 == Rc_id)
					Rc = Rc + Rc;
				
				multmp = Rc;
				
			end
			
			else if (p2 == Rd_id)begin
				
				if (p1 == Ra_id)
					Rd = Ra + Rd;
					
				else if (p1 == Rb_id)
					Rd = Rb + Rd;
					
				else if (p1 == Rc_id)
					Rd = Rc + Rd;
					
				else if (p1 == Rd_id)
					Rd = Rd + Rd;
				
				multmp = Rd;
				
			end
			
		end
		
		else if (code == sub_op_reg)begin
			
			$display("Code 5");
			
			if (p2 == Ra_id)begin
				Ra = Ra - p1;
				multmp = Ra;
			end
				
			else if (p2 == Rb_id)begin
				Rb = Rb - p1;
				multmp = Rb;
			end
				
			else if (p2 == Rc_id)begin
				Rc = Rc - p1;
				multmp = Rc;
			end
			
			else if (p2 == Rd_id)begin
				Rd = Rd - p1;
				multmp = Rd;
			end
			
		end
		
		else if (code == sub_reg_reg)begin
			
			$display("Code 6");
			
			if (p2 == Ra_id)begin
			
				if (p1 == Rb_id)
					Ra = Ra - Rb;
					
				else if (p1 == Rc_id)
					Ra = Ra - Rc;
					
				else if (p1 == Rd_id)
					Ra = Ra - Rd;
					
				else if (p1 == Ra_id)
					Ra = Ra - Ra;
					
				multmp = Ra;
					
			end
					
			else if (p2 == Rb_id)begin
				
				if (p1 == Ra_id)
					Rb = Rb - Ra;
					
				else if (p1 == Rc_id)
					Rb = Rb - Rc;
					
				else if (p1 == Rd_id)
					Rb = Rb - Rd;
					
				else if (p1 == Rb_id)
					Rb = Rb - Rb;
				
				multmp = Rb;
				
			end
					
			else if (p2 == Rc_id)begin
				
				if (p1 == Ra_id)
					Rc = Rc - Ra;
					
				else if (p1 == Rb_id)
					Rc = Rc - Rb;
					
				else if (p1 == Rd_id)
					Rc = Rc - Rd;
					
				else if (p1 == Rc_id)
					Rc = Rc - Rc;
					
				multmp = Rc;
				
			end
					
			else if (p2 == Rd_id)begin
			
				if (p1 == Ra_id)
					Rd = Rd - Ra;
					
				else if (p1 == Rb_id)
					Rd = Rd - Rb;
					
				else if (p1 == Rc_id)
					Rd = Rd - Rc;
					
				else if (p1 == Rd_id)
					Rd = Rd - Rd;
				
				multmp = Rd;
				
			end
				
		end
								
		else if (code == mult_op_reg)begin
			
			$display("Code 6");
			
			if (p2 == Ra_id)
				multmp = Ra * p1;
				
			else if (p2 == Rb_id)
				multmp = Rb * p1;
				
			else if (p2 == Rc_id)
				multmp = Rc * p1;
				
			else if (p2 == Rd_id)
				multmp = Rd * p1;
				
			Rd = multmp[15:8];
			Ra = multmp[7:0];
					
		end
		
		else if (code == mult_reg_reg)begin
				
			$display("Code 7");
				
			if (p2 == Ra_id)begin
				
				if (p1 == Rb_id)
					multmp = Ra * Rb;
				
				else if (p1 == Rc_id)
					multmp = Ra * Rc;
				
				else if (p1 == Rd_id)
					multmp = Ra * Rd;
					
				else if (p1 == Ra_id)
					multmp = Ra * Ra;
				
			end
			
			else if (p2 == Rb_id)begin
			
				if (p1 == Ra_id)
					multmp = Rb * Ra;
					
				else if (p1 == Rc_id)
					multmp = Rb * Rc;
					
				else if (p1 == Rd_id)
					multmp = Rb * Rd;
					
				else if (p1 == Rb_id)
					multmp = Rb * Rb;
					
			end
			
			else if (p2 == Rc_id)begin
				
				if (p1 == Ra_id)
					multmp = Rc * Ra;
					
				else if (p1 == Rb_id)
					multmp = Rc * Rb;
					
				else if (p1 == Rd_id)
					multmp = Rc * Rd;
					
				else if (p1 == Rc_id)
					multmp = Rc * Rc;
			
			end
			
			else if (p2 == Rd_id)begin
			
				if (p1 == Ra_id)
					multmp = Rd * Ra;
					
				else if (p1 == Rb_id)
					multmp = Rd * Rb;
					
				else if (p1 == Rc_id)
					multmp = Rd * Rc;
					
				else if (p1 == Rd_id)
					multmp = Rd * Rd;
			
			end
			
			Rd = multmp[15:8];
			Ra = multmp[7:0];
								
		end
		
		else if (code == shr_op_reg)begin
			
			$display("Code 8");
			
			if (p2 == Ra_id)begin
				Ra = Ra >> p1;
				multmp = Ra;
			end
			
			else if (p2 == Rb_id)begin
				Rb = Rb >> p1;
				multmp = Rb;
			end
				
			else if (p2 == Rc_id)begin
				Rc = Rc >> p1;
				multmp = Rc;
			end
				
			else if (p2 == Rd_id)begin
				Rd = Rd >> p1;
				multmp = Rd;
			end
		
		end
		
		else if (code == shl_op_rep)begin
			
			$display("Code 9");
			
			if (p2 == Ra_id)begin
				Ra = Ra << p1;
				multmp = Ra;
			end
			
			else if (p2 == Rb_id)begin
				Rb = Rb << p1;
				multmp = Rb;
			end
				
			else if (p2 == Rc_id)begin
				Rc = Rc << p1;
				multmp = Rc;
			end
			
			else if (p2 == Rd_id)begin
				Rd = Rd << p1;
				multmp = Rd;
			end
			
		end
		
		else if (code == fraction)begin
		
			mantissa = 0;
			binary_floating_point = 0;
			exp_value = 0;
			exp = 0;
				
				decimal_point = p2;
				
				// convert floating point to 3 digits
				if(p1 < 10)
					floating_point_3digit = p1 * 100;
				else if(p1 < 100)
					floating_point_3digit = p1 * 10;
				else
					floating_point_3digit = p1;
				
				for(i = 0; i < 16; i = i + 1) begin
						floating_point_3digit = floating_point_3digit * 2;				
						if (floating_point_3digit >= 1000) begin
							binary_floating_point[15 - i] = 1;
							floating_point_3digit = floating_point_3digit - 1000;
						end
						else
							binary_floating_point[15 - i] = 0;
				end
				
				
				sign = 0;
				if(decimal_point[7]) begin
					sign = 1;
					// two's complement
					decimal_point = ~decimal_point + 1;
				end
				
				// going on exponent checking 1's
				exp_value = -1;
				for(i = 0; i < 8; i = i + 1) 
					if(decimal_point[i]) 
						exp_value = i;
				// if demial part doesn't have any 1
				condition = 1;
				if(exp_value[7])
					for(i = 0; i < 8; i = i + 1)
						if(binary_floating_point[15 - i] == 0 & condition) 
							exp_value = -1 * i - 2;
						else
							condition = 0;
						
				// adding excess-k
				exp = 127 + exp_value;
				
				// checking wich part of binary floating point should be used
				case(exp_value)
					8'b11111001: mantissa[6 : 0] = binary_floating_point[8:2];
					
					8'b11111010: mantissa[6 : 0] = binary_floating_point[9:3];
				
					8'b11111011: mantissa[6 : 0] = binary_floating_point[10:4];
					
					8'b11111100: mantissa[6 : 0] = binary_floating_point[11:5];
					
					8'b11111101: mantissa[6 : 0] = binary_floating_point[12:6];
					
					8'b11111110: mantissa[6 : 0] = binary_floating_point[13:7];
					
					8'b11111111: mantissa[6 : 0] = binary_floating_point[14:8];
					
					0: begin 
						mantissa[6 : 0] = binary_floating_point[15 : 9];
					end
					1: begin 
						mantissa[6 : 6] = decimal_point[0:0]; 
						mantissa[5 : 0] = binary_floating_point[15 : 10];
					end
					2: begin 
						mantissa[6 : 5] = decimal_point[1:0]; 
						mantissa[4 : 0] = binary_floating_point[15 : 11];
					end
					3: begin 
						mantissa[6 : 4] = decimal_point[2:0]; 
						mantissa[3 : 0] = binary_floating_point[15 : 12];
					end
					4: begin 
						mantissa[6 : 3] = decimal_point[3:0]; 
						mantissa[2 : 0] = binary_floating_point[15 : 13];
					end
					5: begin 
						mantissa[6 : 2] = decimal_point[4:0]; 
						mantissa[1 : 0] = binary_floating_point[15 : 14];
					end
					6: begin 
						mantissa[6 : 1] = decimal_point[5:0]; 
						mantissa[0 : 0] = binary_floating_point[15 : 15];
					end
				endcase
				
				if(p2 == 0 && p1 == 0)begin
					mantissa = 0;
					exp = 0;
				end
				
				Rc=exp;
				Rb[7]=sign;
				Rb[6:0]=mantissa;
				multmp[15] = sign;
				multmp[14:7] = Rc;
				multmp[6:0] = mantissa;
				result = multmp;
							
		end
				
		if (multmp == 0)
			zero_a = 1;
		else
			zero_a = 0;
		
		if (code == mult_op_reg || code == mult_reg_reg)
			sign_a = multmp[7];
		else
			sign_a = multmp[15];
		
		$display("%b", Ra);
		$display("%b", Rb);
		$display("%b", Rc);
		$display("%b", Rd);
		$display("Result : %b || ZF : %b || SF : ", multmp, zero_a, sign_a);
			
		
	end
		

endmodule
