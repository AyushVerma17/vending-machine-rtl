# Vending Machine RTL Design

## Overview

This project implements a simple vending machine digital logic design using Verilog HDL. The vending machine accepts nickels (5¢) and dimes (10¢) as inputs and dispenses an item when the accumulated amount reaches or exceeds 15 cents.

## Author

**Ayush Verma**

## Table of Contents

- [Project Description](#project-description)
- [Files in the Repository](#files-in-the-repository)
- [Finite State Machine Design](#finite-state-machine-design)
- [State Transition Table](#state-transition-table)
- [How to Run](#how-to-run)
- [Simulation Results](#simulation-results)

## Project Description

This vending machine is designed as a Mealy finite state machine with four states representing the accumulated amount:

- `zero`: No money inserted (0¢)
- `five`: 5¢ inserted
- `ten`: 10¢ inserted
- `fifteen`: 15¢ or more inserted (item dispensed)

The machine accepts two types of coins:

- Nickel (N): Worth 5¢
- Dime (D): Worth 10¢

When the accumulated amount reaches or exceeds 15¢, the machine opens the dispenser door (output `open` becomes HIGH).

## Files in the Repository

1. `vending_machine.v` - Main module implementing the vending machine logic
2. `vending_machine_tb.v` - Testbench to validate the functionality of the design
3. `rtl_view.png` - RTL schematic view of the synthesized design
4. `README.md` - This documentation file

## Finite State Machine Design

The vending machine is implemented as a four-state FSM:

- The machine starts in the `zero` state (0¢)
- When a nickel is inserted, it transitions to the `five` state (5¢)
- When a dime is inserted, it transitions to the `ten` state (10¢)
- From `five`, another nickel transitions to `ten` (10¢) and a dime to `fifteen` (15¢)
- From `ten`, either a nickel or dime transitions to `fifteen` (15¢ or 20¢)
- Once in the `fifteen` state, the machine stays there (dispenser open)
- A reset signal returns the machine to the `zero` state

## State Transition Table

| Current State | Input (N,D) | Next State | Output (open) |
| ------------- | ----------- | ---------- | ------------- |
| zero (00)     | 0,0         | zero       | 0             |
| zero (00)     | 1,0         | five       | 0             |
| zero (00)     | 0,1         | ten        | 0             |
| five (01)     | 0,0         | five       | 0             |
| five (01)     | 1,0         | ten        | 0             |
| five (01)     | 0,1         | fifteen    | 1             |
| ten (10)      | 0,0         | ten        | 0             |
| ten (10)      | 1,0         | fifteen    | 1             |
| ten (10)      | 0,1         | fifteen    | 1             |
| fifteen (11)  | X,X         | fifteen    | 1             |

## How to Run

To simulate this design, you'll need a Verilog simulator like ModelSim, Icarus Verilog, or VCS.

### Using Icarus Verilog:

```bash
# Compile the design and testbench
iverilog -o vending_machine_sim vending_machine.v vending_machine_tb.v

# Run the simulation
vvp vending_machine_sim

# View waveforms (if you have GTKWave installed)
gtkwave vending_machine.vcd
```

### Using ModelSim:

```tcl
# Compile the design
vlog vending_machine.v vending_machine_tb.v

# Start simulation
vsim -novopt work.vending_machine_tb

# Add signals to waveform
add wave /vending_machine_tb/*

# Run the simulation
run -all
```

## Simulation Results

The testbench validates the following scenarios:

1. Inserting a nickel followed by a dime (5¢ + 10¢ = 15¢)
2. Inserting three nickels (5¢ + 5¢ + 5¢ = 15¢)
3. Inserting a dime followed by a nickel (10¢ + 5¢ = 15¢)
4. Inserting two dimes (10¢ + 10¢ = 20¢, exceeding the required amount)

All test cases should result in the vending machine opening (output `open` = 1).

---
