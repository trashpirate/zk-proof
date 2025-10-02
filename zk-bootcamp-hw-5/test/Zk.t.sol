// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {Zk} from "src/Zk.sol";

contract zkTest is Test {
    Zk zk;

    function setUp() public {
        zk = new Zk();
    }

    function test__rationalAdd_success() public {
        Zk.ECPoint memory A = Zk.ECPoint(
            10792118425758452593386803612194702999734583102649656187215171779174161341345,
            20538418743413337834091669352909091374258209787115293629913116495214932877365
        );
        Zk.ECPoint memory B = Zk.ECPoint(
            10810550548120958814474207833137730106981184736848398922753843308319157298796,
            10227686991017843851764675015499447921395797147867364462481033211091419844846
        );

        uint256 num = 8;
        uint256 den = 7;

        bool verified = zk.rationalAdd(A, B, num, den);
        assert(verified);
    }

    function test__rationalAdd_failure() public {
        Zk.ECPoint memory A = Zk.ECPoint(
            10792118425758452593386803612194702999734583102649656187215171779174161341345,
            20538418743413337834091669352909091374258209787115293629913116495214932877365
        );
        Zk.ECPoint memory B = Zk.ECPoint(
            10810550548120958814474207833137730106981184736848398922753843308319157298796,
            10227686991017843851764675015499447921395797147867364462481033211091419844846
        );

        uint256 num = 8;
        uint256 den = 5;

        bool verified = zk.rationalAdd(A, B, num, den);
        assert(!verified);
    }

    function test__matmul_success() public {
        Zk.ECPoint memory P = Zk.ECPoint(
            3353031288059533942658390886683067124040920775575537747144343083137631628272,
            19321533766552368860946552437480515441416830039777911637913418824951667761761
        );
        Zk.ECPoint memory Q = Zk.ECPoint(
            10744596414106452074759370245733544594153395043370666422502510773307029471145,
            848677436511517736191562425154572367705380862894644942948681172815252343932
        );
        Zk.ECPoint memory R = Zk.ECPoint(
            10415861484417082502655338383609494480414113902179649885744799961447382638712,
            10196215078179488638353184030336251401353352596818396260819493263908881608606
        );
        Zk.ECPoint[] memory s = new Zk.ECPoint[](3);
        s[0] = P;
        s[1] = Q;
        s[2] = R;

        uint256[] memory matrix = new uint256[](9);
        for (uint256 index = 0; index < 9; index++) {
            matrix[index] = index + 1;
        }

        uint256[] memory o = new uint256[](3);
        o[0] = 34;
        o[1] = 79;
        o[2] = 124;

        bool verified = zk.matmul(matrix, 3, s, o);
        assert(verified);
    }

    function test__addPoints() public {
        // bytes memory precompileData = abi.encode(1);
        // (bool success, bytes memory data) = address(4).staticcall(precompileData);
        // console.log(abi.decode(data, (uint256)));
        Zk.ECPoint memory A = Zk.ECPoint(
            10792118425758452593386803612194702999734583102649656187215171779174161341345,
            20538418743413337834091669352909091374258209787115293629913116495214932877365
        );
        Zk.ECPoint memory B = Zk.ECPoint(
            10810550548120958814474207833137730106981184736848398922753843308319157298796,
            10227686991017843851764675015499447921395797147867364462481033211091419844846
        );

        Zk.ECPoint memory C = zk.addPoints(A, B);
        assertEq(C.x, 14798533066760651542484066785735184297766257978581639765933052902207291465264);
        assertEq(C.y, 20610981351578098998096420564028267343867237004024465875014024638528346647384);
    }

    function test__pointsEq() public {
        Zk.ECPoint memory A = Zk.ECPoint(
            10792118425758452593386803612194702999734583102649656187215171779174161341345,
            20538418743413337834091669352909091374258209787115293629913116495214932877365
        );
        Zk.ECPoint memory B = Zk.ECPoint(
            10810550548120958814474207833137730106981184736848398922753843308319157298796,
            10227686991017843851764675015499447921395797147867364462481033211091419844846
        );

        assert(zk.pointsEq(A, A));
        assert(!zk.pointsEq(A, B));
    }
}
