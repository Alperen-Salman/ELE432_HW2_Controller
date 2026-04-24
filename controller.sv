module controller (
    input  logic       clk, reset,
    input  logic [6:0] op,
    input  logic [2:0] funct3,
    input  logic       funct7b5,
    input  logic       zero,
    output logic [1:0] immsrc,
    output logic [1:0] alusrca, alusrcb,
    output logic [1:0] resultsrc,
    output logic       adrsrc,
    output logic [2:0] alucontrol,
    output logic       irwrite, pcwrite,
    output logic       regwrite, memwrite
);
    logic [1:0] aluop;
    logic branch, pcupdate;

    // Instantiate Main FSM
    mainfsm fsm (clk, reset, op, alusrca, alusrcb, resultsrc, adrsrc, 
                 irwrite, regwrite, memwrite, aluop, branch, pcupdate);

    // Instantiate ALU Decoder
    aludec ad (op[5], funct3, funct7b5, aluop, alucontrol);

    // Instantiate Instruction Decoder
    instrdec id (op, immsrc);

    // Combinational logic for PCWrite 
    assign pcwrite = (branch & zero) | pcupdate;

endmodule