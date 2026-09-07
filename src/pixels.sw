// Copyright Peter Björklund. All rights reserved.

#![api]

const WIDTH = 256
const HEIGHT = 144

// Palette index 0 is transparent. DB32 colors occupy indices 1..=32.

external 101 fn set(x: Int, y: Int, palette_index: Int)
external 102 fn clear(palette_index: Int)

external 104 fn get(x: Int, y: Int) -> Int
external 105 fn sprite(x: Int, y: Int, width: Int, colors: [U8])
external 106 fn box(x: Int, y: Int, width: Int, height: Int, palette_index: Int)
external 107 fn line(x0: Int, y0: Int, x1: Int, y1: Int, palette_index: Int)
external 108 fn sprite_flip(x: Int, y: Int, width: Int, colors: [U8], flip_h: Bool, flip_v: Bool)
external 109 fn circle(x: Int, y: Int, radius: Int, palette_index: Int)
external 110 fn circle_fill(x: Int, y: Int, radius: Int, palette_index: Int)
external 111 fn char(x: Int, y: Int, ch: U8, palette_index: Int)
external 112 fn text(x: Int, y: Int, text: String, palette_index: Int)
external 113 fn box_outline(x: Int, y: Int, width: Int, height: Int, palette_index: Int)

external 119 fn sprite_ex(x: Int, y: Int, width: Int, height: Int, colors_offset: Int, colors_stride: Int, colors: [U8])

struct TilemapExParams {
    tile_size: Int // Must be 8, 16, 32 or 64
    tile_offset: Int // Where to search for the tile id, often 0
    tile_stride: Int // how many tiles that are in total for each row
    colors_offset: Int // normally 0
    colors_width: Int // how many pixels in width in the tilemap
}

external 120 fn tilemap_ex(x: Int, y: Int, grid_width: Int, grid_height: Int, params: TilemapExParams, tiles: [U8], colors: [U8])
