use nannou::prelude::*;

// DEFAULT_RATE_FPS = 1.0 as f64

fn main() {
    nannou::sketch(view).run();
}

fn view(app: &App, frame: Frame) {
    // get canvas to draw on
    let draw = app.draw();

    // set background to blue
    draw.background().color(PLUM);

    let x = random_f32() * 100 as f32;
    let y = random_f32() * 100 as f32;
    for _n in 1..100 {
        // println!("pi is {:.16}", _n);
        draw.rect().color(STEELBLUE).w(40.0).h(40.0).x_y(x, y);
    }

    // put everything on the frame
    draw.to_frame(app, &frame).unwrap();
}
