module mainfsm (
    input  logic       clk, reset,
    input  logic [6:0] op,
    output logic [1:0] alusrca, alusrcb,
    output logic [1:0] resultsrc,
    output logic       adrsrc,
    output logic       irwrite, regwrite, memwrite,
    output logic [1:0] aluop,
    output logic       branch, pcupdate
);

    // Define states S0 through S10 as per the assignment diagram
    typedef enum logic [3:0] {
        S0_Fetch, S1_Decode, S2_MemAdr, S3_MemRead, 
        S4_MemWB, S5_MemWrite, S6_ExecuteR, S7_ALUWB, 
        S8_ExecuteI, S9_JAL, S10_BEQ
    } state_t;

    state_t state, nextstate;

    // Sequential logic: Updates the state on each clock edge
    always_ff @(posedge clk or posedge reset)
        if (reset) state <= S0_Fetch;
        else       state <= nextstate;

    // Combinational logic: Defines transitions and signal outputs
    always_comb begin
        //Set all outputs to 0 by default for "Don't Care" states to simplify testing 
        {alusrca, alusrcb, resultsrc, adrsrc, irwrite, regwrite, memwrite, aluop, branch, pcupdate} = 14'b0;

        case (state)
            S0_Fetch: begin
                adrsrc = 1'b0; irwrite = 1'b1; alusrca = 2'b00; alusrcb = 2'b10;
                aluop = 2'b00; resultsrc = 2'b10; pcupdate = 1'b1;
                nextstate = S1_Decode;
            end

            S1_Decode: begin
                alusrca = 2'b01; alusrcb = 2'b01; aluop = 2'b00;
                case (op)
                    7'b0000011, 7'b0100011: nextstate = S2_MemAdr;   // lw, sw
                    7'b0110011:             nextstate = S6_ExecuteR; // R-type
                    7'b0010011:             nextstate = S8_ExecuteI; // I-type ALU
                    7'b1101111:             nextstate = S9_JAL;      // jal
                    7'b1100011:             nextstate = S10_BEQ;     // beq
                    default:                nextstate = S0_Fetch;
                endcase
            end

            S2_MemAdr: begin
                alusrca = 2'b10; alusrcb = 2'b01; aluop = 2'b00;
                if (op == 7'b0000011) nextstate = S3_MemRead;
                else                  nextstate = S5_MemWrite;
            end

            S3_MemRead: begin
                resultsrc = 2'b00; adrsrc = 1'b1;
                nextstate = S4_MemWB;
            end

            S4_MemWB: begin
                resultsrc = 2'b01; regwrite = 1'b1;
                nextstate = S0_Fetch;
            end

            S5_MemWrite: begin
                resultsrc = 2'b00; adrsrc = 1'b1; memwrite = 1'b1;
                nextstate = S0_Fetch;
            end

            S6_ExecuteR: begin
                alusrca = 2'b10; alusrcb = 2'b00; aluop = 2'b10;
                nextstate = S7_ALUWB;
            end

            S7_ALUWB: begin
                resultsrc = 2'b00; regwrite = 1'b1;
                nextstate = S0_Fetch;
            end

            S8_ExecuteI: begin
                alusrca = 2'b10; alusrcb = 2'b01; aluop = 2'b10;
                nextstate = S7_ALUWB;
            end

            S9_JAL: begin
                alusrca = 2'b01; alusrcb = 2'b10; aluop = 2'b00; 
                resultsrc = 2'b00; pcupdate = 1'b1;
                nextstate = S7_ALUWB;
            end

            S10_BEQ: begin
                alusrca = 2'b10; alusrcb = 2'b00; aluop = 2'b01; 
                resultsrc = 2'b00; branch = 1'b1; 
                nextstate = S0_Fetch;
            end

            default: nextstate = S0_Fetch;
        endcase
    end
endmodule