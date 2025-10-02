// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

import {console} from "forge-std/console.sol";

contract Zk {
    struct G1Point {
        uint256 x;
        uint256 y;
    }

    struct G2Point {
        uint256[2] x;
        uint256[2] y;
    }

    uint256 public constant ORDER = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    uint256 public constant FIELD_MODULUS =
        21888242871839275222246405745257275088696311157297823662689037894645226208583;
    G1Point private G1;
    G2Point private G2;

    G1Point private Alpha1;
    G2Point private Beta2;
    G2Point private Gamma2;
    G2Point private Delta2;

    constructor() {
        G1 = G1Point(1, 2);
        G2 = G2Point(
            [
                11559732032986387107991004021392285783925812861821192530917403151452391805634,
                10857046999023057135944570762232829481370756359578518086990519993285655852781
            ],
            [
                4082367875863433681332203403145435568316851327593401208105741076214120093531,
                8495653923123431417604973247489272438418190587263600148770280649306958101930
            ]
        );

        Alpha1 = G1Point(
            1368015179489954701390400359078579693043519447331113978918064868415326638035,
            9918110051302171585080402603319702774565515993150576347155970296011118125764
        );

        Beta2 = G2Point(
            [
                10191129150170504690859455063377241352678147020731325090942140630855943625622,
                12345624066896925082600651626583520268054356403303305150512393106955803260718
            ],
            [
                16727484375212017249697795760885267597317766655549468217180521378213906474374,
                13790151551682513054696583104432356791070435696840691503641536676885931241944
            ]
        );
        Gamma2 = G2Point(
            [
                10857046999023057135944570762232829481370756359578518086990519993285655852781,
                11559732032986387107991004021392285783925812861821192530917403151452391805634
            ],
            [
                8495653923123431417604973247489272438418190587263600148770280649306958101930,
                4082367875863433681332203403145435568316851327593401208105741076214120093531
            ]
        );
        Delta2 = G2Point(
            [
                20954117799226682825035885491234530437475518021362091509513177301640194298072,
                4540444681147253467785307942530223364530218361853237193970751657229138047649
            ],
            [
                21508930868448350162258892668132814424284302804699005394342512102884055673846,
                11631839690097995216017572651900167465857396346217730511548857041925508482915
            ]
        );
    }

    function verify(uint256 x1, uint256 x2, uint256 x3, G1Point memory A1, G2Point memory B2, G1Point memory C1)
        public
        returns (bool)
    {
        G1Point memory X1 = addPoints(addPoints(mulPoint(G1, x1), mulPoint(G1, x2)), mulPoint(G1, x3));

        G1Point[] memory P1 = new G1Point[](4);
        G2Point[] memory P2 = new G2Point[](4);

        P1[0] = negate(A1);
        P1[1] = Alpha1;
        P1[2] = X1;
        P1[3] = C1;

        P2[0] = B2;
        P2[1] = Beta2;
        P2[2] = Gamma2;
        P2[3] = Delta2;

        return pairing(P1, P2);
    }

    function negate(G1Point memory A) public pure returns (G1Point memory) {
        if (A.x == 0 && A.y == 0) return G1Point(0, 0);
        return G1Point(A.x, FIELD_MODULUS - A.y);
    }

    function addPoints(G1Point memory A, G1Point memory B) public view returns (G1Point memory) {
        bytes memory precompileData = abi.encode(A.x, A.y, B.x, B.y);
        (bool success, bytes memory data) = address(6).staticcall{gas: 10000}(precompileData);
        require(success, "ecAdd failed");
        return abi.decode(data, (G1Point));
    }

    function mulPoint(G1Point memory A, uint256 s) public view returns (G1Point memory) {
        bytes memory precompileData = abi.encode(A.x, A.y, s);
        (bool success, bytes memory data) = address(7).staticcall(precompileData);
        require(success, "ecMul failed");
        return abi.decode(data, (G1Point));
    }

    function pairing(G1Point[] memory X, G2Point[] memory Y) public returns (bool) {
        if (X.length != Y.length) revert("Invalid input");

        bytes memory input = abi.encode(X[0].x, X[0].y, Y[0].x[1], Y[0].x[0], Y[0].y[1], Y[0].y[0]);

        uint256 n = X.length;
        if (n > 1) {
            for (uint256 i = 1; i < n; i++) {
                input = abi.encodePacked(input, X[i].x, X[i].y, Y[i].x[1], Y[i].x[0], Y[i].y[1], Y[i].y[0]);
            }
        }

        (bool success, bytes memory data) = address(8).staticcall(input);
        require(success, "ecPairing failed");
        return abi.decode(data, (bool));
    }

    function getG2() public view returns (G2Point memory) {
        return G2;
    }
}
