// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Bitmap} from "src/Bitmap.sol";

contract BitmapTest is Test {
    // assertion utility
    function assertEq(Bitmap a, Bitmap b) internal {
        assertEq(Bitmap.unwrap(a), Bitmap.unwrap(b));
    }

    function testSet() public {
        // 0b0000
        Bitmap bitmap = Bitmap.wrap(0);

        // 0b0010
        bitmap = bitmap.set(1);

        assertEq(bitmap, Bitmap.wrap(1 << 1));
    }

    function testClear() public {
        // 0b0000
        Bitmap bitmap = Bitmap.wrap(0);

        // 0b0010
        bitmap = bitmap.set(1);

        // 0b0000
        bitmap = bitmap.clear(1);

        assertEq(bitmap, Bitmap.wrap(0));
    }

    function testClearOnlyOne() public {
        // 0b0000
        Bitmap bitmap = Bitmap.wrap(0);

        // 0b0010
        bitmap = bitmap.set(1);

        // 0b0110
        bitmap = bitmap.set(2);

        // 0b0010
        bitmap = bitmap.clear(2);

        assertEq(bitmap, Bitmap.wrap(1 << 1));
    }

    function testGet() public {
        // 0b0000
        Bitmap bitmap = Bitmap.wrap(0);

        // 0b0010
        bitmap = bitmap.set(1);

        assertTrue(bitmap.get(1));
        assertFalse(bitmap.get(2));
    }

    function testAnd() public {
        // 0b0000
        Bitmap bitmap0 = Bitmap.wrap(0);

        // 0b0000
        Bitmap bitmap1 = bitmap0;

        // 0b0010
        bitmap0 = bitmap0.set(1);

        // 0b0010
        bitmap1 = bitmap1.set(1);
        // 0b0110
        bitmap1 = bitmap1.set(2);

        assertEq(bitmap0.and(bitmap1), Bitmap.wrap(1 << 1));
    }

    function testOr() public {
        // 0b0000
        Bitmap bitmap0 = Bitmap.wrap(0);

        // 0b0000
        Bitmap bitmap1 = bitmap0;

        // 0b0010
        bitmap0 = bitmap0.set(1);

        // 0b0010
        bitmap1 = bitmap1.set(1);

        // 0b0110
        bitmap1 = bitmap1.set(2);

        assertEq(bitmap0.or(bitmap1), Bitmap.wrap(0).set(1).set(2));
    }

    function testXor() public {
        // 0b0000
        Bitmap bitmap0 = Bitmap.wrap(0);

        // 0b0000
        Bitmap bitmap1 = bitmap0;

        // 0b0010
        bitmap0 = bitmap0.set(1);

        // 0b0010
        bitmap1 = bitmap1.set(1);

        // 0b0110
        bitmap1 = bitmap1.set(2);

        assertEq(bitmap0.xor(bitmap1), Bitmap.wrap(1 << 2));
    }

    function testEq() public {
        // 0b0000
        Bitmap bitmap0 = Bitmap.wrap(0);

        // 0b0000
        Bitmap bitmap1 = bitmap0;

        // 0b0010
        bitmap0 = bitmap0.set(1);

        // 0b0010
        bitmap1 = bitmap1.set(1);

        // 0b0110
        bitmap1 = bitmap1.set(2);

        assertFalse(bitmap0.eq(bitmap1));
        assertTrue(bitmap0.eq(bitmap0));
    }

    function testIsZero() public {
        // 0b0000
        Bitmap bitmap0 = Bitmap.wrap(0);

        // 0b0000
        Bitmap bitmap1 = bitmap0;

        // 0b0010
        bitmap0 = bitmap0.set(1);

        assertTrue(bitmap1.iszero());
        assertFalse(bitmap0.iszero());
    }
}
