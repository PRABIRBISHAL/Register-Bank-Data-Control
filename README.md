# Register Bank Data Control Unit using Verilog HDL

## Overview

This project implements a **4 × 8-bit Register Bank** in **Verilog HDL** with a **4×16 decoder-based control unit** for selective register operations. The design supports synchronous register write, decoder-controlled register selection, and register-to-register data transfer, making it suitable for learning RTL design and FPGA-based digital systems.

---

## Features

- 4 × 8-bit Register Bank
- 4×16 Decoder for Register Selection
- Synchronous Data Storage
- Register Read and Write Operations
- Register-to-Register Data Transfer
- Combinational and Sequential RTL Design
- Functional Verification using Testbench
- Vivado Compatible Design
- XDC Timing Constraints Included

---

## Project Architecture

```
                  +----------------+
                  | 4×16 Decoder   |
                  +-------+--------+
                          |
          ---------------------------------
          |        |        |            |
      Register A Register B Register C Register D
          |        |        |            |
          -------- Register Bank ---------
                     |
               Data Output
```

---

## Project Structure

```
Register-Bank-Data-Control/
│
├── src/
│   ├── reg_bank.v
│
├── tb/
│   └── reg_bank_tb.v
│
├── constraints/
│   └── reg_bank.xdc
│
├── simulation/
│    └── screenshot(252).png
|    └── screenshot(253).png
|    └── screenshot(254).png
|    └── screenshot(255).png
|    └── screenshot(256).png
│
├── README.md
└── LICENSE
```

---

## Module Description

### 1. decoder_4X16

- Converts a 4-bit control signal into a one-hot 16-bit output.
- Selects the required register operation.

### 2. register_8_bit

- Implements an 8-bit synchronous register.
- Supports reset and load functionality.

### 3. reg_bank

- Integrates four 8-bit registers.
- Performs:
  - Register write
  - Register read
  - Register-to-register transfer
- Uses decoder outputs to control register selection.

### 4. Testbench

- Verifies:
  - Register initialization
  - Data write operations
  - Register transfers
  - Reset functionality
  - Output correctness

---

## Register Operations

| Control Code | Operation |
|--------------|-----------|
| 0000 | Write to Register A |
| 0100 | Write to Register B |
| 1000 | Write to Register C |
| 1100 | Write to Register D |
| Others | Register-to-Register Data Transfer |

---

## Tools Used

- Verilog HDL
- Xilinx Vivado
- XSIM Simulator
- Git
- GitHub

---

## Simulation

The design was verified using a custom Verilog testbench covering:

- Register Write
- Register Read
- Register Transfer
- Reset
- Decoder Functionality

---

## Learning Outcomes

This project helped strengthen understanding of:

- RTL Design
- Register Bank Architecture
- Decoder Design
- Sequential Logic
- Combinational Logic
- FPGA Design Flow
- Testbench Development
- Timing Constraints (XDC)
- Hardware Verification

---

## Future Improvements

- Parameterized Register Width
- Dual-Port Register File
- Independent Read/Write Ports
- Addressable Register File
- FPGA Hardware Validation
- SystemVerilog Assertions

---

## Author

**Prabir Bishal**
Contact me - prabirbishal2005@gmail.com


## License

This project is released under the MIT License.
