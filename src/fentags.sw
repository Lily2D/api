// Copyright (c) 2026 Peter Bjorklund. All rights reserved.

//! FenTags
//!
//! A format made by [`@catnipped`](https://bsky.app/profile/ossianboren.bsky.social) and [`@piot`](https://bsky.app/profile/peterbjorklund.bsky.social)
//! in collaboration. The syntax was formalized, and then used for layout-tags that was needed
//! in an upcoming game by @catnipped.
//!
//! We wanted something with tags and strings interleaved, inspired by other text tag formats, like [BBCode](https://en.wikipedia.org/wiki/BBCode).
//!
//! Fen: an area of low, flat, wet land [dictionary](https://www.oxfordlearnersdictionaries.com/us/definition/english/fen)
//!
//! ## Syntax
//!
//! A normal string with optional [] tags in-between.
//!
//! `[lower_case_command <OPTIONAL ARGUMENTS>]` or a closing tag `[/lower_case_command]`. The arguments can be either positional or
//! named arguments, but not allowed to be mixed. Examples:
//!
//! `[some_command -32 42.0]`
//! `[some_command x_offset=-32 health=42.0]`
//!
//! Literal values:
//! - Int
//! - Float
//! - Keyword (String)
//! - Color (`rgba(U8, U8, U8, U8)`)
//!
//! "constructors" are allowed as values as well:
//! `[some_command color=CustomConstructor(10, 20, 30)]` but not implemented properly yet
//!

#![api]

const MAX_PARAMETER_COUNT = 16

enum Value {
    NotSet
    Int(Int)
    Float(Float)
    Keyword(String<32>)
    ColorRgb(U8, U8, U8)
    ColorRgba(U8, U8, U8, U8)
    // TODO: maybe implement percentage suffix
}

struct Arguments {
    values: Vec<Value; MAX_PARAMETER_COUNT>
}

enum Element {
    String(String)
    Command(Int, Arguments) // maybe { command_id: Int, arguments: Arguments } is better?
}


struct CommandDefinition {
    name: String
    parameter_names: Vec<String; MAX_PARAMETER_COUNT>
}

struct Lexer

impl Lexer {
    external 44500 fn lex(input: String, commands: [CommandDefinition]) -> [Element]
}
