//! # Datagram API
//!
//! Send and receive datagrams and query latency

// DO NOT MODIFY THIS FILE!

#![api]

struct Net {
    handle: Int,
}

impl Net {
    /// Connects to the specified host and port
    external 3000 fn new(host: String) -> Net

    /// Send a datagram (a game specific `enum`)
    ///
    /// The datagram is unreliable, so you have to keep
    /// sending until an answer is returned. or you give up
    /// and move to another "phase" in the game state.
    external 3001 fn write(mut self, enum_payload: Any)

    /// Receive a datagram (must be an `enum`)
    ///
    /// The datagram is unreliable, so you need to send an answer
    /// even if same (or similar) request has been handled earlier.
    ///
    /// # Example
    ///
    /// ```swamp
    /// endpoint := Net::new("server.example.com:55000")
    ///
    /// mut game_enum: GameSpecificEnum
    ///
    /// while endpoint.read(&game_enum) {
    ///     match game_enum {
    ///         // handle the variants
    ///     }
    /// }
    /// ```
    external 3002 fn read(mut self, mut emum_payload: Any) -> Bool

    /// Return the latency in milliseconds
    external 3003 fn latency(self) -> Int
}
