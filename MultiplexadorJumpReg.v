module MultiplexadorJumpReg (
	input [31:0] Dado1, 
	input [9:0] Jump,
	input JALR, JReg,
	output [9:0] Escolhido_MultiplexadorJumpReg
);
	
	reg [9:0] escolhido;
	
	always @ (*) begin
		
		if(JALR == 1 || JReg == 1) begin
			escolhido = Dado1[9:0];
		end
		
		else begin
			escolhido = Jump;
		end
		
	end
	
	assign Escolhido_MultiplexadorJumpReg = escolhido;
	
endmodule
