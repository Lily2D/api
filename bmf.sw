#![api]

/// Font loader. Do not modify this file!

#[extensions("font")]
struct BmFontTag {}
type BmFontRes = Res<BmFontTag>

const GLYPH_COUNT = 256

struct FontInfo {
    base: Int,
    line_height: Int,
    size: Int,
}

struct Glyph {
   ch: Char,
   x: Int,
   y: Int,
   width: Int,
   height: Int,
   x_offset: Int,
   y_offset: Int,
   x_advance: Int,
}

struct BmFont {
    glyphs: [Char : Glyph; GLYPH_COUNT]
    info: FontInfo
}


impl BmFontRes {
    external 6000 fn load(self) -> BmFont
}
