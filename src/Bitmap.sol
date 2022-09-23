// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

// Used for masking.
uint256 constant MASK = (1 << 256) - 1;

// Alias to uint256. Stored on the stack.
type Bitmap is uint256;

// Sets a bit to one in a bitmap at an index.
function set(Bitmap bitmap, uint8 index) pure returns (Bitmap updatedBitmap) {
    assembly {
        updatedBitmap := or(bitmap, shl(index, 1))
    }
}

// Clears a bit in a bitmap at an index.
function clear(Bitmap bitmap, uint8 index) pure returns (Bitmap updatedBitmap) {
    assembly {
        updatedBitmap := and(bitmap, xor(MASK, shl(index, 1)))
    }
}

// Returns true if a bit at the index is `1`, else it returns false.
function get(Bitmap bitmap, uint8 index) pure returns (bool one) {
    assembly {
        one := iszero(iszero(and(bitmap, shl(index, 1))))
    }
}

// Bitwise `and` on two bitmaps.
function and(Bitmap bitmap0, Bitmap bitmap1) pure returns (Bitmap updatedBitmap) {
    assembly {
        updatedBitmap := and(bitmap0, bitmap1)
    }
}

// Bitwise `or` on two bitmaps.
function or(Bitmap bitmap0, Bitmap bitmap1) pure returns (Bitmap updatedBitmap) {
    assembly {
        updatedBitmap := or(bitmap0, bitmap1)
    }
}

// Bitwise `xor` on two bitmaps.
function xor(Bitmap bitmap0, Bitmap bitmap1) pure returns (Bitmap updatedBitmap) {
    assembly {
        updatedBitmap := xor(bitmap0, bitmap1)
    }
}

// Bitwise `not`.
function not(Bitmap bitmap) pure returns (Bitmap updatedBitmap) {
    assembly {
        updatedBitmap := not(bitmap)
    }
}

// Returns true if two bitmaps are of equal value, else it returns false.
function eq(Bitmap bitmap0, Bitmap bitmap1) pure returns (bool equal) {
    assembly {
        equal := eq(bitmap0, bitmap1)
    }
}

// Returns true if all bits in the bitmap are zero.
function iszero(Bitmap bitmap) pure returns (bool isZero) {
    assembly {
        isZero := iszero(bitmap)
    }
}

// Make each function globally accessible on the `Bitmap` type.
// Allows for <bitmap>.<func>() syntax.
using {
    set,
    clear,
    get,
    and,
    or,
    not,
    xor,
    eq,
    iszero
} for Bitmap global;
