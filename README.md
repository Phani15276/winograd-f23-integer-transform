# Winograd F(2,3) Algorithm — From 1D Transform to 2D Transform Using Integer Inputs

## Overview
This project implements and verifies the Winograd F(2,3) convolution algorithm using integer arithmetic in Verilog and ModelSim.

The project starts with 1D Winograd transform implementation and extends toward 2D convolution comparison.

---

## Folder Structure

### src/
Contains the main Verilog implementation files.

### src_1d/
Contains 1D Winograd transform related Verilog modules.

### tb/
Contains testbench files for convolution comparison and verification.

### tb_1d/
Contains testbench files for 1D Winograd verification.

---

## Implemented Concepts
- 1D Winograd Transform
- Normal Convolution vs Winograd Convolution
- Integer-based computation
- Input Transform
- Output Transform
- Verilog simulation using ModelSim

---

## Circuit / Datapath Description
The design performs Winograd-based convolution using transform equations instead of direct matrix multiplication.

The datapath mainly consists of:
- Adders
- Subtractors
- Intermediate transform stages
- Element-wise multiplication stage

The implementation avoids fractional arithmetic and uses integer inputs for simplified simulation.

---

## Tools Used
- Verilog HDL
- ModelSim

---

## Author
Phanidhar
