// Copyright (c) 2026 Peter Bjorklund. All rights reserved.

//! FenTags
//!
//! FenTags is a lightweight tag language for embedding commands in text.
//!
//! It was created by [`@catnipped`](https://bsky.app/profile/ossianboren.bsky.social) and
//! [`@piot`](https://bsky.app/profile/peterbjorklund.bsky.social) in collaboration. We needed
//! a simple way to describe layouts inlined with text.
//!
//! FenTags is inspired by [BBCode](https://en.wikipedia.org/wiki/BBCode) and similar text
//! tagging formats.
//!
//! The name comes from [*fen*](https://www.oxfordlearnersdictionaries.com/us/definition/english/fen): an area of low, flat, wet land.
//!
//! It is recommended to parse FenTags during startup rather than repeatedly at
//! runtime. Parsing still has a performance cost and may panic from bad input.
//!
//! ## Syntax
//!
//! A FenTags document consists of plain text with optional tags embedded throughout.
//!
//! Opening tags have the form:
//!
//! ```text
//! [lower_case_command <optional arguments>]
//! ```
//!
//! Most tags do not require a closing tag, only tags that define a "region" must
//! be terminated with a matching closing tag:
//!
//! ```text
//! [/lower_case_command]
//! ```
//!
//! Command arguments may be either positional or named, but the two styles cannot be
//! mixed within the same tag.
//!
//! Positional arguments:
//!
//! ```text
//! [some_command -32 42.0]
//! ```
//!
//! Named arguments:
//!
//! ```text
//! [some_command x_offset=-32 health=42.0]
//! ```
//!
//! Command names and named argument names use lowercase snake_case.
//!
//! - start with a lowercase ASCII letter (`a-z`)
//! - contain only lowercase ASCII letters (`a-z`), digits (`0-9`), and underscores (`_`)
//! - not end with an underscore
//! - not contain consecutive underscores
//!
//! ## Literal values
//!
//! Supported literal value types:
//!
//! - Integer Example: `42`
//! - Float. Example: `99.876`
//! - Keyword (identifier). Example: `keyword`
//! - Color (`rgba(U8, U8, U8, U8)`). Example: `rgba(28,44,99,244)`, `rgb(28,99,76)` you can use floats as well.
//! - Percentage. Example: (`25%`, `99.8%`)
//! - Constructor-like values for structured types. Example: `CustomColor(10, 20, 30)`
//! - String. Example: `"hello world!"`
//!
//! String literals, percentage literals and constructor values are part of the FenTags specification,
//! but not implemented in this API yet.
//!
//! We think that it is pretty FenTagstic format!

#![api]

const MAX_PARAMETER_COUNT = 16

enum Value {
    NotSet
    Int(Int)
    Float(Float)
    Keyword(String<32>)
    ColorRgb(U8, U8, U8)
    ColorRgba(U8, U8, U8, U8)
    // TODO: implement percentage suffix
    // TODO: implement strings // String(String<256>)
}

struct Arguments {
    values: Vec<Value; MAX_PARAMETER_COUNT>
}

enum Element {
    String(String<256>) // TODO: in the future it should be able to use String without in types returned from Host.
    Command(Int, Arguments) // maybe { command_id: Int, arguments: Arguments } is better?
}


struct CommandDefinition {
    name: String<32>
    parameter_names: Vec<String<32>; MAX_PARAMETER_COUNT>
}

struct Lexer

impl Lexer {
    external 44500 fn lex(input: String, commands: [CommandDefinition]) -> [Element]
}
