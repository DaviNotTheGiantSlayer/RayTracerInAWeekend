package raytracerinaweekend

import "core:math"

dot :: proc(v1 : [3]f32, v2 : [3]f32) -> f32 {
    return v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2];
}

length :: proc(v : [3]f32) -> f32 {
    return math.sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2]);
}

normalize :: proc(v : [3]f32) -> [3]f32 {
    length := length(v);
    return {v[0] / length, v[1] / length, v[2] / length};
}


