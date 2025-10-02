// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.24;

import {console} from "forge-std/console.sol";
// Precompiles: https://www.evm.codes/precompiled

contract Zk {
    struct ECPoint {
        uint256 x;
        uint256 y;
    }

    uint256 public order = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    ECPoint public G = ECPoint(1, 2);

    function rationalAdd(ECPoint calldata A, ECPoint calldata B, uint256 num, uint256 den)
        public
        view
        returns (bool verified)
    {
        // return true if the prover knows two numbers that add up to num/den
        // compute multiply(num * pow(den, -1, order) % order, G)
        ECPoint memory C = addPoints(A, B);
        uint256 s = num * modExp(den, order - 2, order) % order;
        ECPoint memory C_proof = mulPoint(G, s);
        return C.x == C_proof.x && C.y == C_proof.y;
    }

    function matmul(
        uint256[] calldata matrix,
        uint256 n, // n x n for the matrix
        ECPoint[] calldata s, // n elements
        uint256[] calldata o // n elements
    ) public returns (bool verified) {
        // revert if dimensions don't make sense or the matrices are empty

        if (matrix.length == 0 || s.length == 0 || o.length == 0) {
            revert("Inputs are invalid.");
        }

        if (n * n != matrix.length || n != s.length || n != o.length) {
            revert("Dimensions don't match.");
        }
        // return true if Ms == o elementwise. You need to do n equality checks. If you're lazy, you can hardcode n to 3, but it is suggested that you do this with a for loop
        verified = true;
        uint256 idx = 0;
        for (uint256 i = 0; i < n; i++) {
            ECPoint memory Y1;
            for (uint256 j = 0; j < n; j++) {
                // matrix[idx] * s[j] == o[j] * G
                if (j == 0) {
                    Y1 = mulPoint(s[j], matrix[idx]);
                } else {
                    Y1 = addPoints(Y1, mulPoint(s[j], matrix[idx]));
                }
                console.log("idx", idx);
                idx++;
            }
            ECPoint memory Y2 = mulPoint(G, o[i]);
            verified = verified && pointsEq(Y1, Y2);
            console.log("eq", verified);
        }
    }

    function addPoints(ECPoint memory A, ECPoint memory B) public view returns (ECPoint memory) {
        bytes memory precompileData = abi.encode(A.x, A.y, B.x, B.y);
        (bool success, bytes memory data) = address(6).staticcall{gas: 10000}(precompileData);
        require(success, "ecAdd failed");
        return abi.decode(data, (ECPoint));
    }

    function mulPoint(ECPoint memory A, uint256 s) public view returns (ECPoint memory) {
        bytes memory precompileData = abi.encode(A.x, A.y, s);
        (bool success, bytes memory data) = address(7).staticcall(precompileData);
        require(success, "ecMul failed");
        return abi.decode(data, (ECPoint));
    }

    function modExp(uint256 base, uint256 exp, uint256 mod) public view returns (uint256) {
        bytes memory precompileData = abi.encode(32, 32, 32, base, exp, mod);
        (bool ok, bytes memory data) = address(5).staticcall(precompileData);
        require(ok, "expMod failed");
        return abi.decode(data, (uint256));
    }

    function pointsEq(ECPoint memory A, ECPoint memory B) public view returns (bool) {
        return A.x == B.x && A.y == B.y;
    }
}
