//! Graphics and Rendering Math library (mainly for WebGPU).
//!
//! ⚠️ WARNING: NOT CROSS-PLATFORM BITWISE DETERMINISTIC
//!
//! This library does NOT produce bitwise-identical results across platforms.
//!
//! The same code with the same inputs is likely to produce different results on
//! different machines (x86, Arm, WASM, etc.).
//!
//! Cross-platform divergence can be caused by:
//!
//! - Platform-specific SIMD optimizations
//! - Instruction selection, evaluation order, and FMA (fused multiply-add)
//! - Platform/libm differences in internal transcendental functions
//! - Denormal/subnormal handling and flush-to-zero (used sometimes for performance)
//! - NaN and signed-zero edge-case differences
//! - Approximation algorithms used by optimized math paths
//! - Compiler/backend/version-specific optimizations
//!
//! You MUST NOT use this library for:
//!
//! - Physics simulation
//! - Gameplay logic
//! - Lockstep or rollback networking
//! - Replay or re-simulation systems
//! - Serialization (can be accidentily used by gameplay, physics or used by other devices)
//!
//! Conventions:
//!
//! - Angles are in radians.
//! - Matrices are column-major.
//!
//! References:
//!
//! - [Transcendental function](https://en.wikipedia.org/wiki/Transcendental_function)
//! - [Fused multiply-add (FMA)](https://en.wikipedia.org/wiki/Multiply-accumulate_operation#Fused_multiply-add)
//! - [Flush-to-zero (FTZ) and denormals](https://en.wikipedia.org/wiki/Subnormal_number)
//! - [NaN (not-a-number)](https://en.wikipedia.org/wiki/NaN)
//! - [Signed zero](https://en.wikipedia.org/wiki/Signed_zero)
//! - [Quaternion](https://en.wikipedia.org/wiki/Quaternion)
//! - [Matrix (mathematics)](https://en.wikipedia.org/wiki/Matrix_(mathematics))
//! - [Orthographic projection](https://en.wikipedia.org/wiki/Orthographic_projection)
//! - [Linear interpolation (lerp)](https://en.wikipedia.org/wiki/Linear_interpolation)
//! - [Slerp (spherical linear interpolation)](https://en.wikipedia.org/wiki/Slerp)

#![api]

use lily::wgpu_types::{Mat4f}

/// 2D vector.
struct Vec2 {
    secret: Block<U8; 8> // Intentionally opaque storage
}

impl Vec2 {
    // === Construction ===

    /// Return a new 2D vector
    external 11100 fn new(x: Float, y: Float) -> Vec2

    // === Components ===

    /// Return the x component
    external 11108 fn x(self) -> Float

    /// Return the y component
    external 11109 fn y(self) -> Float

    // === Properties ===

    /// Return the magnitude (length) of the vector
    external 11101 fn magnitude(self) -> Float

    // === Transformation ===

    /// Return a normalized (unit length) vector.
    ///
    /// Behavior is undefined if the input has zero magnitude.
    external 11102 fn normalize(self) -> Vec2

    // === Operators ===

    /// Add two vectors
    external 11103 fn add(self, other: Vec2) -> Vec2

    /// Subtract two vectors
    external 11104 fn sub(self, other: Vec2) -> Vec2

    /// Compute the dot product of two vectors
    external 11105 fn dot(self, other: Vec2) -> Float

    // === Interpolation ===

    /// Linear interpolation between two vectors.
    ///
    /// `t = 0.0` returns `self`.
    /// `t = 1.0` returns `other`.
    external 11106 fn lerp(self, other: Vec2, t: Float) -> Vec2

    /// Distance between two points
    external 11107 fn distance(self, other: Vec2) -> Float

    // === Debug ===

    /// Convert vector to string for debugging
    external 11199 fn string(self) -> String
}

/// 3D vector.
struct Vec3 {
    secret: Block<U8; 12> // Intentionally opaque storage
}

impl Vec3 {
    // === Construction ===

    /// Return a new 3D vector
    external 11200 fn new(x: Float, y: Float, z: Float) -> Vec3

    // === Components ===

    /// Return the x component
    external 11208 fn x(self) -> Float

    /// Return the y component
    external 11209 fn y(self) -> Float

    /// Return the z component
    external 11210 fn z(self) -> Float

    // === Query ===

    /// Return the magnitude (length) of the vector
    external 11201 fn magnitude(self) -> Float

    // === Transformation ===

    /// Return a normalized (unit magnitude) vector.
    ///
    /// Behavior is undefined if the input has zero magnitude.
    external 11202 fn normalize(self) -> Vec3

    // === Operators ===

    /// Add two vectors
    external 11203 fn add(self, other: Vec3) -> Vec3

    /// Subtract two vectors
    external 11204 fn sub(self, other: Vec3) -> Vec3

    /// Compute the dot product of two vectors
    external 11205 fn dot(self, other: Vec3) -> Float

    // === Interpolation ===

    /// Linear interpolation between two vectors.
    ///
    /// `t = 0.0` returns `self`.
    /// `t = 1.0` returns `other`.
    external 11206 fn lerp(self, other: Vec3, t: Float) -> Vec3

    /// Distance between two points
    external 11207 fn distance(self, other: Vec3) -> Float

    // === Debug ===

    /// Convert vector to string for debugging
    external 11299 fn string(self) -> String
}

/// 3x3 column-major matrix.
struct Mat3 {
    secret: Block<U8; 36>
}

impl Mat3 {
    // === Construction ===

    /// Return an identity matrix
    external 11300 fn identity() -> Mat3

    // === Operators ===

    /// Multiply (compose) two matrices.
    ///
    /// Multiplication order matters.
    external 11301 fn mul(self, other: Mat3) -> Mat3

    // === Debug ===

    /// Convert matrix to string for debugging
    external 11399 fn string(self) -> String
}

/// 4D vector.
#[repr(align(16))]
struct Vec4 {
    secret: Block<U8; 16> // Intentionally opaque storage
}

impl Vec4 {
    // === Construction ===

    /// Return a new 4D vector
    external 11400 fn new(x: Float, y: Float, z: Float, w: Float) -> Vec4

    // === Components ===

    /// Return the x component
    external 11401 fn x(self) -> Float

    /// Return the y component
    external 11402 fn y(self) -> Float

    /// Return the z component
    external 11403 fn z(self) -> Float

    /// Return the w component
    external 11404 fn w(self) -> Float

    // === Debug ===

    /// Convert vector to string for debugging
    external 11499 fn string(self) -> String
}

/// Quaternion for 3D rotations
#[repr(align(16))]
struct Quat {
    secret: Block<U8; 16>
}

impl Quat {
    // === Construction ===

    /// Return an identity quaternion (no rotation)
    external 11500 fn identity() -> Quat

    /// Return a quaternion from rotation around Z axis
    external 11501 fn from_rotation_z(radians: Float) -> Quat

    /// Return a quaternion from rotation around X axis
    external 11502 fn from_rotation_x(radians: Float) -> Quat

    /// Return a quaternion from rotation around Y axis
    external 11503 fn from_rotation_y(radians: Float) -> Quat

    // === Components ===

    /// Return the x component
    external 11509 fn x(self) -> Float

    /// Return the y component
    external 11510 fn y(self) -> Float

    /// Return the z component
    external 11511 fn z(self) -> Float

    /// Return the w component
    external 11512 fn w(self) -> Float

    // === Transformation ===

    /// Return a normalized (unit magnitude) quaternion
    ///
    /// Behavior is undefined if the input has zero magnitude.
    external 11506 fn normalize(self) -> Quat

    /// Return the inverse (opposite) rotation.
    ///
    /// Behavior is undefined if the quaternion has zero magnitude.
    external 11507 fn inverse(self) -> Quat

    // === Operators ===

    /// Multiply (compose) two quaternions.
    ///
    /// Think of this as combining an existing rotation with an additional
    /// "delta" rotation.
    ///
    /// Multiplication order matters and is not commutative.
    external 11504 fn mul(self, other: Quat) -> Quat

    // === Interpolation ===

    /// Return the spherical linear interpolation between `self` and `other`.
    ///
    /// `t = 0.0` returns `self`.
    /// `t = 1.0` returns `other`.
    external 11505 fn slerp(self, other: Quat, t: Float) -> Quat

    /// Normalized linear interpolation (`nlerp`).
    ///
    /// Typically faster than `slerp`, but does not result in constant angular
    /// velocity.
    ///
    /// Use it for small angular differences or when interpolating frequently
    ///  (e.g. per frame), as it is faster and looks similar to `slerp`.
    ///
    /// `t = 0.0` returns `self`.
    /// `t = 1.0` returns `other`.
    external 11513 fn nlerp(self, other: Quat, t: Float) -> Quat

    // === Debug ===

    /// Convert quaternion to string for debugging
    external 11599 fn string(self) -> String
}

struct Vec4f {
    x: F32
    y: F32
    z: F32
    w: F32
}

/// 4x4 column-major matrix.
#[repr(align(16))]
struct Mat4 {
    secret: Block<U8; 64>
}

impl Mat4 {
    // === Construction ===

    /// Return an identity matrix (no transformation)
    external 11613 fn identity() -> Mat4

    /// Return an orthographic projection matrix for 2D (Y-down).
    ///
    /// `width` and `height` are viewport dimensions in pixels.
    /// `zoom` must be positive.
    external 11600 fn ortho_2d_y_down_int(width: Int, height: Int, zoom: Float) -> Mat4

    /// Return a translation matrix
    external 11601 fn from_translation(translation: Vec3) -> Mat4

    /// Return a rotation matrix around Z axis (2D rotation)
    external 11603 fn from_rotation_z(radians: Float) -> Mat4

    /// Return a rotation matrix from a quaternion
    external 11612 fn from_quat(rotation: Quat) -> Mat4

    /// Return a scale matrix
    external 11604 fn from_scale(scale: Vec3) -> Mat4

    /// Return a transform from rotation and translation (no scale)
    external 11614 fn from_rotation_translation(rotation: Quat, translation: Vec3) -> Mat4

    /// Return a full transform from scale, rotation and translation
    external 11615 fn from_scale_rotation_translation(scale: Vec3, rotation: Quat, translation: Vec3) -> Mat4

    // === Operators ===

    /// Multiply (compose) two matrices.
    ///
    /// Multiplication order matters.
    ///
    /// `A * B` and `B * A` (usually) produce different results.
    /// For example, rotate-then-translate is different from
    /// translate-then-rotate.
    ///
    /// Build projection `P` once (for the viewport), build model `M` per object
    /// (for example, a translation), then multiply `P * V * M`.
    ///
    /// This applies object/world transform first, then projection to clip space.
    ///
    /// MVP convention:
    ///
    /// - `M` (Model): object local space -> world space
    /// - `V` (View): world space -> camera/view space
    /// - `P` (Projection): maps view space -> clip space and encodes projection
    /// (aspect ratio and orthographic/perspective)
    external 11602 fn mul(self, other: Mat4) -> Mat4

    // === Components ===

    /// Return the translation component (same as w_axis)
    external 11607 fn translation(self) -> Vec3

    /// Return the first column vector
    external 11608 fn x_axis(self) -> Vec3

    /// Return the second column vector
    external 11609 fn y_axis(self) -> Vec3

    /// Return the third column vector
    external 11610 fn z_axis(self) -> Vec3

    /// Return the fourth column vector (translation)
    external 11611 fn w_axis(self) -> Vec3

    // === Decomposition ===

    /// Decompose transform into scale, rotation and translation.
    external 11616 fn to_scale_rotation_translation(self) -> (Vec3, Quat, Vec3)

    // === Utilities ===

    /// Convert to WebGPU type Mat4f (array of 16 F32)
    external 11605 fn to_mat4f(self) -> Mat4f

    /// Calculate the inverse matrix.
    ///
    /// Behavior is undefined for non-invertible (singular) matrices.
    /// (e.g. when zero or close to zero scale on any axis)
    external 11606 fn inverse(self) -> Mat4

    /// Transpose the matrix (swap rows and columns)
    external 11617 fn transpose(self) -> Mat4

    // === Debug ===

    /// Convert matrix to string for debugging.
    ///
    /// Do not rely on the string being formatted in a specific way.
    external 11699 fn string(self) -> String
}
