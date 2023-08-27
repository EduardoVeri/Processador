
module MemoriaDados
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=10)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input we, re, clk,
	output reg [(DATA_WIDTH-1):0] q
);
	
/*
	Declaração do vetor de registradores que irá
	armazenar os dados na memória.
*/	
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	
	integer primeiro = 1;
	
	always @ (posedge clk)
	begin
	
		if(primeiro == 1) begin
		/*
			Nesse campo podem ser adicionados valores que
			já iniciarão na memória principal quando o 
			programa for iniciado
		*/
			// Valores para teste em forma de onda
			ram[10'd0] <= 32'd0;
			ram[10'd1] <= 32'd0;
			ram[10'd2] <= 32'd0;
			ram[10'd3] <= 32'd0;
			ram[10'd4] <= 32'd1000;
			ram[10'd5] <= 32'd0;
			ram[10'd6] <= 32'd0;
			primeiro <= 2;
		end
		
		// Escrita
		if (we && primeiro != 1)
			ram[addr] <= data;
	end
	
	always @ (negedge clk)
	begin
		// Leitura
		if (re)
			q <= ram[addr];
	end
	
endmodule

