//! # Font Loader API
//!
//! load [bmfont](https://www.angelcode.com/products/bmfont/) format

#![api]

// Do not modify this file!

#[extensions("fnt.xml")]
struct BmFontTagXml {}
type BmFontResXml = Res<BmFontTagXml>

#[extensions("fnt.txt")]
struct BmFontTagTxt {}
type BmFontResTxt = Res<BmFontTagTxt>

#[extensions("fnt.bin")]
struct BmFontTagBin {}
type BmFontResBin = Res<BmFontTagBin>

const GLYPH_COUNT = 256

struct FontInfo {
    base: Int
    line_height: Int
    size: Int
}

struct Glyph {
   ch: Char
   x: Int
   y: Int
   width: Int
   height: Int
   x_offset: Int
   y_offset: Int
   /// how many pixels to advance after each glyph
   x_advance: Int
}

struct BmFont {
    glyphs: [Char : Glyph; GLYPH_COUNT]
    info: FontInfo
}

impl BmFontResXml {
    /// Load the resource file into a `BmFont`
    external 6000 fn load(self) -> BmFont
}

impl BmFontResTxt {
    /// Load the resource file (text format) into a `BmFont`
    external 6001 fn load(self) -> BmFont
}

impl BmFontResBin {
    /// Load the resource file (binary format) into a `BmFont`
    external 6002 fn load(self) -> BmFont
}
