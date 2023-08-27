module MultiplexadorJump(
	input [9:0] NormalouBranch, 
	input [31:0] Jump,
	input ControlJump,
	output [9:0] Escolhido_MultiplexadorJump
);
	
	reg [9:0] escolhido;
	
	always @(*) begin
	
		if(ControlJump == 1) begin
			escolhido = Jump[9:0];
		end
		
		else begin
			escolhido = NormalouBranch;
		end
		
	end
	
	assign Escolhido_MultiplexadorJump = escolhido;
	
endmodule