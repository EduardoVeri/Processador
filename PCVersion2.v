
module PCVersion2 (
	input wire Clock, PCFunct,
	input wire [9:0] InstrucaoModificada,
	output wire [9:0] Instrucao

);

	reg [9:0] InstrucaoAtual;
	integer primeiro = 1;
	
	initial begin
		/*
			Iniciar o PC com o valor 0 decimal
			(Primeira instrução)
		*/
		InstrucaoAtual = 9'd0;
	
	end
	
	always @(posedge Clock) 
	begin	
		if (PCFunct == 1 && primeiro != 1) begin
			InstrucaoAtual = InstrucaoModificada;	
		end
		else if(primeiro) begin
			primeiro = 0;	
			InstrucaoAtual = 9'd0;
		end
	
	end
	
	// Envia o valor para a memória de instrução
	assign Instrucao = InstrucaoAtual; 

endmodule 

