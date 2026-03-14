package raytracerinaweekend

import "core:fmt"

write_color :: proc(color : [3]f64) {
    r := color[0]
    g := color[1]
    b := color[2]

    ir := int(255.999 * r)
    ig := int(255.999 * g)
    ib := int(255.999 * b)

    fmt.printf("%d %d %d\n", ir, ig, ib)
}

main :: proc() {
    aspect_ratio : f32;
    image_width : int;
    image_height : int;


    aspect_ratio = 16.0 / 9.0;
    image_width = 400;
    image_height = int(image_width / int(aspect_ratio));


    imageWidth := 256;
    imageHeight := 256;

    fmt.printf("P3\n%d %d\n255\n", imageWidth, imageHeight)

    for j := 0; j < imageWidth; j += 1 {
        fmt.eprintf("\rScanlines remaining: %d \n", (imageHeight - j))
        for i := 0; i < imageHeight; i += 1 {
            color : [3]f64
            color = {f64(i) / f64(imageWidth - 1), f64(j) / f64(imageHeight - 1), 0.0}
            
            write_color(color)
        }    
    }

}