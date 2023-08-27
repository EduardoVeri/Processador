
//Modulo do Banco de Registradores
module BancodeRegistradores(Clock, Reg1, Reg2, RegEscrita, RegWrite, 
	Dado1, Dado2, EscreveDado, DadoNoRegDeEscrita, FP);

	input wire Clock, RegWrite;
	input wire [4:0] Reg1, Reg2, RegEscrita;
	input wire [31:0] EscreveDado;
	output wire [31:0] Dado1, Dado2, DadoNoRegDeEscrita, FP;
	
	reg [31:0] Registradores [31:0];
	
	integer primeiro = 1;
	
	// Verificar qual borda será utilizada nesse módulo
	always @(posedge Clock) begin
		
		if(primeiro == 1) begin
			Registradores[5'd31] <= 32'd0; // Registrador $zero 
			Registradores[5'd1] <= 32'd10;
			Registradores[5'd2] <= 32'd1;
			Registradores[5'd3] <= 32'd4;
			Registradores[5'd4] <= 32'd10;
			primeiro <= 2;
		end
		
		if ((RegWrite == 1) && (RegEscrita != 5'd31)) begin
		
			Registradores[RegEscrita] <= EscreveDado;
			
		end
		
	end

	assign DadoNoRegDeEscrita = Registradores[RegEscrita];	
	assign Dado1 = Registradores[Reg1];
	assign Dado2 = Registradores[Reg2];	
	assign FP = Registradores[5'd29];
	
endmodule 


