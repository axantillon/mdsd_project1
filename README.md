# Custom 8-bit Processor Implementation

## Project Overview

This project implements a custom 8-bit processor designed for the Basys3 FPGA board as part of the ECE 2372 course. The processor features a custom instruction set architecture (ISA) and is implemented in Verilog with support for various arithmetic, logical, and control operations.

## Team Members

- Diego Bonilla
- Enrique Macaya
- Sebastian Lopez
- Andres Antillon

## Project Structure

The project is composed of several Verilog modules, each responsible for a specific part of the processor:

1. `alu.v`: Arithmetic Logic Unit supporting operations like add, negate, AND, OR, and comparisons
2. `register.v`: 16x8-bit register file with special monitoring of R15
3. `datapath.v`: Main datapath connecting ALU, registers, and multiplexers
4. `instructionDecoder.v`: Decodes 16-bit instructions and generates control signals
5. `instructionMemory.v`: Stores program instructions with support for multiple programs
6. `utils.v`: Utility modules for button debouncing, clock division, and 7-segment display

## Features

- 8-bit data path with 16-bit instructions
- 16 general-purpose registers (R0-R15, with R15 displayed on 7-segment display)
- Multiple built-in programs selectable via switches
- Real-time output display on 7-segment display
- Hardware debouncing for reliable button input
- Configurable clock speeds for testing and demonstration

## Getting Started

### Prerequisites

- Xilinx Vivado for Basys3 board programming
- Basys3 FPGA board
- Basic understanding of digital logic and Verilog HDL

### Hardware Setup

1. Connect the Basys3 board to your computer
2. Program the constraints file:

```verilog:constraints/basys3.xdc
startLine: 1
endLine: 161
```

### Running Programs

1. Use the rightmost 8 switches to select the program (priority encoded)
2. Use the leftmost 8 switches for external input data
3. Press the reset button to start program execution
4. View results on the 7-segment display (shows R15 value)

## Instruction Set Architecture

The processor uses 16-bit instructions with the following format:
- [15:12] - OpCode (4 bits)
- [11:8]  - Destination Register
- [7:4]   - Operand 2 (Value/Register)
- [3:0]   - Operand 3 (Value/Register)

Supported operations include:
- Arithmetic: ADD, Negate
- Logical: AND, OR
- Data Movement: Copy, Set Constant
- Control: Conditional/Unconditional Halt
- Comparison: Equals, Greater Than
- Shifts: Left, Right

## Testing

The project includes comprehensive testbenches for each module:
- `alu_testbench.v`: Tests all ALU operations
- `register_testbench.v`: Verifies register file functionality
- `datapath_testbench.v`: Tests complete datapath operations

## Contributing

This project is part of an academic course. If you have any suggestions or improvements, please contact the team members.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

- ECE 2372 course instructors and teaching assistants
- Digilent for Basys3 documentation and resources

