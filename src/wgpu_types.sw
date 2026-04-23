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
