package raytracerinaweekend

import "core:math"

Vec2 :: struct {x, y: f32}
Vec3 :: struct {x, y, z: f32}

add2d :: proc(v1 : Vec2, v2 : Vec2) -> Vec2 {
    return {v1.x + v2.x, v1.y + v2.y};
}
add3d :: proc(v1 : Vec3, v2 : Vec3) -> Vec3 {
    return {v1.x + v2.x, v1.y + v2.y, v1.z + v2.z};
}
dot2d :: proc(v1 : Vec2, v2 : Vec2) -> f32 {
    return v1.x * v2.x + v1.y * v2.y;
}
dot3d :: proc(v1 : Vec3, v2 : Vec3) -> f32 {
    return v1.x * v2.x + v1.y * v2.y + v1.z + v2.z;
}
length2d :: proc(v : Vec2) -> f32 {
    return math.sqrt(v.x * v.x + v.y * v.y);
}
length3d :: proc(v : Vec3) -> f32 {
    return math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
}
normalize2d :: proc(v : Vec2) -> Vec2 {
    length := length2d(v);
    return {v.x / length, v.y / length};
}
normalize3d :: proc(v : Vec3) -> Vec3 {
    length := length3d(v);
    return {v.x / length, v.y / length, v.z / length};
}
mul :: proc(v : Vec3, t : f32) -> Vec3 {
    return {v.x * t, v.y * t, v.z * t}
}

