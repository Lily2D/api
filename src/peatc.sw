// Copyright (c) 2026 Peter Bjorklund. All rights reserved.

//! Peat Loader
//!
//! Quickly loads a binary serialized named Swamp struct

#![api]

struct PeatTag

type PeatId = Res<PeatTag>

external 18000 fn load(id: PeatId) -> Any
