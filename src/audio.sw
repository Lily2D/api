//! Lily2D Audio API
//!
//! Voice-based synth with 8 stereo voices and per-sound ADSR settings.
//! The mixer renders signed 16-bit stereo at 44.1 kHz and resamples to the
//! active output device when needed.

#![api]

/// Number of concurrent hardware/software voices.
const VOICE_COUNT = 8

/// Voice index in the range 0..VOICE_COUNT-1.
type Voice = Int

/// MIDI note number.
///
/// Valid range: 0..127.
///
/// Standards and references:
///
/// [MIDI tuning standard](https://en.wikipedia.org/wiki/MIDI_tuning_standard)
/// [MIDI](https://en.wikipedia.org/wiki/MIDI#Technical_specifications)
type Note = Int

struct SoundTag
/// Loaded/registered sound resource handle.
type SoundId = Res<SoundTag>

enum VoiceState {
    /// Voice is available and not currently assigned.
    Idle
    /// Voice is actively playing (attack/decay/sustain stage).
    Playing
    /// Playback is paused and can be resumed from the same position.
    Paused
    /// Release phase is running until the voice becomes idle.
    Releasing
}

struct Adsr {
    /// Attack time in milliseconds.
    attack: Int

    /// Decay time in milliseconds.
    decay: Int

    /// Sustain level in the normalized range 0.0..1.0.
    sustain: Float

    /// Release time in milliseconds.
    release: Int
}

/// Per-resource playback definition.
///
/// - adsr: Envelope used when the voice is triggered.
/// - root_note: Natural pitch of the source sample.
struct SoundDefinition {
    adsr: Adsr
    root_note: Note
}

// === Resource setup and streaming ===

/// Start streaming an OGG Vorbis resource on a voice.
///
/// - id: Target voice index.
/// - note: Playback note used for pitch transposition.
/// - resource_id: Sound resource handle.
/// - sound: ADSR + root note definition.
/// - volume: Linear gain, expected range 0.0..1.0.
external 12001 fn stream_ogg_vorbis(id: Voice, note: Note, resource_id: SoundId, sound: SoundDefinition, volume: Float)

/// Load a mono OGG Vorbis file into a static buffer.
/// Mono content is duplicated to stereo.
external 12014 fn load_ogg_vorbis_mono(resource_id: SoundId, sound: SoundDefinition)

/// Load a stereo OGG Vorbis file into a static buffer.
external 12015 fn load_ogg_vorbis_stereo(resource_id: SoundId, sound: SoundDefinition)

/// Load a mono WAV file into a static buffer.
/// Mono content is duplicated to stereo.
external 12016 fn load_wav_mono(resource_id: SoundId, sound: SoundDefinition)

/// Load a stereo WAV file into a static buffer.
external 12017 fn load_wav_stereo(resource_id: SoundId, sound: SoundDefinition)

// === Voice actions ===

/// Trigger a sound at its root note.
///
/// Equivalent to note_on with sound.root_note.
external 12018 fn trig(id: Voice, resource_id: SoundId, volume: Float)

/// Start playback at a specific note.
/// Pitch is transposed relative to sound.root_note.
external 12019 fn note_on(id: Voice, note: Note, resource_id: SoundId, volume: Float)

/// Release a voice into the ADSR release stage.
external 12020 fn note_off(id: Voice)

/// Stop a voice immediately and mark it idle.
external 12021 fn stop(id: Voice)

/// Pause playback without releasing the voice.
external 12022 fn pause(id: Voice)

/// Resume a paused voice from its paused position.
external 12023 fn resume(id: Voice)


// === Query functions ===

/// Get the current state of a voice.
external 12025 fn get_voice_state(id: Voice) -> VoiceState

/// Get current playback position in seconds.
///
/// - Streaming: position within the stream.
/// - Static buffers: elapsed playback time.
external 12026 fn get_playback_time(id: Voice) -> Float

/// Get total duration in seconds.
///
/// - Streaming: total stream duration from metadata.
/// - Static buffers: total buffer duration.
external 12027 fn get_playback_duration(id: Voice) -> Float

/// Get normalized playback progress in the range 0.0..1.0.
///
/// - Streaming: progress through stream.
/// - Static buffers: progress through buffer.
external 12028 fn get_playback_progress(id: Voice) -> Float

/// Get the number of active voices.
/// Active = Playing, Paused, or Releasing.
external 12029 fn get_active_voice_count() -> Int

// === Control functions ===

/// Change voice volume.
/// 0.0 = silent, 1.0 = full scale.
external 12030 fn set_volume(id: Voice, volume: Float)

/// Set stereo pan position.
/// -1.0 = left, 0.0 = center, 1.0 = right.
external 12024 fn set_pan(id: Voice, pan: Float)

/// Change playback rate.
/// 0.5 = half speed, 1.0 = normal, 2.0 = double speed.
external 12031 fn set_playback_rate(id: Voice, playback_rate: Float)
