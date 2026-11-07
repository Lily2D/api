// Copyright Peter Björklund. All rights reserved.

//! # Pixel API
//!
//! Pixel oriented frame buffer
//!
//! Coordinate system has origin at top left (0, 0)
//! Positions are allowed to be negative and outside of the (256, 144) frame buffer size

#![api]

const WIDTH = 256
const HEIGHT = 144

// Palette index 0 is transparent. DB32 occupies indices 1..=32; remaining
// palette entries are used by `load_png`.

#[extensions("png")]
struct ImageTag {}

type Image = Res<ImageTag>
alias PaletteIndex = U8
alias TileIndex = U8

//| ## Initialization

/// Loads a *indexed* png file. Note that this can only be used in the anchor construction for Render.
external 121 fn load_png(image: Image, cell_width: Int, cell_height: Int, cell_count: Int)

//| ## Render
//|
//| Coordinates use an upper-left origin: x increases rightward and y increases
//| downward. Rectangle-like drawing functions use x/y as their upper-left corner.

//| Pixel manipulation

/// Sets the same `color` to the all the pixels in the frame buffer (256x144 pixels)
external 102 fn clear(color: PaletteIndex)

/// Sets a single pixel
external 101 fn set(x: Int, y: Int, color: PaletteIndex)

/// Reads a single pixel
external 104 fn get(x: Int, y: Int) -> PaletteIndex


//| ## Render primitives

/// Draw a box, with x, y at top-left of the rectangle
external 106 fn box(x: Int, y: Int, width: Int, height: Int, color: PaletteIndex)

/// Draw an outlined box, with x, y at top-left of the rectangle
external 113 fn box_outline(x: Int, y: Int, width: Int, height: Int, color: PaletteIndex)

/// Draws a line from position to pixel position
external 107 fn line(x0: Int, y0: Int, x1: Int, y1: Int, color: PaletteIndex)

/// Draws a circle with the center at `x`, `y`
external 109 fn circle(x: Int, y: Int, radius: Int, color: PaletteIndex)

/// Draws a filled circle with the center at `x`, `y`
external 110 fn circle_fill(x: Int, y: Int, radius: Int, color: PaletteIndex)


//| ## Sprite

/// Draws an image cell with its upper-left corner at (x, y).
external 124 fn sprite(image: Image, cell_index: Int, x: Int, y: Int)

/// Draws an image cell with its upper-left corner at (x, y), optionally flipped.
external 122 fn sprite_ex(image: Image, cell_index: Int, x: Int, y: Int, flip_x: Bool, flip_y: Bool)

/// Raw variants if you want to use your own pixels (`[PaletteIndex]`)
external 105 fn sprite_raw(x: Int, y: Int, width: Int, colors: [PaletteIndex])
external 108 fn sprite_raw_flip(x: Int, y: Int, width: Int, colors: [PaletteIndex], flip_x: Bool, flip_y: Bool)
external 119 fn sprite_raw_ex(x: Int, y: Int, width: Int, height: Int, colors_offset: Int, colors_stride: Int, colors: [PaletteIndex])


//| ## Text - Builtin font

/// Draws a single character at top left x, y
external 111 fn char(x: Int, y: Int, ch: U8, color: PaletteIndex)

/// Draws a string at top left x, y
external 112 fn text(x: Int, y: Int, text: String, color: PaletteIndex)


//| ## Tilemap


struct Rect {
    x: Int
    y: Int
    width: Int
    height: Int
}

struct TilemapParams {
    tile_stride: Int // How many tile ids are in each map row
}

/// Draws a pixel-sized viewport into a tilemap.
external 123 fn tilemap(image: Image, viewport: Rect, pixel_offset_x: Int, pixel_offset_y: Int, tiles: [TileIndex], params: TilemapParams)


struct TilemapExParams {
    tile_size: Int // Must be greater than zero and no larger than 64
    tile_offset: Int // Where to search for the tile id, often 0
    tile_stride: Int // how many tiles that are in total for each row
    colors_offset: Int // normally 0
    colors_width: Int // how many pixels in width in the tilemap
}

/// Draws a raw tilemap
external 120 fn tilemap_raw_ex(x: Int, y: Int, grid_width: Int, grid_height: Int, params: TilemapExParams, tiles: [TileIndex], colors: [PaletteIndex])
