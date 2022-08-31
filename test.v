`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:13:47 05/10/2022
// Design Name:   RAMB
// Module Name:   D:/zuchengyuanli/cuncuqi1/test.v
// Project Name:  cuncuqi1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RAMB
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clka;
	reg [0:0] wea;
	reg [5:0] addra;
	reg [31:0] dina;

	// Outputs
	wire [31:0] douta;

	// Instantiate the Unit Under Test (UUT)
	RAMB uut (
		.clka(clka), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta)
	);

	initial begin
		// Initialize Inputs
		clka = 0;
		wea = 0;
		addra = 0;
		dina = 0;

		// Wait 100 ns for global reset to finish
		#100;
      clka = 1;
		wea = 0;
		addra = 6'b000001;
		dina = 32'h0000_0003;
		
		#100;
		clka = 0;
		wea = 0;
		addra = 6'b000001;
		dina = 32'h0000_0607;
		
		#100;
		clka = 1;
		wea = 1;
		addra = 6'b000001;
		dina = 32'hFFFF_FFFF;
		
		#100;
		clka = 0;
		wea = 1;
		addra = 6'b000001;
		dina = 32'hFFFF_FFFF;

		// Add stimulus here

	end
      
endmodule

