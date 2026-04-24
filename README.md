# ELE432_HW2_Controller
Multicycle RISC-V Controller for Homework 2

# Multicycle RISC-V Processor Controller

### Overview
This repository contains a hierarchical **SystemVerilog** implementation of a multicycle controller for a **RISC-V processor**. The project focuses on the design and verification of the control unit, which manages the datapath through various execution stages using a **Finite State Machine (FSM)**.

### Supported Instructions
The controller is designed to support a fundamental subset of the RISC-V instruction set architecture (ISA), including:
* **Memory Access**: `lw` (Load Word), `sw` (Store Word).
* **R-type Arithmetic**: `add`, `sub`, `and`, `or`, `slt`.
* **I-type Arithmetic**: `addi`.
* **Branching & Jumps**: `beq` (Branch if Equal), `jal` (Jump and Link).

---

### Project Hierarchy
The design follows a modular structure to ensure clarity and ease of debugging:

| Module | Description |
| :--- | :--- |
| **`controller.sv`** | The top-level module connecting the FSM and Decoders. |
| **`mainfsm.sv`** | The 11-state Main FSM governing the execution cycles. |
| **`aludec.sv`** | Decodes the `ALUOp` and instruction bits for ALU control. |
| **`instrdec.sv`** | Decodes the opcode to determine the immediate source (`ImmSrc`). |

---

### Simulation and Verification
Verification was performed using **Questa Sim** (ModelSim) with the provided testbench and vector file (`controller.tv`).

* **Testbench**: `testbench.sv`.
* **Test Vectors**: Covers all supported instructions through multiple clock cycles.
* **Target Hardware**: Designed for synthesis on the **Intel Cyclone V (DE1-SoC)** FPGA board.

---

### How to Run
1. Open **Quartus Prime** and create a project targeting the **5CSEMA5F31C6** (DE1-SoC) device.
2. Add all `.sv` source files to the project.
3. Launch **Questa Sim** and compile the source files along with the testbench.
4. Load the simulation using `vsim -voptargs=+acc testbench` to ensure signal visibility.
5. Run the simulation for at least **500 ns** to verify all test vectors.

---

### Acknowledgments
This project was completed as part of the **ELE432: Digital Design and Computer Architecture** coursework. Special thanks to the laboratory instructors for providing the test materials.
