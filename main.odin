package raytracerinaweekend

import "core:fmt"
import "core:math"

write_color :: proc(color : [3]f32) {
    r := color[0]
    g := color[1]
    b := color[2]

    ir := int(255.999 * r)
    ig := int(255.999 * g)
    ib := int(255.999 * b)

    fmt.printf("%d %d %d\n", ir, ig, ib)
}

hit_sphere :: proc(center : [3]f32, radius : f32, r : Ray) -> f32 {
    oc := center - r.origin;
    
    a := length(r.direction)*length(r.direction);
    
    h := dot(r.direction, oc);
    
    c := length(oc)*length(oc) - radius*radius;
    
    discriminant := h*h -a*c;

    if discriminant < 0 {
        return -1.0;
    } else {
        return (h - math.sqrt(discriminant)) / a;
    }
}

ray_color :: proc(r : Ray) -> [3]f32 {
    t := hit_sphere({0, 0, -1}, 0.5, r);
    if t > 0.0 {
        N := normalize(at(r, t) - {0, 0, -1});
        return {N.x+1, N.y+1, N.z+1} * 0.5;
    }

    unit_direction := normalize(r.direction);
    a := (unit_direction.y + 1)*0.5;
    return {1.0, 1.0, 1.0} * (1.0-a) + {0.5, 0.7, 1.0} * a;
}

main :: proc() {
    aspect_ratio : f32;
    image_width : int;
    image_height : int;
    viewport_height : f32;
    viewport_width : f32; 
    viewport_u : [3]f32;
    viewport_v : [3]f32;
    focal_length : f32;
    pixel_delta_u : [3]f32;
    pixel_delta_v : [3]f32;
    camera_center : [3]f32;
    viewport_upper_left : [3]f32;
    pixel00_loc : [3]f32;


    aspect_ratio = 16.0 / 9.0;
    image_width = 400;
    image_height = int(f32(image_width) / aspect_ratio);
    if image_height < 1 {
        image_height = 1;
    }

    focal_length = 1.0;
    viewport_height = 2.0;
    viewport_width = viewport_height * (f32(image_width) / f32(image_height));
    camera_center = {0, 0, 0}

    viewport_u = {viewport_width, 0, 0}
    viewport_v = {0, viewport_height*-1, 0}

    pixel_delta_u = viewport_u / f32(image_width); 
    pixel_delta_v = viewport_v / f32(image_height);

    viewport_upper_left = camera_center - {0, 0, focal_length};
    viewport_upper_left = viewport_upper_left - viewport_u / 2;
    viewport_upper_left = viewport_upper_left - viewport_v / 2;
    pixel00_loc = viewport_upper_left + (pixel_delta_u + pixel_delta_v)*0.5;

    fmt.printf("P3\n%d %d\n255\n", image_width, image_height)

    for j := 0; j < image_height; j += 1 {
        fmt.eprintf("\rScanlines remaining: %d \n", (image_height - j));
        for i := 0; i < image_width; i += 1 {
            pixel_center := pixel00_loc + pixel_delta_u * f32(i);            
            pixel_center = pixel_center + pixel_delta_v * f32(j);
            ray_direction := pixel_center - camera_center;
            r := Ray{camera_center, ray_direction};
            pixel_color := ray_color(r);
            write_color(pixel_color)
        }    
    }

}