

module Branch(
	input [31:0] Imediato,
	input [9:0] PCAtual,
	input MuxBranch,
	output [9:0] NovoEndereco
);
	
	reg [9:0] InstrucaoModificada;
	
	always @(*) begin
		
		// Caso tenha um desvio, o imediato é somado ao PC
		if(MuxBranch == 1) begin
			InstrucaoModificada <= Imediato[9:0];
		end
		// Caso contrário, passa apenas para a próxima instrução
		else begin
			InstrucaoModificada <= PCAtual + 1;
		end
	end

	assign NovoEndereco = InstrucaoModificada[9:0];

endmodule 

