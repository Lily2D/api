// Copyright (c) 2026 Peter Bjorklund. All rights reserved.

//! # Screen API
//!
//! Small library for screen. Changing screen size and show and hide cursor.
//!

#![api]

struct ExclusiveMode {
    id: Int // index
    width: Int
    height: Int
    frequency: Int // millihertz
}

//| ## Capabilities and resolutions
//|
//| Querying screen exclusive modes (fullscreen).

/// Return all known exclusive fullscreen modes.
external 17400 fn exclusive_modes() -> [ExclusiveMode]

/// Return true if exclusive fullscreen modes are supported.
/// Similar to exclusive_modes().len() != 0
external 17410 fn has_exclusive() -> Bool

/// Return true if borderless fullscreen is supported.
external 17411 fn has_borderless() -> Bool

/// Return true if windowed mode is supported.
external 17412 fn has_windowed() -> Bool

/// Return the smallest useful windowed extent as (width, height).
external 17420 fn min_windowed_extent() -> (Int, Int)

/// Return the largest useful windowed extent as (width, height).
external 17421 fn max_windowed_extent() -> (Int, Int)

//| ## Mode selection
//|
//| Setting a supported screen mode.

/// Set exclusive fullscreen using a mode id from exclusive_modes().  Returns true if successful.
external 17430 fn set_exclusive(mode_id: Int) -> Bool

/// Set borderless fullscreen on the current monitor. Returns true if successful.
external 17431 fn set_borderless() -> Bool

/// Set windowed mode at an explicit extent. Returns true if successful.
external 17432 fn set_windowed(width: Int, height: Int) -> Bool

//| ## Cursor
//|
//| Refers to the operating system–controlled mouse pointer.
//| Not to be confused with a text cursor (caret).

/// Hides the system cursor.
external 19000 fn hide_cursor()

/// Shows the system cursor.
external 19001 fn show_cursor()
