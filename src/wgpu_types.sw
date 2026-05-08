//! # WebGPU shared basic types
//!
//! Types that are common to refer to, `Vec2f`, `Vec4f` and `Mat4f`
//!
struct Vec2f {
    x: F32
    y: F32
}


struct Vec4f {
    x: F32
    y: F32
    z: F32
    w: F32
}

struct Mat4f {
    v: Block<Vec4f; 4> // column based
}
