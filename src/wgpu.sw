//! # WebGPU Library for Lily
//!
//! Render passes, shaders and buffers for [WebGPU](https://en.wikipedia.org/wiki/WebGPU).

// Do not modify this file!

#![api]


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

// TODO: Support Swamp range type directly?
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
    Uint8
    /// Two unsigned bytes (u8). `vec2<u32>` in shaders.
    Uint8x2
    /// Four unsigned bytes (u8). `vec4<u32>` in shaders.
    Uint8x4

    /// One signed byte (i8). `i32` in shaders.
    Sint8
    /// Two signed bytes (i8). `vec2<i32>` in shaders.
    Sint8x2
    /// Four signed bytes (i8). `vec4<i32>` in shaders.
    Sint8x4

    /// One unsigned byte (u8). [0, 255] converted to float [0, 1] `f32` in shaders.
    Unorm8
    /// Two unsigned bytes (u8). [0, 255] converted to float [0, 1] `vec2<f32>` in shaders.
    Unorm8x2
    /// Four unsigned bytes (u8). [0, 255] converted to float [0, 1] `vec4<f32>` in shaders.
    Unorm8x4

    /// One signed byte (i8). [&minus;127, 127] converted to float [&minus;1, 1] `f32` in shaders.
    Snorm8
    /// Two signed bytes (i8). [&minus;127, 127] converted to float [&minus;1, 1] `vec2<f32>` in shaders.
    Snorm8x2
    /// Four signed bytes (i8). [&minus;127, 127] converted to float [&minus;1, 1] `vec4<f32>` in shaders.
    Snorm8x4

    /// One unsigned short (u16). `u32` in shaders.
    Uint16
    /// Two unsigned shorts (u16). `vec2<u32>` in shaders.
    Uint16x2
    /// Four unsigned shorts (u16). `vec4<u32>` in shaders.
    Uint16x4

    /// One signed short (u16). `i32` in shaders.
    Sint16
    /// Two signed shorts (i16). `vec2<i32>` in shaders.
    Sint16x2
    /// Four signed shorts (i16). `vec4<i32>` in shaders.
    Sint16x4

    /// One unsigned short (u16). [0, 65535] converted to float [0, 1] `f32` in shaders.
    Unorm16
    /// Two unsigned shorts (u16). [0, 65535] converted to float [0, 1] `vec2<f32>` in shaders.
    Unorm16x2
    /// Four unsigned shorts (u16). [0, 65535] converted to float [0, 1] `vec4<f32>` in shaders.
    Unorm16x4

    /// One signed short (i16). [&minus;32767, 32767] converted to float [&minus;1, 1] `f32` in shaders.
    Snorm16
    /// Two signed shorts (i16). [&minus;32767, 32767] converted to float [&minus;1, 1] `vec2<f32>` in shaders.
    Snorm16x2
    /// Four signed shorts (i16). [&minus;32767, 32767] converted to float [&minus;1, 1] `vec4<f32>` in shaders.
    Snorm16x4

    /// One single-precision float (f32). `f32` in shaders.
    Float32
    /// Two single-precision floats (f32). `vec2<f32>` in shaders.
    Float32x2
    /// Three single-precision floats (f32). `vec3<f32>` in shaders.
    Float32x3
    /// Four single-precision floats (f32). `vec4<f32>` in shaders.
    Float32x4

    /// One unsigned int (u32). `u32` in shaders.
    Uint32
    /// Two unsigned ints (u32). `vec2<u32>` in shaders.
    Uint32x2
    /// Four unsigned ints (u32). `vec4<u32>` in shaders.
    Uint32x4

    /// One signed int (i32). `i32` in shaders.
    Sint32
    /// Two signed ints (i32). `vec2<i32>` in shaders.
    Sint32x2
    /// Four signed ints (i32). `vec4<i32>` in shaders.
    Sint32x4
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
    R8Unorm
    R8Uint
    Rg8Unorm
    Rgba8Unorm
    Rgba8UnormSrgb
    Rgba8Uint
    Bgra8Unorm
    Bgra8UnormSrgb

    // --- High-Precision 16-bit ---
    R16Float
    R16Uint
    Rg16Float
    Rgba16Float
    Rgba16Uint

    // --- Math & Data 32-bit ---
    R32Float
    R32Uint
    Rg32Float
    Rg32Uint
    Rgba32Float
    Rgba32Uint

    // --- Packed 32-bit ---
    /// 11/11/10 bits for RGB.
    Rg11b10Ufloat
    /// Shared exponent.
    Rgb9e5Ufloat
    /// 10 bits per RGB, 2 bits for Alpha.
    Rgb10a2Unorm

    // --- Depth and Stencil  ---
    Stencil8
    Depth16Unorm

    /// Abstract: Driver picks best 24-bit or 32-bit depth implementation.
    Depth24Plus

    /// Abstract: Driver picks best 24/32-bit depth + 8-bit stencil.
    Depth24PlusStencil8

    /// Maximum precision depth. // maybe only use this?
    Depth32Float

    /// Maximum precision depth + stencil masking.
    Depth32FloatStencil8
}

/// Texture usage flags
enum TextureUsage {
    /// Can be rendered to
    RenderAttachment
    /// Can be sampled in shaders
    TextureSampling // TODO: Sometimes called TextureBinding, which one is more correct?
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
    vertex: Range
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

const MAX_RENDER_PASS_ENTRIES = 2048

/// Builder for recording draw commands for a render pass.
///
/// Configure attachments, then record state changes and draw calls in order.
/// Submit the finished pass with [`add_pass`].
struct RenderPass {
    entries: Vec<Entry; MAX_RENDER_PASS_ENTRIES>
    /// Color attachments to render to. If empty, renders to screen
    color_attachments: Vec<ColorAttachment; 8> // For now, do not increase this above 8. It is the same as the guarantee of WebGPU.
    /// Optional depth attachment. Set to -1 for none. TODO: Should probably be proper handle or optional?
    depth_attachment: Int
}


impl RenderPass {
    // === Attachments ===

    /// Adds a [`ColorAttachment`] to render into.
    ///
    /// If no color attachments are set, the pass renders to the screen.
    fn add_color_attachment(mut self, attachment: ColorAttachment) {
        self.color_attachments.push(attachment)
    }

    /// Sets the depth attachment for depth testing using a [`TextureViewHandle`].
    fn set_depth_attachment(mut self, depth_view: TextureViewHandle) {
        self.depth_attachment = depth_view
    }

    // === Pipeline State ===

    /// Sets the active [`RenderPipelineHandle`] for upcoming draw calls.
    fn set_pipeline(mut self, pipeline: RenderPipelineHandle) {
        self.entries.push( SetPipeline(pipeline) )
    }

    /// Sets the [`Viewport`] for future draw calls.
    fn set_viewport(mut self, viewport: Viewport) {
        self.entries.push( SetViewport(viewport) )
    }

    /// Clips rendering to a [`ScissorRect`].
    fn set_scissor_rect(mut self, rect: ScissorRect) {
        self.entries.push( SetScissorRect(rect) )
    }

    /// Sets the stencil reference value for stencil testing.
    fn set_stencil_reference(mut self, reference_value: Int) {
        self.entries.push( SetStencilReference( { value: reference_value } ) )
    }

    // === Buffers & Resources ===

    /// Binds a [`BindGroupHandle`] at `group_index` for future draw calls.
    ///
    /// `group_index` is the bind group slot, the `@group(N)` in WGSL and the
    /// position of that group's layout in the array passed to [`create_pipeline_layout`].
    // TODO: index should be U32,
    fn set_bind_group(mut self, group_index: Int, bind_group: BindGroupHandle) {
        self.entries.push( SetBindGroup( { index: group_index, group: bind_group } ) )
    }

    /// Sets the [`BufferHandle`] at vertex buffer slot.
    ///
    /// `slot` is the index of the [`VertexBufferLayout`] in
    /// [`create_render_pipeline`].
    fn set_vertex_buffer(mut self, slot: Int, vertex_buffer: BufferHandle) {
        self.entries.push( SetVertexBuffer( { slot: slot, buffer: vertex_buffer } ) )
    }

    /// Sets the index [`BufferHandle`] for indexed drawing.
    ///
    /// Only buffers created with [`create_index_buffer_u16`] are supported.
    // TODO: Only one index buffer supported now (U16)
    fn set_index_buffer(mut self, index_buffer: BufferHandle) {
        self.entries.push( SetIndexBuffer( { buffer: index_buffer } ) )
    }

    // === Draw ===

    /// Draws vertices without an index buffer. Prefer [`draw_indexed`] if possible.
    ///
    /// `vertex_range` selects vertices by [`Range`] (start and count).
    /// `instance_range` selects instances the same way. Use `count: 1` for a single draw.
    fn draw(mut self, vertex_range: Range, instance_range: Range ) {
        self.entries.push( Draw( { vertex: vertex_range, instance: instance_range } ) )
    }

    /// Draws indexed geometry using the index buffer set by [`RenderPass::set_index_buffer`].
    ///
    /// `index_range` selects indices by [`Range`] (start and ocunt).
    /// `instance_range` selects instances the same way. Use `count: 1` for a single draw.
    fn draw_indexed(mut self, index_range: Range, instance_range: Range)  {
        self.entries.push( DrawIndexed( { index: index_range, instance: instance_range } ) )
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

/// One resource slot in a bind group layout.
struct BindGroupLayoutEntry {
    /// Binding index within the group. Matches `@binding(N)` in WGSL.
    binding: Int
    // TODO: visibility: ShaderStages
    ty: BindingType
}

struct VertexAttribute {
    offset: Int
    /// Vertex input shader location. Matches `@location(N)` in the vertex shader.
    location: Int // TODO: maybe shader_location. or is that too long?
    format: VertexFormat
}

struct VertexBufferLayout {
    array_stride: Int
    vertex_attribute: Block<VertexAttribute; 32>
    vertex_attribute_count: Int
    step_mode: VertexStepMode
}

impl BufferHandle {
    /// Writes all elements of `data` into the GPU buffer starting at element `0`.
    external 911 fn write(mut self, data: Any)

    /// Writes all elements of `data` into the GPU buffer starting at `dest_element_offset`.
    ///
    /// (for example one element per entry in `Block<Vertex; N>`).
    /// For a sub-range, use [`BufferHandle::write_at`].
    external 915 fn write_with(mut self, dest_element_offset: Int, data: Any)

    /// Writes `element_count` elements of `data` into the GPU buffer.
    ///
    /// Copies elements `[data_element_offset .. data_element_offset + element_count)` from `data`
    /// into the GPU buffer starting at element `dest_element_offset`.
    external 917 fn write_at(
        mut self,
        dest_element_offset: Int,
        data: Any,
        data_element_offset: Int,
        element_count: Int
    )
}


// Internal
external 900 fn create_index_buffer_u16(buffer: Any, description: String) -> BufferHandle
external 901 fn create_vertex_buffer(buffer: Any, description: String) -> BufferHandle

/// Creates an empty GPU buffer without initial data.
external 914 fn create_buffer(size: Int, usage: BufferUsage, description: String) -> BufferHandle

/// Creates a bind group instance for a layout from [`create_bind_group_layout`].
///
/// `entries` are assigned to `@binding(0)`, `@binding(1)`, … in array order.
/// Keep that order aligned with the layout entries and their [`BindGroupLayoutEntry::binding`] values.
external 902 fn create_bind_group(bind_group_layout: BindGroupLayoutHandle, entries: [BindGroupEntry], description: String) -> BindGroupHandle
external 903 fn create_sampler(config: SamplerConfig, description: String) -> SamplerHandle

/// Creates a texture that can be used as a render target or for sampling
external 912 fn create_texture(width: Int, height: Int, format: TextureFormat, usage: TextureUsage, description: String) -> TextureHandle
external 920 fn create_texture_png(image: Image, format: TextureFormat, usage: TextureUsage, description: String) -> TextureHandle

/// Creates a view into a texture for rendering or sampling
external 913 fn create_texture_view(texture: TextureHandle, description: String) -> TextureViewHandle

/// Updates texture data without recreating the whole texture
external 916 fn write_texture(texture: TextureHandle, data: Any, width: Int, height: Int)

/// Describes the resources at each [`BindGroupLayoutEntry::binding`] within one bind group.
external 906 fn create_bind_group_layout(entries: [BindGroupLayoutEntry], description: String) -> BindGroupLayoutHandle

/// Creates a pipeline layout from bind group layouts in group-index order.
///
/// The first layout is group index `0` (`@group(0)`), the second is `1`, and so on.
external 907 fn create_pipeline_layout(groups: [BindGroupLayoutHandle], description: String) -> PipelineLayoutHandle

/// Creates a render pipeline
external 908 fn create_render_pipeline(layout: PipelineLayoutHandle, buffers: [VertexBufferLayout], shader_module: Shader, blend_mode: BlendMode, cull_mode: CullMode, enable_depth: Bool, description: String) -> RenderPipelineHandle

/// Submits a render pass for execution
external 905 fn add_pass(pass: RenderPass, description: String)

external 910 fn create_uniform_buffer(buffer: Any, description: String) -> BufferHandle

/// The size of the renderable surface. Return (Width, Height).
external 990 fn surface_extent() -> (Int, Int)
