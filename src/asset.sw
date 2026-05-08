//! # Asset serialization
//!
//! Game specific fast asset loading
//!
//! ## Versioning rules
//!
//! - Monotonic versioning (only increasing). This is not semantic versioning.
//! - Version `0` is reserved for "no data". The first valid version must be 1.
//! - The version is only incremented when new fields are appended to the end
//!   of the serialized `struct`.
//! - It is by design only backwards compatible, not forwards compatible
//!
//! ## Serialization rules
//!
//! - Additive schema changes only. Fields may only be appended at the end.
//! - Existing fields must never be removed, reordered, or have their meaning changed.
//! - In future versions, fields maybe marked as being valid in certain version ranges
//!
//! ## Migration
//!
//! - Caller-driven migration logic. The returned version indicates the version
//!   of the data read from storage and should be used to initialize any fields
//!   added in later versions.
//! - Newer code may derive new fields or behaviors from older fields during load.
//!   This is a migration step and does not change the original meaning of the
//!   serialized data.
//! - After migration, an older field may become obsolete and ignored by newer
//!   runtime code.

// DO NOT MODIFY THIS FILE!

#![api]

type AssetVersion = U32

struct AssetTag

type AssetId = Res<AssetTag>

/// Load game specific struct data
///
/// Returns the version read from file.
///
external 14000 fn load_asset(asset_id: AssetId, latest_version: AssetVersion, mut data: Any) -> AssetVersion


/// Save game specific struct to existing file
///
/// Not available in runtime only builds
///
external 14001 fn save_asset(asset_id: AssetId, version: AssetVersion, data: Any)

/// TODO: not implemented yet
external 14002 fn create_asset(asset_path: String, data: Any)
