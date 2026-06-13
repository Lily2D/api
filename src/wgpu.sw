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
///
/// The list is intended to be a minimal list of things that are broadly
/// supported in Metal, Vulkan, and DX12.
///
/// It should also not include formats that cannot (or I don't want to) be supported in Swamp,
/// such as half-floats (float16) and 64-bit formats (Swamp is 32-bit).
///
/// And no obscure packed and normalized formats (e.g. unorm_10_10_10_2).
///
/// `Unorm*` expands to floats in `[0.0, 1.0]`, and `Snorm*` expands to floats in `[-1.0, 1.0]`.
enum VertexFormat {
    // 8 bits
    Uint8
    Sint8
    Unorm8
    Snorm8

    // 16 bits
    Uint8x2
    Sint8x2
    Unorm8x2
    Snorm8x2
    Uint16
    Sint16
    Unorm16
    Snorm16

    // 32 bits
    Uint8x4
    Sint8x4
    Unorm8x4
    Snorm8x4
    Uint16x2
    Sint16x2
    Unorm16x2
    Snorm16x2
    Float32
    Uint32
    Sint32

    // 64 bits
    Uint16x4
    Sint16x4
    Unorm16x4
    Snorm16x4
    Float32x2
    Uint32x2
    Sint32x2

    // 96 bits
    Float32x3
    Uint32x3
    Sint32x3

    // 128 bits
    Float32x4
    Uint32x4
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

/// vertices into geometry
enum PrimitiveTopology {
    PointList
    LineList
    LineStrip
    // Very useful for 2D and Quads.
    TriangleList
    TriangleStrip
}

/// Comparison function used for depth testing
enum CompareFunction {
    Never
    Less
    LessEqual
    Greater
    GreaterEqual
    Always

    // NOTE: Do not support Equal, and NotEqual. They have performance problems as well as stability problems
}


/// Texture format for textures that are sampled (read).
enum SampledTextureFormat {
    R8Unorm
    Rgba8Unorm
    Rgba8UnormSrgb
    Rgba16Float
}

/// Texture format for color attachments.
enum RenderTextureFormat {
    R8Unorm
    Rgba8Unorm
    Rgba8UnormSrgb
    Rgba16Float
    R32Uint
}

/// Texture format for storage textures.
enum StorageTextureFormat {
    Rgba8Unorm // can be *either* read or write
    Rgba16Float // can be *either* read or write
    R32Uint // can be both read and write
}

/// Texture format for depth/stencil attachments.
///
/// `Depth24Plus` is guaranteed to be at least 24 bits
enum DepthTextureFormat {
    Depth24Plus
    Depth24PlusStencil8
    Depth32Float
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

/// Options for creating render pipeline.
struct RenderPipelineOptions {
    blend_mode: BlendMode
    cull_mode: CullMode
    enable_depth: Bool
    topology: PrimitiveTopology
    depth_format: DepthTextureFormat
    depth_write_enabled: Bool
    depth_compare: CompareFunction
    depth_bias_constant: Int
    depth_bias_slope_scale: F32
    depth_bias_clamp: F32
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
    /// Clear depth value when `depth_should_clear` is true
    depth_clear_value: F32
    depth_should_clear: Bool
    /// If true, store depth results after the pass
    depth_store: Bool
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
    fn set_depth_attachment(mut self, depth_view: TextureViewHandle) { // TODO: should be DepthViewHandle in the future
        self.depth_attachment = depth_view
        self.depth_should_clear = true
        self.depth_clear_value = 1.0
        self.depth_store = true
    }

    /// Configures depth load/store.
    fn set_depth_ops(mut self, should_clear: Bool, clear_value: F32, store: Bool) {
        self.depth_should_clear = should_clear
        self.depth_clear_value = clear_value
        self.depth_store = store
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

/// Access mode for storage texture bindings
enum StorageTextureAccess {
    WriteOnly
    ReadOnly
    ReadWrite
}

/// Configuration for a storage texture binding in a bind group layout.
///
/// TODO: Texture bindings use D2 dimensions only for now. @catnipped will determine when cube maps, texture arrays, or 3D volumes are needed.
struct StorageTextureBindingType {
    access: StorageTextureAccess
    format: StorageTextureFormat
}

/// Resource type for one slot in a bind group layout.
///
/// TODO: Texture bindings use D2 dimensions only for now. @catnipped will determine when cube maps, texture arrays, or 3D volumes are needed.
enum BindingType {
    Buffer BufferBindingType
    Sampler
    Texture
    StorageTexture StorageTextureBindingType
    // `External` is by design NOT supported (likely for video processing, camera, compositors that are tied to the OS?)
}

struct VertexAttribute {
    offset: Int
    /// Vertex input shader location. Matches `@location(N)` in the vertex shader.
    location: Int // TODO: maybe call it shader_location. or is that too long?
    format: VertexFormat
}

struct VertexBufferLayout {
    array_stride: Int
    vertex_attribute: Vec<VertexAttribute; 32>
    step_mode: VertexStepMode
}

impl BufferHandle {
    /// Writes all elements of `data` into the GPU buffer starting at element `0`.
    external 911 fn write(mut self, data: Any)

    /// Writes all elements of `data` into the GPU buffer starting at `dest_element_offset`.
    ///
    /// (for example one element per entry in `Vec<Vertex; N>`).
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

    /// Releases the underlying GPU buffer handle.
    /// After calling this, the handle must not be used again.
    external 921 fn drop(mut self)
}

impl TextureHandle {
    /// Updates texture data without recreating the whole texture
    external 916 fn write(self, data: Any, width: Int, height: Int)

    /// Releases the underlying GPU texture.
    /// After calling this, the handle must not be used again.
    external 918 fn drop(mut self)
}

impl TextureViewHandle {
    /// Releases this texture view handle.
    /// After calling this, the handle must not be used again.
    external 919 fn drop(mut self)
}

impl BindGroupHandle {
    /// Releases the underlying GPU bind group handle.
    /// After calling this, the handle must not be used again.
    external 922 fn drop(mut self)
}

impl BindGroupLayoutHandle {
    /// Releases the underlying GPU bind group layout handle.
    /// After calling this, the handle must not be used again.
    external 923 fn drop(mut self)
}

impl PipelineLayoutHandle {
    /// Releases the underlying GPU pipeline layout handle.
    /// After calling this, the handle must not be used again.
    external 924 fn drop(mut self)
}

impl RenderPipelineHandle {
    /// Releases the underlying GPU render pipeline handle.
    /// After calling this, the handle must not be used again.
    external 925 fn drop(mut self)
}

impl SamplerHandle {
    /// Releases the underlying GPU sampler handle.
    /// After calling this, the handle must not be used again.
    external 926 fn drop(mut self)
}


// Internal
external 900 fn create_index_buffer_u16(buffer: Any, description: String) -> BufferHandle
external 901 fn create_vertex_buffer(buffer: Any, description: String) -> BufferHandle

/// Creates an empty GPU buffer without initial data.
external 914 fn create_buffer(size: Int, usage: BufferUsage, description: String) -> BufferHandle

/// Creates a bind group instance for a layout from [`create_bind_group_layout`].
///
/// `entries` are assigned to `@binding(0)`, `@binding(1)`, … in array order.
/// The layout must declare bindings in that same sequential order.
external 902 fn create_bind_group(bind_group_layout: BindGroupLayoutHandle, entries: [BindGroupEntry], description: String) -> BindGroupHandle
external 903 fn create_sampler(config: SamplerConfig, description: String) -> SamplerHandle

/// Creates an empty texture that can be sampled (read).
external 927 fn create_sampled_texture(width: Int, height: Int, format: SampledTextureFormat, description: String) -> TextureHandle

/// Creates an empty texture that can be used as a color render attachment.
external 912 fn create_render_texture(width: Int, height: Int, format: RenderTextureFormat, description: String) -> TextureHandle

/// Creates an empty texture that can be both rendered to (write) and sampled (read).
external 928 fn create_render_sampled_texture(width: Int, height: Int, format: SampledTextureFormat, description: String) -> TextureHandle

/// Creates an empty texture that can be used as a storage texture.
external 931 fn create_storage_texture(width: Int, height: Int, format: StorageTextureFormat, description: String) -> TextureHandle

/// Creates an empty texture that can be used as a depth/stencil attachment.
// TODO: Should return a specific DepthTextureHandle in the future
external 929 fn create_depth_texture(width: Int, height: Int, format: DepthTextureFormat, description: String) -> TextureHandle

// Creates a sampled texture from a png. can only be sampled (read).
external 920 fn create_sampled_texture_png(image: Image, format: SampledTextureFormat, description: String) -> TextureHandle

// Creates a sampled texture from a png. can only be sampled (read) and rendered to (write). you usually want to use `create_sampled_texture_png`
external 930 fn create_render_sampled_texture_png(image: Image, format: SampledTextureFormat, description: String) -> TextureHandle

/// Creates a view into a texture for rendering or sampling
external 913 fn create_texture_view(texture: TextureHandle, description: String) -> TextureViewHandle

/// Describes the resources in `@binding(0)`, `@binding(1)`, … order within one bind group.
external 906 fn create_bind_group_layout(entries: [BindingType], description: String) -> BindGroupLayoutHandle

/// Creates a pipeline layout from bind group layouts in group-index order.
///
/// The first layout is group index `0` (`@group(0)`), the second is `1`, and so on.
external 907 fn create_pipeline_layout(groups: [BindGroupLayoutHandle], description: String) -> PipelineLayoutHandle

/// Creates a render pipeline targeting the current surface (swapchain) format.
external 908 fn create_render_pipeline(layout: PipelineLayoutHandle, buffers: [VertexBufferLayout], shader_module: Shader, options: RenderPipelineOptions, description: String) -> RenderPipelineHandle

/// Creates a render pipeline targeting an explicit color format (for offscreen pipelines).
external 992 fn create_render_pipeline_with_color_format(layout: PipelineLayoutHandle, buffers: [VertexBufferLayout], shader_module: Shader, color_format: RenderTextureFormat, options: RenderPipelineOptions, description: String) -> RenderPipelineHandle

/// Submits a render pass for execution
external 905 fn add_pass(pass: RenderPass, description: String)

external 910 fn create_uniform_buffer(buffer: Any, description: String) -> BufferHandle

/// The size of the renderable surface. Return (Width, Height).
external 990 fn surface_extent() -> (Int, Int)
