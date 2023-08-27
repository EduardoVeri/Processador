
module IntegracaoBRULAMEM(
	input EntradaClock,
	//input ClockTeste,
	input [13:0] Sw,
	input Botao,
	output [6:0] Display1, Display2, Display3, Display4, DisplayRef, Display6, Display_FP1, Display_FP2,
	output [13:0] Led,
	output LedVerde
	/*output [4:0] multiplexadorRegDestino, multiplexadorRegDst,
	output [9:0] SaidaPC,
	output [9:0] SaidaNovoEndereco,
	output [9:0] SaidaEnderecoInstrucao,
	output [9:0] SaidaEscolhido_MultiplexadorJump*/
);	
	
	/*
		Aqui serão colocadas todas os fios de saída dos módulos,
		para que sejam usados para interconectá-los
	*/
	reg [31:0] Imediato_extendido;
	reg [31:0] Proxima_Intrucao;
	
	// Saida Unidade de Controle
	wire RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc, 
		RegDst, PCFunct, ControlJump, BEQ, BNE, Halt, In, Out, EnableClock, JAL;
	wire [2:0] ALUOp;
	
	//Saida Unidade de Controle da ULA
	wire [3:0] Control_ALU;
	wire JALR, JR;
	
	// Saida ULA
	wire [31:0] Saida_ULA;
	wire Zero;
	
	// Saída Banco Registradores
	wire [31:0] BR_Dado1, BR_Dado2, ResultadoEscritaBanco;
	
	// Saída Memória RAM
	wire [31:0] DadoMemoriaRAM;
	
	// Saída Multiplexador MemToReg
	wire [31:0] Escolhido_MultiplexadorMemtoReg;
	
	// Saída Multiplexador ALUSrc
	wire [31:0] Escolhido_MultiplexadorALUSrc;
	
	// Saída Multiplexador RegDst
	wire [4:0] EscolhidoMultiplexadorRegDst;
	
	// Saida PC
	wire [9:0] EnderecoInstrucao;
	
	// Saida ROM
	wire [31:0] Instrucao;
	
	// Saida Modulo de Branch
	wire [9:0] NovoEndereco;
	
	// Saida Modulo de Jump
	wire [31:0] EnderecoDoJump;
	
	// Saida Multiplexador Jump
	wire [9:0] Escolhido_MultiplexadorJump;
	
	// Saida BNEandBEQ
	wire ControlBranch;
	
	// Saida Entrada
	wire [14:0] resultadoEntrada;
	wire saidaBotao;
	wire Clock;
	
	//Saida Multiplexador Entrada
	wire [31:0] EscolhidoMultiplexadorEntrada;
	
	//Saida Multiplexador Saida
	wire [31:0] EsolhidoMultiplexadorSaida;
	
	//Saida Multiplexador JAL JALR para o BR
	wire [4:0] EscolhidoMultiplexadorDestino;
	
	//Saida Multiplexador JAL com o valor armazenado do PC 
	wire [9:0] Escolhido_MultiplexadorJAL;
	
	//Saida Multiplexador JReg e JALR, direcionando o valor do banco de Reg para o PC
	wire [9:0] Escolhido_MultiplexadorJumpReg;
	
	
	wire [31:0] FP;
	
	// Extensor de Imediato
	always @(Instrucao[15:0]) begin
		Imediato_extendido = {16'b0000000000000000, Instrucao[15:0]};
	end
	
	reg [13:0] resultadoSomaEntrada;
	
	integer inteiroContagem = 1;
	
	always @(posedge Clock) begin
		if(inteiroContagem) begin
			resultadoSomaEntrada = resultadoEntrada;
			inteiroContagem = 0;
		end
		else
			resultadoSomaEntrada = resultadoSomaEntrada + resultadoEntrada;
	end
	
	Saida exit (
		EsolhidoMultiplexadorSaida[12:0],
		Halt, Clock, Out,
		Led[12:0],
		Display1, Display2, Display3, Display4, DisplayRef, Display6, Display_FP1, Display_FP2,
		EnderecoInstrucao,
		FP
	);
	
	assign Led[13] = In;
	assign LedVerde = Clock;
	
	Entrada enter (
		EntradaClock, Botao,
		Sw,
		resultadoEntrada,
		saidaBotao, Clock, EnableClock
	);
	
	UnidadeControle UC (Instrucao[31:26], Clock, saidaBotao, ALUOp, RegDst, MemRead, MemtoReg, MemWrite, 
		ALUSrc, RegWrite, PCFunct, BEQ, BNE, ControlJump, Halt, In, Out, EnableClock, JAL);
	
	UnidadeControleULA UCA (Instrucao[5:0], ALUOp, Control_ALU, JALR, JR);
	
	BancodeRegistradores BR (.Clock(Clock), .Reg1(Instrucao[25:21]), .Reg2(Instrucao[20:16]), .RegEscrita(EscolhidoMultiplexadorDestino), 
		.RegWrite(RegWrite), .Dado1(BR_Dado1), .Dado2(BR_Dado2), .EscreveDado(EscolhidoMultiplexadorEntrada), .DadoNoRegDeEscrita(ResultadoEscritaBanco), .FP(FP));
	
	ULA alu (BR_Dado1, Escolhido_MultiplexadorALUSrc, Control_ALU, Saida_ULA, Zero, Instrucao[10:6]);
	
	MemoriaDados MD (BR_Dado2, Saida_ULA, MemWrite, MemRead, Clock, DadoMemoriaRAM);
	
	MultiplexadorMemtoReg MMTR(DadoMemoriaRAM, Saida_ULA, MemtoReg, Escolhido_MultiplexadorMemtoReg);
	
	MultiplexadorALUSrc MAS (Imediato_extendido, BR_Dado2, ALUSrc, Escolhido_MultiplexadorALUSrc);
	
	MultiplexadorRegDst MRD (Instrucao[20:16], Instrucao[15:11], RegDst, EscolhidoMultiplexadorRegDst);
	
	PCVersion2 PC (Clock, PCFunct, Escolhido_MultiplexadorJumpReg, EnderecoInstrucao);
	
	ROM ReadOnly(EnderecoInstrucao, Clock, Instrucao);
	
	Branch Bran (Imediato_extendido, EnderecoInstrucao, ControlBranch, NovoEndereco);

	Jump Salto (Instrucao[25:0], EnderecoDoJump);
	
	MultiplexadorJump MJ (NovoEndereco, EnderecoDoJump, ControlJump, Escolhido_MultiplexadorJump);
	
	BNEandBEQ BAQ (BEQ, BNE, Zero, ControlBranch);
	
	MultiplexadorEntrada ME (resultadoEntrada, Escolhido_MultiplexadorJAL, In, EscolhidoMultiplexadorEntrada);
	
	MultiplexadorSaida MS (resultadoEntrada, Saida_ULA, In, Out, EsolhidoMultiplexadorSaida);
	
	MultiplexadorDestino MDJAL (EscolhidoMultiplexadorRegDst, JAL, JALR, EscolhidoMultiplexadorDestino);
	
	MultiplexadorJAL MJAL (NovoEndereco, Escolhido_MultiplexadorMemtoReg, JALR, JAL, Escolhido_MultiplexadorJAL);
	
	MultiplexadorJumpReg (BR_Dado1, Escolhido_MultiplexadorJump, JALR, JR, Escolhido_MultiplexadorJumpReg);
	
	//wire multiplexadorRegDestino;
	/*assign multiplexadorRegDestino = EscolhidoMultiplexadorDestino;
	assign multiplexadorRegDst = EscolhidoMultiplexadorRegDst;
	assign SaidaPC = Escolhido_MultiplexadorJumpReg;
	assign SaidaEscolhido_MultiplexadorJump = Escolhido_MultiplexadorJump;
	assign SaidaNovoEndereco = NovoEndereco;
	assign SaidaEnderecoInstrucao = EnderecoInstrucao;*/

endmodule 