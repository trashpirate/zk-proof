# 🔐 Zero-Knowledge Bootcamp

<div align="center">

[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.24-orange.svg)](https://soliditylang.org/)
[![Foundry](https://img.shields.io/badge/Foundry-Latest-red.svg)](https://getfoundry.sh/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

*A comprehensive journey through Zero-Knowledge Proofs, from fundamentals to advanced cryptographic protocols*

[RareSkills](https://www.rareskills.io/) | [Documentation](https://almondine-song-c43.notion.site/)

</div>

---

## 📚 About

This repository contains a complete collection of homework assignments and implementations from the RareSkills Zero-Knowledge Bootcamp. The bootcamp provides a deep dive into the mathematical foundations and practical implementations of zero-knowledge proof systems, covering everything from finite field arithmetic to advanced zkSNARK protocols.

## 🎯 Learning Objectives

- **Mathematical Foundations**: Master finite field arithmetic, polynomial operations, and elliptic curve cryptography
- **R1CS & QAP**: Understand Rank-1 Constraint Systems and Quadratic Arithmetic Programs
- **zkSNARKs**: Implement Groth16 and other proof systems from scratch
- **Cryptographic Protocols**: Build verifiable computation systems using Python and Solidity
- **Practical Applications**: Deploy and verify zero-knowledge proofs on Ethereum

## 📖 Course Structure

### 🌟 Preparation
- **[zk-bootcamp-prep](./zk-bootcamp-prep/)**: Python warmup exercises with NumPy and matrix operations

### 📐 Fundamentals (Weeks 1-4)
- **[Homework 1](./zk-bootcamp-hw-1/)**: Finite Field Arithmetic
  - Modular arithmetic operations
  - Field element computations
  - Division and inverses in finite fields

- **[Homework 2](./zk-bootcamp-hw-2/)**: Advanced Finite Field Operations
  - Extended field operations
  - Computational complexity
  - Practical applications

- **[Homework 3](./zk-bootcamp-hw-3/)**: Polynomial Arithmetic
  - Lagrange interpolation
  - Polynomial operations in finite fields
  - Roots and evaluations

- **[Homework 4](./zk-bootcamp-hw-4/)**: Elliptic Curve Cryptography
  - Point operations on elliptic curves
  - Scalar multiplication
  - Group theory applications

### 🔧 Smart Contracts & Cryptography (Weeks 5-6)
- **[Homework 5](./zk-bootcamp-hw-5/)**: Solidity & Elliptic Curve Pairings ⚡
  - Foundry project structure
  - BN128 pairing operations
  - On-chain cryptographic verifications

- **[Homework 6](./zk-bootcamp-hw-6/)**: Advanced Pairing Operations ⚡
  - Bilinear pairings
  - Trusted setup concepts
  - Cryptographic protocols in Solidity

### 🏗️ Constraint Systems (Weeks 7-9)
- **[Homework 7](./zk-bootcamp-hw-7/)**: R1CS (Rank-1 Constraint Systems)
  - Circuit design and constraints
  - Witness generation
  - Graph coloring problems

- **[Homework 8](./zk-bootcamp-hw-8/)**: Quadratic Arithmetic Programs (QAP)
  - Converting R1CS to QAP
  - Polynomial representations
  - Zero-knowledge transformations

- **[Homework 9](./zk-bootcamp-hw-9/)**: Advanced QAP
  - Multi-constraint systems
  - Optimization techniques
  - Proof generation pipelines

### 🚀 zkSNARK Protocols (Weeks 10-12)
- **[Homework 10](./zk-bootcamp-hw-10/)**: Pinocchio Protocol
  - Structured Reference Strings (SRS)
  - Verifiable computation
  - Polynomial commitments

- **[Homework 11](./zk-bootcamp-hw-11/)**: Groth16 Implementation (Part 1)
  - Trusted setup ceremony
  - Proof generation
  - Optimization techniques

- **[Homework 12](./zk-bootcamp-hw-12/)**: Groth16 Implementation (Part 2) ⭐
  - Complete Groth16 prover
  - Efficient verification
  - Public vs private inputs

## 🛠️ Technology Stack

<table>
<tr>
<td width="50%">

### Python
- **NumPy**: Matrix operations and numerical computing
- **Galois**: Finite field arithmetic and polynomials
- **py_ecc**: Elliptic curve operations (BN128)
- **Jupyter**: Interactive development and visualization

</td>
<td width="50%">

### Solidity & Foundry
- **Solidity 0.8.24**: Smart contract development
- **Foundry**: Testing and deployment framework
- **forge-std**: Standard library for testing
- **Ethereum precompiles**: On-chain pairing checks

</td>
</tr>
</table>

## 🚀 Getting Started

### Prerequisites

```bash
# Python 3.8 or higher
python3 --version

# Foundry (for Solidity homeworks)
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/zk-bootcamp.git
   cd zk-bootcamp
   ```

2. **Set up Python environment**
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install Python dependencies**
   ```bash
   pip install numpy galois py_ecc jupyter
   ```

4. **For Solidity projects (hw-5, hw-6)**
   ```bash
   cd zk-bootcamp-hw-5
   forge install
   forge build
   forge test
   ```

### Running Notebooks

```bash
jupyter notebook
# Navigate to any homework folder and open the .ipynb file
```

## 📂 Project Structure

```
zk-bootcamp/
│
├── 📓 zk-bootcamp-prep/           # Python warmup exercises
│   └── python-problems.ipynb
│
├── 📁 zk-bootcamp-hw-1/           # Finite field basics
│   └── zk-bootcamp-hw-1.ipynb
│
├── 📁 zk-bootcamp-hw-2/           # Advanced field operations
│   └── zk-bootcamp-hw-2.ipynb
│
├── ...                            # Homeworks 3-4
│
├── ⚡ zk-bootcamp-hw-5/           # Solidity + Foundry
│   ├── src/Zk.sol
│   ├── test/Zk.t.sol
│   ├── foundry.toml
│   └── zk-bootcamp-hw-5.ipynb
│
├── ...                            # Homeworks 6-11
│
└── ⭐ zk-bootcamp-hw-12/          # Complete Groth16
    └── zk-bootcamp-hw-12.ipynb
```

## 🔑 Key Concepts Covered

### Mathematical Foundations
- **Finite Fields (F_p)**: Arithmetic in prime order fields
- **Polynomials**: Lagrange interpolation, division with remainders
- **Elliptic Curves**: BN128 curve operations and pairings
- **Bilinear Maps**: e(aP, bQ) = e(P, Q)^(ab)

### Proof Systems
- **R1CS**: A • B = C (rank-1 constraint systems)
- **QAP**: Polynomial encoding of arithmetic circuits
- **zkSNARKs**: Succinct non-interactive arguments of knowledge
- **Groth16**: State-of-the-art zkSNARK protocol

### Implementation Techniques
- **Witness Generation**: Computing intermediate values
- **Trusted Setup**: SRS generation with toxic waste
- **Proof Generation**: Creating cryptographic proofs
- **Verification**: Efficient on-chain and off-chain verification

## 📝 Example: Groth16 Prover

```python
from py_ecc.bn128 import G1, G2, pairing
import galois
import numpy as np

# Define R1CS matrices (A, B, C)
# Generate witness vector
# Perform Lagrange interpolation
# Compute QAP polynomials
# Generate proof components (A, B, C)
# Verify with pairing check: e(A,B) = e(α,β) • e(γ,X) • e(δ,C)
```

## 🧪 Testing

### Python Tests
```bash
# Run individual notebooks
jupyter notebook zk-bootcamp-hw-12/zk-bootcamp-hw-12.ipynb
```

### Solidity Tests
```bash
cd zk-bootcamp-hw-5
forge test -vvv
```

## 📚 Resources

- [RareSkills ZK Bootcamp](https://www.rareskills.io/)
- [Why and How zkSNARK Works](https://arxiv.org/abs/1906.07221)
- [Groth16 Paper](https://eprint.iacr.org/2016/260.pdf)
- [BN128 Curve Specification](https://hackmd.io/@jpw/bn254)

## 🤝 Contributing

This is a personal learning repository, but feel free to:
- Report issues or bugs
- Suggest improvements
- Share alternative implementations
- Ask questions through issues

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **RareSkills** for creating this comprehensive bootcamp
- **py_ecc** maintainers for the excellent elliptic curve library
- **Galois** library for finite field arithmetic
- The ZK research community for their groundbreaking work

## 📧 Contact

For questions or discussions about the bootcamp:
- Open an issue in this repository
- Join the [RareSkills Discord](https://discord.gg/rareskills)
- Check out [RareSkills' other courses](https://www.rareskills.io/)

---

<div align="center">

**⚡ Built with curiosity and cryptography ⚡**

*"In cryptography we trust, in mathematics we prove."*

</div>
