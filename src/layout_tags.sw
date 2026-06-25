// Copyright (c) 2026 Peter Bjorklund. All rights reserved.

//! Layout Tags
//!
//! A format created by [`@catnipped`](https://bsky.app/profile/ossianboren.bsky.social) for use in an upcoming game,
//! and is now used in the tektite package - [check it out](https://codeberg.org/catnipped/tektite)!
//!
//! It is using the same syntax rules as FenTags.
//!
//! ## Commands
//!
//! Commands are based on the FenTags syntax, with the following commands:
//!
//! - `[color rgba(R, G, B, A)]`. Example: `[color rgba(10, 20, 30, 244)]`, `[color rgba(10, 20, 30, 0.1)]`, `[color rgb(10, 20, 30)]`. you can use 0-255 or 0.0..1.0.
//! - `[color reset]`. Resets the previous color to default.
//! - `[icon Int]`. Example: `[icon 42]`. Selects an icon with that ID.
//! - `[font Int]`. Example `[font 32]`. Selects the active font using that handle.
//! - `[font reset]`. Selects the default font
//! - `[lineheight Int]`. Selects which lineheight to use (in pixels). Example: `[lineheight 16]`.
//! - `[region Int] ... [/region]`
//!   Defines a tagged region with the given ID.
//!   Example:
//!
//!   ```text
//!   [region 2][icon 99] Hello![/region]
//!   ```
//!
//! - `[newline]`. Moves cursor to a new line.

#![api]

struct ColorRgba {
    r: U8
    g: U8
    b: U8
    a: U8
}


struct ColorRgb {
    r: U8
    g: U8
    b: U8
}

enum Element {
    String(String<256>) // TODO: in the future, APIs should be able to provide temporary strings, without storage
    ColorRgb(ColorRgb)
    ColorRgba(ColorRgba)
    ColorReset
    Icon(Int)
    Font(Int)
    FontReset
    LineHeight(Int)
    RegionBegin(Int)
    RegionEnd
    NewLine
}


struct Parser

impl Parser {
    external 44600 fn parse(input: String) -> [Element]
}
