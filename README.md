# 8Bit-LittleEndian-CPU
This is an implementation of a simple 8-bit CPU.

# Verilog Final Project (End-Term Project for Logic Circuits)

## **Phase 1**

In this phase, I implemented a pseudo-processor with a **Little Endian** architecture that executes instructions in each clock cycle. The processor reads an 8-bit instruction in **two’s complement** format, computes the result, and places the 16-bit output along with relevant flags.

### **Details:**
- The processor executes instructions stored in a file named **"instructions.txt"** with a maximum of **24 instructions**.
- After executing each arithmetic instruction, the processor sets two flags:
  - **ZF (Zero Flag):** Set if the result is zero.
  - **SF (Sign Flag):** Set if the result is negative (1 for negative, 0 for positive).
- The processor has **four 8-bit registers**: **Ra, Rb, Rc, Rd**, each identified by an 8-bit ID.

### **Instruction Format**
Each instruction consists of three parts:
1. **Opcode:** A 4-bit code that determines the operation.
2. **Operand 1:** Identifies the register where the result is stored (bits 9-16).
3. **Operand 2:** Can be another register ID or an 8-bit signed integer (bits 1-8).

### **Register Identifiers**

| Register Name | Register ID |
|--------------|------------|
| Ra           | 00000001   |
| Rb           | 00000010   |
| Rc           | 00000100   |
| Rd           | 00001000   |

### **Instruction Set**

| Instruction | Format | Operation |
|------------|--------|-----------|
| Load reg, op | `0001 _regId_operand` | Store value `op` in register |
| Load reg1, reg2 | `0010 _regId1_regId2` | Store value of `reg2` in `reg1` |
| Add reg, op | `0011 _regId_operand` | Add `op` to register value and store result |
| Add reg1, reg2 | `0100 _regId1_regId2` | Add values of `reg1` and `reg2`, store result in `reg1` |
| Sub reg, op | `0101 _regId_operand` | Subtract `op` from register value |
| Sub reg1, reg2 | `0110 _regId1_regId2` | Subtract `reg2` from `reg1`, store result in `reg1` |
| Mult reg, op | `0111 _regId_operand` | Multiply register value by `op`, store high bits in `Rd`, low bits in `Ra` |
| Mult reg1, reg2 | `1000 _regId1_regId2` | Multiply `reg1` and `reg2`, store high bits in `Rd`, low bits in `Ra` |
| Shr reg, op | `1011 _regId_operand` | Shift right `reg` by `op` bits |
| Shl reg, op | `1100 _regId_operand` | Shift left `reg` by `op` bits |

### **Example Instructions**
| Operation | Encoded Instruction |
|-----------|---------------------|
| Load Ra, 2 | `0001 _00000001 _00000010` |
| Add Ra, 15 | `0011 _00000001 _00001111` |
| Load Rb, 8 | `0001 _00000010 _00001000` |
| Load Rc, 4 | `0001 _00000100 _00000100` |
| Sub Rb, Rc | `0110 _00000010 _00000100` |
| Mult Rb, 5 | `0111 _00000010 _00000101` |
| Load Ra, 7 | `0001 _00000001 _00000111` |
| Shl Ra, 3 | `1100 _00000001 _00000011` |

## **Phase 2**

A key feature of processors is the ability to perform **floating-point calculations**. One widely used standard for floating-point representation is **IEEE 754**, which supports **16-bit, 32-bit, and 64-bit** formats. While IEEE 754 provides high precision, it slows down computations, particularly for **machine learning and neural networks**. To address this issue, Google introduced the **bfloat16** format, similar to **IEEE 754 single-precision** but with:
- A **7-bit mantissa** instead of 23 bits
- A **wider exponent range** to cover a broad range of numbers while maintaining reasonable accuracy

### **Implementation of the `bfloatConvert` Instruction**
This instruction takes two 8-bit operands:
- **Operand 1:** Integer part (signed)
- **Operand 2:** Fractional part (unsigned)

The processor:
1. Computes the **sign, exponent, and mantissa**
2. Stores the **exponent** in **Rc**
3. Stores the **sign** and **mantissa** in **Rb**
4. Outputs the final **bfloat16** representation

### **Instruction Format**
| Instruction | Format |
|------------|--------|
| bfloatConvert whole, fraction | `1101_ whole_ fraction` |

### **Example: Convert 5.2 to bfloat16**
| Step | Value |
|------|--------|
| Input instruction | `1101_ 00000101_ 00000010` |
| Processor output | `0100000010100110` |
