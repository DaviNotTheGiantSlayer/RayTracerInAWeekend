package raytracerinaweekend

import "core:fmt"
import "core:math"

write_color :: proc(color : Vec3) {
    r := color.x
    g := color.y
    b := color.z

    ir := int(255.999 * r)
    ig := int(255.999 * g)
    ib := int(255.999 * b)

    fmt.printf("%d %d %d\n", ir, ig, ib)
}

hit_sphere :: proc(center : Vec3, radius : f32, r : Ray) -> f32 {
    oc := sub(center, r.origin);
    
    a := dot3d(r.direction, r.direction);
    
    b := -2*dot3d(r.direction, oc);
    
    c := dot3d(oc, oc) - radius*radius;
    
    discriminant := b*b -4*a*c;

    if discriminant < 0 {
        return -1.0;
    } else {
        return -b - math.sqrt(discriminant) / (2*a);
    }
}

ray_color :: proc(r : Ray) -> Vec3 {
    t := hit_sphere(Vec3{0, 0, -1}, 0.5, r);
    if t > 0 {
        N := normalize3d(sub(at(r, t), Vec3{0, 0, -1}));
        return mul(Vec3{N.x+1, N.y+1, N.z+1}, 0.5);
    }

    unit_direction := normalize3d(r.direction);
    a := (unit_direction.y + 1)*0.5;
    return add3d(mul(Vec3{1.0, 1.0, 1.0}, 1.0-a), mul(Vec3{0.5, 0.7, 1.0}, a));
}

main :: proc() {
    aspect_ratio : f32;
    image_width : int;
    image_height : int;
    viewport_height : f32;
    viewport_width : f32; 
    viewport_u : Vec3;
    viewport_v : Vec3;
    focal_length : f32;
    pixel_delta_u : Vec3;
    pixel_delta_v : Vec3;
    camera_center : Vec3;
    viewport_upper_left : Vec3;
    pixel00_loc : Vec3;


    aspect_ratio = 16.0 / 9.0;
    image_width = 400;
    image_height = int(f32(image_width) / aspect_ratio);
    if image_height < 1 {
        image_height = 1;
    }

    focal_length = 1.0;
    viewport_height = 2.0;
    viewport_width = viewport_height * (f32(image_width) / f32(image_height));
    camera_center = Vec3 {0, 0, 0}

    viewport_u = Vec3 {viewport_width, 0, 0}
    viewport_v = Vec3 {0, viewport_height*-1, 0}

    pixel_delta_u = div(viewport_u, f32(image_width)); 
    pixel_delta_v = div(viewport_v, f32(image_height));

    viewport_upper_left = sub(camera_center, Vec3{0, 0, focal_length})
    viewport_upper_left = sub(viewport_upper_left, div(viewport_u, 2))
    viewport_upper_left = sub(viewport_upper_left, div(viewport_v, 2))
    pixel00_loc = add3d(viewport_upper_left, mul(add3d(pixel_delta_u, pixel_delta_v), 0.5))

    fmt.printf("P3\n%d %d\n255\n", image_width, image_height)

    for j := 0; j < image_height; j += 1 { //investigar pq ta invertido quando faço for com j pra fora e i por dentro e tbm pq não ta formando um circulo
        fmt.eprintf("\rScanlines remaining: %d \n", (image_height - j));
        for i := 0; i < image_width; i += 1 {
            pixel_center := add3d(pixel00_loc, mul(pixel_delta_u, f32(i)));            
            pixel_center = add3d(pixel_center, mul(pixel_delta_v, f32(j)));
            ray_direction := sub(pixel_center, camera_center);
            r := Ray{camera_center, ray_direction};
            pixel_color := ray_color(r);
            write_color(pixel_color)
        }    
    }

}