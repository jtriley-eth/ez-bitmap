# EZ Bitmaps

This library declares a custom type, `Bitmap`, which is aliased to `uint256` with some custom
functionality. Instead of relying on Solidity bitwise operations or assembly blocks, developers can
instead interact with bitmaps with a high level syntax.

This is an experiment both with Solidity's developing type system and as an example of how unsafe
code (assembly) can be used more safely in high level applications.

> NOTICE: This is experimental. Unit tests have been written, but no formal reviews or audits have
> been conducted.

## Usage

The type can be used by importing from this library as follows.

```solidity
import {Bitmap} from "ez-bitmap/src/Bitmap.sol";

contract MyCon {
    Bitmap internal map;
    uint8 constant firstBitIndex = 0;

    function setFirstBitToTrue() public {
        map = map.set(firstBitIndex);
    }
}
```

### API

Where `b`, `b0`, and `b1` are of type `Bitmap`:

| code                  | operation                               |
| --------------------- | --------------------------------------- |
| `b = b.set(n)`        | set bit `n` of `b` to 1                 |
| `b = b.cleart(n)`     | set bit `n` of `b` to 0                 |
| `bool x = b.get(n)`   | true if bit `n` of `b` is 1, else false |
| `b0 = b0.and(b1)`     | bitwise `and` of `b0` and `b1`          |
| `b0 = b0.or(b1)`      | bitwise `or` of `b0` and `b1`           |
| `b0 = b0.xor(b1)`     | bitwise `xor` of `b0` and `b1`          |
| `b = b.not()`         | bitwise `not` of `b`                    |
| `bool x = b0.eq(b1)`  | true if `b0` equals `b1`, else false    |
| `bool x = b.iszero()` | true if `b` is empty, else false        |
