//! # Persistence API
//!
//! User data that should persist between game sessions, such as user preferences and game saves.
//!
//! ## Versioning rules
//! - Monotonic versioning (only increasing).
//! - Version 0 is reserved for "no data". The first valid version must be 1.
//! - The version is only incremented when new fields are appended to the end
//!   of the serialized `struct`.
//!
//! ## Serialization rules
//! - Additive schema changes only. Fields may only be appended at the end.
//! - Existing fields must never be removed, reordered, or have their meaning changed.
//!
//! ## Migration
//! - Caller-driven migration logic. The returned version indicates the version
//!   of the data read from storage and should be used to initialize any fields
//!   added in later versions.
//! - Newer code may derive new fields or behaviors from older fields during load.
//!   This is a migration step and does not change the original meaning of the
//!   serialized data.
//! - After migration, an older field may become obsolete and ignored by newer
//!   runtime code.
//! - Obsolete fields and their values must still be preserved in the
//!   serialized data to maintain forward compatibility with older versions.


// DO NOT MODIFY THIS FILE!

#![api]

type Version = U32

//| === User Preferences ===

/// Load game specific user preferences
///
/// Returns the version read from file (or 0 if no file exists).
///
external 13000 fn load_user_prefs(latest_version: Version, mut preferences: Any) -> Version

/// Save game specific user preferences
///
external 13001 fn save_user_prefs(version: Version, preferences: Any)

//| === Game Save and load ===
//|
//| A game save must not mirror the live simulation state.
//|
//| It must be a semantic representation of player
//| progress and essential game state. You are expected to choose the
//| smallest set of fields whose meaning remains clear across future versions.
//|
//| This rule is not for file size. Its main purpose is to make
//| saved data stable and easy to migrate in the future as the simulation, code, and runtime data
//| structures change over time.
//|
//| Prefer saving semantic concepts over runtime details. For example,
//| save a checkpoint ID rather than a world position. A checkpoint
//| continues to express player progress even if the level changes, while a
//| world position may become invalid or impossible to solve in a later
//| version.

/// Saves the game to a "default" or autosave slot for the active user
external 13010 fn save_game(version: Version, game_state: Any)

/// Loads the game state from secondary storage and writes to `game_state` parameter (struct).
external 13011 fn load_game(mut game_state: Any) -> Version

/// Checks if the game slot is not containing previous data
external 13012 fn is_game_slot_free(slot_index: Int) -> Bool

/// Returns the maximum amount of slots that are allowed on this device/platform
external 13013 fn max_game_slot_count() -> Int

/// Saves game to specific slot
external 13014 fn save_game_slot(slot_index: Int, version: Version, game_state: Any)

/// Loads game from specific slot
external 13015 fn load_game_slot(slot_index: Int, version: Version, mut game_state: Any) -> Version

/// Deletes a game slot
external 13016 fn delete_game_slot(slot_index: Int)
