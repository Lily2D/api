//! User API
//!
//! Returns information about the logged in user

#![api]

/// Returns the user ID in a platform aware format.
/// For Steam it returns "steam:steam_user_id".
// Game engine cannot return heap allocated strings yet.
external 4000 fn id() -> String<32>

/// Returns the persona name (nick name, short name) for the platform.
// Game engine cannot return heap allocated strings yet.
external 4001 fn persona_name() -> String<32>
