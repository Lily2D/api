// Copyright (c) 2026 Peter Bjorklund. All rights reserved.

//! # Config API
//!
//! `config.yini` and lily command line argument
//!

// DO NOT MODIFY THIS FILE!

#![api]

type Version = U32

/// Get prepared config. It was filled in by `config.yini` in project root and/or lily command line arguments
///
/// ```
/// game_config := lily::config::get::<GameConfig>()
/// ```
external 13500 fn get(type_id: Int) -> Any
