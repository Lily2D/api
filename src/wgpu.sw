#![api]

///
/// [WebGPU](https://en.wikipedia.org/wiki/WebGPU) abstraction module. Do not modify this file!
///


#[extensions("wgsl")]
struct ShaderTag {}
type Shader = Res<ShaderTag>

#[extensions("png")]
struct ImageTag {}
type Image = Res<ImageTag>

enum LayoutEntryType {
    Buffer
    Sample
    Texture
    StorageTexture
    External // TODO: What is external?
}

struct LayoutEntry {
}

// TODO: The layout is almost like setting a struct. Should probably be struct like definition in swamp
struct Layout {
    entries: Vec<LayoutEntry; 32>
}



struct Range {
    start: Int
    count: Int
}

/// Viewport for rendering to a region of the render target
struct Viewport {
    x: F32
    y: F32
    width: F32
    height: F32
    min_depth: F32
    max_depth: F32
}

/// Scissor rectangle for clipping rendering to a region
struct ScissorRect {
    x: Int
    y: Int
    width: Int
    height: Int
}

/// Stencil reference value for stencil testing
struct StencilReference {
    value: Int
}


type BufferHandle = Int
type SamplerHandle = Int
type TextureHandle = Int
type TextureViewHandle = Int
type BindGroupHandle = Int
type BindGroupLayoutHandle = Int
type PipelineLayoutHandle = Int
type RenderPipelineHandle = Int
type ShaderModuleHandle = Int

/// Vertex attribute format
enum VertexFormat {
    /// One unsigned byte (u8). `u32` in shaders.
    Uint8,
    /// Two unsigned bytes (u8). `vec2<u32>` in shaders.
    Uint8x2 ,
    /// Four unsigned bytes (u8). `vec4<u32>` in shaders.
    Uint8x4,

    /// One signed byte (i8). `i32` in shaders.
    Sint8,
    /// Two signed bytes (i8). `vec2<i32>` in shaders.
    Sint8x2,
    /// Four signed bytes (i8). `vec4<i32>` in shaders.
    Sint8x4,

    /// One unsigned byte (u8). [0, 255] converted to float [0, 1] `f32` in shaders.
    Unorm8 ,
    /// Two unsigned bytes (u8). [0, 255] converted to float [0, 1] `vec2<f32>` in shaders.
    Unorm8x2,
    /// Four unsigned bytes (u8). [0, 255] converted to float [0, 1] `vec4<f32>` in shaders.
    Unorm8x4,

    /// One signed byte (i8). [&minus;127, 127] converted to float [&minus;1, 1] `f32` in shaders.
    Snorm8,
    /// Two signed bytes (i8). [&minus;127, 127] converted to float [&minus;1, 1] `vec2<f32>` in shaders.
    Snorm8x2,
    /// Four signed bytes (i8). [&minus;127, 127] converted to float [&minus;1, 1] `vec4<f32>` in shaders.
    Snorm8x4,

    /// One unsigned short (u16). `u32` in shaders.
    Uint16,
    /// Two unsigned shorts (u16). `vec2<u32>` in shaders.
    Uint16x2,
    /// Four unsigned shorts (u16). `vec4<u32>` in shaders.
    Uint16x4,

    /// One signed short (u16). `i32` in shaders.
    Sint16,
    /// Two signed shorts (i16). `vec2<i32>` in shaders.
    Sint16x2,
    /// Four signed shorts (i16). `vec4<i32>` in shaders.
    Sint16x4,

    /// One unsigned short (u16). [0, 65535] converted to float [0, 1] `f32` in shaders.
    Unorm16,
    /// Two unsigned shorts (u16). [0, 65535] converted to float [0, 1] `vec2<f32>` in shaders.
    Unorm16x2,
    /// Four unsigned shorts (u16). [0, 65535] converted to float [0, 1] `vec4<f32>` in shaders.
    Unorm16x4,

    /// One signed short (i16). [&minus;32767, 32767] converted to float [&minus;1, 1] `f32` in shaders.
    Snorm16,
    /// Two signed shorts (i16). [&minus;32767, 32767] converted to float [&minus;1, 1] `vec2<f32>` in shaders.
    Snorm16x2,
    /// Four signed shorts (i16). [&minus;32767, 32767] converted to float [&minus;1, 1] `vec4<f32>` in shaders.
    Snorm16x4,

    /// One single-precision float (f32). `f32` in shaders.
    Float32,
    /// Two single-precision floats (f32). `vec2<f32>` in shaders.
    Float32x2,
    /// Three single-precision floats (f32). `vec3<f32>` in shaders.
    Float32x3,
    /// Four single-precision floats (f32). `vec4<f32>` in shaders.
    Float32x4,

    /// One unsigned int (u32). `u32` in shaders.
    Uint32,
    /// Two unsigned ints (u32). `vec2<u32>` in shaders.
    Uint32x2,
    /// Four unsigned ints (u32). `vec4<u32>` in shaders.
    Uint32x4,

    /// One signed int (i32). `i32` in shaders.
    Sint32,
    /// Two signed ints (i32). `vec2<i32>` in shaders.
    Sint32x2,
    /// Four signed ints (i32). `vec4<i32>` in shaders.
    Sint32x4,
}

enum VertexStepMode {
    Vertex
    Instance
}

/// Texture address mode for sampling outside [0, 1] range
enum AddressMode {
    /// Repeat the texture
    Repeat
    /// Clamp to edge pixel
    ClampToEdge
    /// Mirror and repeat
    MirrorRepeat
}

/// Texture filtering mode
enum FilterMode {
    /// Nearest neighbor (pixelated)
    Nearest
    /// Linear interpolation (smooth)
    Linear
}

/// Sampler configuration for texture sampling
struct SamplerConfig {
    address_mode: AddressMode
    mag_filter: FilterMode
    min_filter: FilterMode
}

/// Blend mode for rendering
enum BlendMode {
    /// Standard alpha blending (src_alpha, one_minus_src_alpha)
    Alpha
    /// Additive blending (one, one)
    Additive
    /// Premultiplied alpha (one, one_minus_src_alpha)
    PremultipliedAlpha
    /// No blending (opaque)
    Opaque
}

/// Face culling mode
enum CullMode {
    /// No culling (render both sides)
    None
    /// Cull front faces
    Front
    /// Cull back faces (default for solid objects)
    Back
}

/// Texture format for render targets and textures
enum TextureFormat {
    // --- Standard 8-bit ---
    R8Unorm,
    R8Uint,
    Rg8Unorm,
    Rgba8Unorm,
    Rgba8UnormSrgb,
    Rgba8Uint,
    Bgra8Unorm,
    Bgra8UnormSrgb,

    // --- High-Precision 16-bit ---
    R16Float,
    R16Uint,
    Rg16Float,
    Rgba16Float,
    Rgba16Uint,

    // --- Math & Data 32-bit ---
    R32Float,
    R32Uint,
    Rg32Float,
    Rg32Uint,
    Rgba32Float,
    Rgba32Uint,

    // --- Packed 32-bit ---
    /// 11/11/10 bits for RGB.
    Rg11b10Ufloat,
    /// Shared exponent.
    Rgb9e5Ufloat,
    /// 10 bits per RGB, 2 bits for Alpha.
    Rgb10a2Unorm,

    // --- Depth and Stencil  ---
    Stencil8,
    Depth16Unorm,

    /// Abstract: Driver picks best 24-bit or 32-bit depth implementation.
    Depth24Plus,

    /// Abstract: Driver picks best 24/32-bit depth + 8-bit stencil.
    Depth24PlusStencil8,

    /// Maximum precision depth. // maybe only use this?
    Depth32Float,

    /// Maximum precision depth + stencil masking.
    Depth32FloatStencil8,
}

/// Texture usage flags
enum TextureUsage {
    /// Can be rendered to
    RenderAttachment
    /// Can be sampled in shaders
    TextureSampling
    /// Both render target and texture sampling
    RenderAndSample
}

/// Buffer usage flags
enum BufferUsage {
    /// For vertex data
    Vertex
    /// For index data
    Index
    /// For uniform/constant data
    Uniform
    /// For storage buffers
    Storage
}

struct SetBindGroup {
    index: Int // TODO: should be U32
    group: BindGroupHandle
}

struct DrawIndexed {
    index: Range
    instance: Range
}

// should probably not use this?
struct Draw {
    index: Range
    instance: Range
}

struct SetIndexBuffer {
    buffer: BufferHandle
}

struct SetVertexBuffer {
    slot: Int
    buffer: BufferHandle
}

enum Entry {
    SetIndexBuffer SetIndexBuffer
    SetVertexBuffer SetVertexBuffer
    SetBindGroup SetBindGroup
    DrawIndexed DrawIndexed
    Draw Draw
    SetPipeline RenderPipelineHandle
    SetViewport Viewport
    SetScissorRect ScissorRect
    SetStencilReference StencilReference
}

/// Clear Color for a render pass
struct ClearColor {
    r: F32
    g: F32
    b: F32
    a: F32
}

/// Describes a color attachment for rendering
struct ColorAttachment {
    /// The texture view to render to
    view: TextureViewHandle

    clear_color: ClearColor
    should_clear: Bool  // TODO: Maybe optional? or is it better to have a bool?
}

struct RenderPass {
    entries: Vec<Entry; 128>
    /// Color attachments to render to. If empty, renders to screen
    color_attachments: Vec<ColorAttachment; 8> // For now, do not increase this above 8. It is the same as the guarantee of WebGPU.
    /// Optional depth attachment. Set to -1 for none. TODO: Should probably be proper handle or optional?
    depth_attachment: Int
}


impl RenderPass {
    fn set_bind_group(mut self, set_group: SetBindGroup) {
        self.entries.push( SetBindGroup(set_group) )
    }

    fn set_index_buffer(mut self, index_buffer: SetIndexBuffer) {
        self.entries.push( SetIndexBuffer(index_buffer) )
    }

    fn set_vertex_buffer(mut self, vertex_buffer: SetVertexBuffer) {
        self.entries.push( SetVertexBuffer(vertex_buffer) )
    }

    fn draw(mut self, draw: Draw) {
        self.entries.push( Draw(draw) )
    }

    fn draw_indexed(mut self, draw_indexed: DrawIndexed)  {
        self.entries.push( DrawIndexed(draw_indexed) )
    }

    fn set_pipeline(mut self, handle: RenderPipelineHandle) {
        self.entries.push( SetPipeline(handle) )
    }

    /// If no color attachments are set, defaults to rendering to the screen
    fn add_color_attachment(mut self, attachment: ColorAttachment) {
        self.color_attachments.push(attachment)
    }

    /// Sets the depth attachment for depth testing
    fn set_depth_attachment(mut self, depth_view: TextureViewHandle) {
        self.depth_attachment = depth_view
    }

    fn set_scissor_rect(mut self, rect: ScissorRect) {
        self.entries.push( SetScissorRect(rect) )
    }

    fn set_viewport(mut self, viewport: Viewport) {
        self.entries.push( SetViewport(viewport) )
    }

    fn set_stencil_reference(mut self, reference: StencilReference) {
        self.entries.push( SetStencilReference(reference) )
    }
}


// The group is almost as setting the instance values for that struct
enum BindGroupEntry {
    Buffer BufferHandle
    TextureView TextureViewHandle
    Sampler SamplerHandle
}

enum BufferBindingType {
    Uniform
    Storage { read_only: Bool }
}

enum BindingType {
    Buffer BufferBindingType
    Sampler
    Texture
    StorageTexture
}

struct BindGroupLayoutEntry {
    binding: Int
    // TODO: visibility: ShaderStages
    ty: BindingType
}

struct VertexAttribute {
    offset: Int
    location: Int
    format: VertexFormat
}

struct VertexBufferLayout {
    array_stride: Int
    vertex_attribute: Block<VertexAttribute; 32>
    vertex_attribute_count: Int
    step_mode: VertexStepMode
}

impl BufferHandle {
    external 911 fn write(mut self, buffer: Any)

    /// Write data to a portion of the buffer at a specific offset
    external 915 fn write_with(mut self, offset: Int, buffer: Any)
}


// Internal
external 900 fn create_index_buffer_u16(buffer: Any, description: String) -> BufferHandle
external 901 fn create_vertex_buffer(buffer: Any, description: String) -> BufferHandle

/// Creates an empty GPU buffer without initial data.
external 914 fn create_buffer(size: Int, usage: BufferUsage, description: String) -> BufferHandle

external 902 fn create_bind_group(bind_group_layout: BindGroupLayoutHandle, entries: [BindGroupEntry], description: String) -> BindGroupHandle
external 903 fn create_sampler(config: SamplerConfig, description: String) -> SamplerHandle

/// Creates a texture that can be used as a render target or for sampling
external 912 fn create_texture(width: Int, height: Int, format: TextureFormat, usage: TextureUsage, description: String) -> TextureHandle
external 920 fn create_texture_png(image: Image, format: TextureFormat, usage: TextureUsage, description: String) -> TextureHandle

/// Creates a view into a texture for rendering or sampling
external 913 fn create_texture_view(texture: TextureHandle, description: String) -> TextureViewHandle

/// Updates texture data without recreating the whole texture
external 916 fn write_texture(texture: TextureHandle, data: Any, width: Int, height: Int)

external 906 fn create_bind_group_layout(entries: [BindGroupLayoutEntry], description: String) -> BindGroupLayoutHandle
external 907 fn create_pipeline_layout(groups: [BindGroupLayoutHandle], description: String) -> PipelineLayoutHandle

/// Creates a render pipeline
external 908 fn create_render_pipeline(layout: PipelineLayoutHandle, buffers: [VertexBufferLayout], shader_module: Shader, blend_mode: BlendMode, cull_mode: CullMode, enable_depth: Bool, description: String) -> RenderPipelineHandle

/// Submits a render pass for execution
external 905 fn add_pass(pass: RenderPass, description: String)

external 910 fn create_uniform_buffer(buffer: Any, description: String) -> BufferHandle

/// The size of the renderable surface. Return (Width, Height).
external 990 fn surface_extent() -> (Int, Int)
