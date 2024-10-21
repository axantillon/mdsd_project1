# MIPS Single-Cycle Processor

## Project Overview

This project implements a MIPS Single-Cycle Processor as part of the ECE 2372 course. The processor is designed using Verilog and consists of various components that work together to execute MIPS instructions in a single clock cycle.

## Team Members

- Diego Bonilla
- Enrique Macaya
- Sebastian Lopez
- Andres Antillon

## Project Structure

The project is composed of several Verilog modules, each responsible for a specific part of the processor:

1. `register.v`: Implements the register file
2. `datapath.v`: Contains the main datapath of the processor
3. `alu.v`: Arithmetic Logic Unit for performing operations

## Features

- Single-cycle MIPS processor implementation
- Supports basic MIPS instructions
- Modular design for easy understanding and modification

## Getting Started

### Prerequisites

- Verilog-compatible simulator (e.g., ModelSim, Icarus Verilog)
- Basic understanding of MIPS architecture and Verilog HDL

### Running the Simulation

1. Clone this repository to your local machine
2. Open your Verilog simulator
3. Add all the `.v` files to your project
4. Run the simulation using the testbench file (not provided in the current context)

## File Descriptions

### register.v

This file contains the implementation of the register file used in the MIPS processor.

### datapath.v

The datapath module connects various components of the processor and handles the flow of data between them.

### alu.v

The Arithmetic Logic Unit (ALU) performs various operations required by the MIPS instruction set.

## Contributing

This project is part of an academic course. If you have any suggestions or improvements, please contact the team members.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

- ECE 2372 course instructors and teaching assistants
- MIPS architecture documentation and resources

