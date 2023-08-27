module UnidadeControle (
	input [6:0] Opcode,
	input clock, Button,
	output [2:0] AluOp,
	output RegDst, MemRead, MemtoReg,
		MemWrite, ALUSrc, RegWrite, PCFunct, 
		BEQ, BNE, ControlJump, Halt, In, Out, EnableClock, JAL
);
	
	reg REGRegDst, REGMemRead, REGMemtoReg, REGMemWrite, REGALUSrc, 
		REGRegWrite, REGPCFunct, REGBEQ, REGBNE, REGControlJump, RegHalt,
		RegIn, RegOut, REGJAL;
	reg[2:0] REGAluOp;
	reg RegEnable;
	
	always @(*) 
	begin
		
		case(Opcode)  // Tipo R
			6'b000000: begin
				REGRegWrite <= 1;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 0;
				REGRegDst <= 0;
				REGPCFunct <= 1;
				REGAluOp <= 3'b010; // Verificaçao FUNCT
				REGBEQ <= 0;
				REGBNE <= 0;
				REGControlJump <= 0;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 0;
			end
			6'b100011: begin // LW
				REGRegWrite <= 1;
				REGMemRead <= 1;
				REGMemWrite <= 0;
				REGMemtoReg <= 1;
				REGALUSrc <= 1;
				REGRegDst <= 1;
				REGPCFunct <= 1;
				REGAluOp <= 3'b000; // SOMA
				REGBEQ <= 0;
				REGBNE <= 0;
				REGControlJump <= 0;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 0;
			end
			6'b101011: begin // SW
				REGRegWrite <= 1;
				REGMemRead <= 0;
				REGMemWrite <= 1;
				REGMemtoReg <= 1; // Don't Care
				REGALUSrc <= 1; 
				REGRegDst <= 1;
				REGPCFunct <= 1;
				REGAluOp <= 3'b000; // SOMA
				REGBEQ <= 0;
				REGBNE <= 0;
				REGControlJump <= 0;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 0;
			end
			6'b001000: begin // ADDI
				REGRegWrite <= 1;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 1;
				REGRegDst <= 1;
				REGPCFunct <= 1;
				REGAluOp <= 3'b000; // SOMA
				REGBEQ <= 0;
				REGBNE <= 0;
				REGControlJump <= 0;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 0;
			end				
			6'b001001: begin // SUBI
				REGRegWrite <= 1;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 1;
				REGRegDst <= 1;
				REGPCFunct <= 1;
				REGAluOp <= 3'b001; // SUB
				REGBEQ <= 0;
				REGBNE <= 0;
				REGControlJump <= 0;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 0;
			end	
			6'b001100: begin // ANDI
				REGRegWrite <= 1;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 1;
				REGRegDst <= 1;
				REGPCFunct <= 1;
				REGAluOp <= 3'b011; // AND
				REGBEQ <= 0;
				REGBNE <= 0;
				REGControlJump <= 0;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 0;
			end
			6'b001101: begin // ORI
				REGRegWrite <= 1;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 1;
				REGRegDst <= 1;
				REGPCFunct <= 1;
				REGAluOp <= 3'b100; // OR
				REGBEQ <= 0;
				REGBNE <= 0;
				REGControlJump <= 0;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 0;
			end
			6'b000100: begin // REGBEQ
				REGRegWrite <= 0;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 0;
				REGRegDst <= 0;
				REGPCFunct <= 1;	
				REGAluOp <= 3'b001; // SUB
				REGBEQ <= 1;
				REGBNE <= 0;
				REGControlJump <= 0;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 0;
			end
			6'b000101: begin // REGBNE
				REGRegWrite <= 0;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 0;
				REGRegDst <= 0;
				REGPCFunct <= 1;
				REGAluOp <= 3'b001; // SUB
				REGBEQ <= 0;
				REGBNE <= 1;
				REGControlJump <= 0;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 0;
			end
			6'b001010: begin // SLTI
				REGRegWrite <= 1;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 1;
				REGRegDst <= 1;
				REGPCFunct <= 1;
				REGAluOp <= 3'b101; // SLT
				REGBEQ <= 0;
				REGBNE <= 0;
				REGControlJump <= 0;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 0;
			end

			6'b011111: begin // IN
				REGRegWrite <= 1;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 0;
				REGRegDst <= 1;
				REGPCFunct <= 1;
				REGAluOp <= 3'b000; // SOMA
				REGBEQ <= 0;
				REGBNE <= 0;
				REGControlJump <= 0;
				RegHalt <= 0;
				RegIn <= 1; 
				RegOut <= 1;
				RegEnable <= 0;
				REGJAL <= 0;
			end
			
			6'b011110: begin // Out
				REGRegWrite <= 0;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 0;
				REGRegDst <= 0;
				REGPCFunct <= 1;
				REGAluOp <= 3'b000; // SOMA
				REGBEQ <= 0;
				REGBNE <= 0;
				REGControlJump <= 0;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 1;
				RegEnable <= 1;
				REGJAL <= 0;
			end	
			
			6'b000010: begin // Jump
				REGRegWrite <= 0;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 0;
				REGRegDst <= 0;
				REGPCFunct <= 1;
				REGAluOp <= 3'b000; // SOMA
				REGBEQ <= 0;
				REGBNE <= 0;
				REGControlJump <= 1;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 0;
			end	
			
			6'b000011: begin // JAL
				REGRegWrite <= 1;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 0;
				REGRegDst <= 0;
				REGPCFunct <= 1;
				REGAluOp <= 3'b000; // SOMA	
				REGBEQ <= 0;		
				REGBNE <= 0;
				REGControlJump <= 1;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 1;
			end	
			
			6'b111111: begin //Halt
				REGRegWrite <= 0;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 0;
				REGRegDst <= 0;
				REGPCFunct <= 0;
				REGAluOp <= 3'b000; // SOMA	
				REGBEQ <= 0;		
				REGBNE <= 0;
				REGControlJump <= 0;
				RegHalt <= 1;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 0;
			end
			
			6'b101101: begin // XORI
				REGRegWrite <= 1;
				REGMemRead <= 0;
				REGMemWrite <= 0;
				REGMemtoReg <= 0;
				REGALUSrc <= 1;
				REGRegDst <= 1;
				REGPCFunct <= 1;
				REGAluOp <= 3'b110; // XOR
				REGBEQ <= 0;
				REGBNE <= 0;
				REGControlJump <= 0;
				RegHalt <= 0;
				RegIn <= 0; 
				RegOut <= 0;
				RegEnable <= 1;
				REGJAL <= 0;
			end
		endcase
	end
	
	
	assign JAL = REGJAL;
	assign EnableClock = RegEnable;
	assign Halt = RegHalt;
	assign RegDst = REGRegDst;
	assign MemRead = REGMemRead;
	assign MemtoReg = REGMemtoReg;
	assign MemWrite = REGMemWrite;
	assign ALUSrc = REGALUSrc; 
	assign RegWrite = REGRegWrite;
	assign PCFunct = REGPCFunct;
	assign AluOp = REGAluOp;
	assign BEQ = REGBEQ;
	assign BNE = REGBNE;
	assign ControlJump = REGControlJump;
	assign In = RegIn;
	assign Out = RegOut;
	
endmodule 