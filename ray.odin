package raytracerinaweekend

Ray :: struct {
    origin : Vec3,
    direction : Vec3
}

at :: proc(ray : Ray, t : f32) -> Vec3{
    return add3d(ray.origin, mul(ray.direction, t));
}