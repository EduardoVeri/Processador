module Jump(
	input [25:0] Imediato26bits,
	output [31:0] Instrucao
);
	reg [31:0] RegImediato;
	
	always @(*) begin
		// Caso precise extender, fazer aqui!
		RegImediato = {6'b0, Imediato26bits};
	
	end

	assign Instrucao = RegImediato;
	
endmodule
	