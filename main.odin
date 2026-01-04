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
    imageWidth := 256;
    imageHeight := 256;

    fmt.printf("P3\n%d %d\n255\n", imageWidth, imageHeight)

    for j := 0; j < imageWidth; j += 1 {
        fmt.eprintf("\rScanlines remaining: %d \n", (imageHeight - j))
        for i := 0; i < imageHeight; i += 1 {
            color : [3]f64
            color[0] = f64(i) / f64(imageWidth - 1)
            color[1] = f64(j) / f64(imageHeight - 1)
            color[2] = 0.0

            write_color(color)
        }    
    }

}