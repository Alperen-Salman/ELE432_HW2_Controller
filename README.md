# ELE432_HW2_Controller
Multicycle RISC-V Controller for Homework 2

# Multicycle RISC-V Processor Controller

### Overview
[cite_start]This repository contains a hierarchical **SystemVerilog** implementation of a multicycle controller for a **RISC-V processor**[cite: 4, 350]. [cite_start]The project focuses on the design and verification of the control unit, which manages the datapath through various execution stages using a **Finite State Machine (FSM)**[cite: 6, 12, 197].

### Supported Instructions
[cite_start]The controller is designed to support a fundamental subset of the RISC-V instruction set architecture (ISA), including[cite: 293]:
* [cite_start]**Memory Access**: `lw` (Load Word), `sw` (Store Word) [cite: 135-137].
* [cite_start]**R-type Arithmetic**: `add`, `sub`, `and`, `or`, `slt` [cite: 143-144, 293].
* [cite_start]**I-type Arithmetic**: `addi` [cite: 145-146, 294].
* [cite_start]**Branching & Jumps**: `beq` (Branch if Equal), `jal` (Jump and Link) [cite: 149-150, 155-157].

---

### Project Hierarchy
[cite_start]The design follows a modular structure to ensure clarity and ease of debugging [cite: 15-16, 358-360]:

| Module | Description |
| :--- | :--- |
| **`controller.sv`** | [cite_start]The top-level module connecting the FSM and Decoders [cite: 361-362]. |
| **`mainfsm.sv`** | [cite_start]The 11-state Main FSM governing the execution cycles [cite: 392, 405-408]. |
| **`aludec.sv`** | [cite_start]Decodes the `ALUOp` and instruction bits for ALU control [cite: 201, 489-490]. |
| **`instrdec.sv`** | [cite_start]Decodes the opcode to determine the immediate source (`ImmSrc`) [cite: 245, 511-512]. |

---

### Simulation and Verification
[cite_start]Verification was performed using **Questa Sim** (ModelSim) with the provided testbench and vector file (`controller.tv`) [cite: 48-50, 69].

* [cite_start]**Testbench**: `testbench.sv`[cite: 266].
* [cite_start]**Test Vectors**: Covers all supported instructions through multiple clock cycles [cite: 293-295].
* **Target Hardware**: Designed for synthesis on the **Intel Cyclone V (DE1-SoC)** FPGA board.

---

### How to Run
1. Open **Quartus Prime** and create a project targeting the **5CSEMA5F31C6** (DE1-SoC) device.
2. [cite_start]Add all `.sv` source files to the project[cite: 97, 357].
3. [cite_start]Launch **Questa Sim** and compile the source files along with the testbench [cite: 64-65].
4. [cite_start]Load the simulation using `vsim -voptargs=+acc testbench` to ensure signal visibility[cite: 72, 88].
5. [cite_start]Run the simulation for at least **500 ns** to verify all test vectors[cite: 79].

---

### Acknowledgments
[cite_start]This project was completed as part of the **ELE432: Digital Design and Computer Architecture** coursework[cite: 350]. [cite_start]Special thanks to the laboratory instructors for providing the test materials[cite: 266, 293].
