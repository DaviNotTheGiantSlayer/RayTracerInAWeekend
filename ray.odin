package raytracerinaweekend

Ray :: struct {
    origin : [3]f32,
    direction : [3]f32
}

at :: proc(ray : Ray, t : f32) -> [3]f32 {
    return ray.origin + ray.direction * t;
}