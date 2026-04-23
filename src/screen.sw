//! Screen related functions

#![api]

//| ## Cursor
//|
//| Refers to the operating system–controlled mouse pointer.
//| Not to be confused with a text cursor (caret).

/// Hides the system cursor.
external 19000 fn hide_cursor()

/// Shows the system cursor.
external 19001 fn show_cursor()
