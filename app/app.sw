// Copyright (c) 2026 Peter Bjorklund. All rights reserved.

//! # Lily Application API
//!
//! Functions for controlling the lifetime of the application.
//!
//! Only available from Simulation ticks.

#![api]

// Do not modify this file!

/// Returns whether the current platform supports terminating
/// the application through [`exit`].
external 64100 fn can_exit()

/// Requests application termination.
///
/// The application will exit at the end of the current simulation tick.
/// The provided `return_value` becomes the process exit code on platforms
/// that support exit codes.
external 64101 fn exit(return_value: Int)
