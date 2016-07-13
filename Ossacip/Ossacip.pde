// Ossacip Bot v1.0

// by Michael Braverman
// July 7th, 2016

// DEPENDENCIES:
// Make sure you have the following Processing 3 libraries installed:
// GifAnimation: https://github.com/01010101/GifAnimation/

// libraries
import gifAnimation.*;
GifMaker gifExport;

// classes
Fractal fractal;

// color
PVector rgb;
int colorContrast = 220; // 0 - 255

// frames
int frames = 60;
int framesCount;

void setup() {
  frameRate(30);
  size(600, 600, P2D);
  noSmooth();

  // setup Gif export
  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0);
  gifExport.setQuality(4);

  // Beter contrasting background/foreground colors
  // makes sure there are only dark/bright color combinations
  colorContrast = 255 - colorContrast; // inverse
  if ((Math.random() < 0.5)) {
    // Dark on Bright
    rgb = new PVector(random(255 - colorContrast,255),random(255 - colorContrast,255),random(255 - colorContrast,255));
  } else{
    // Bright on Dark
    rgb = new PVector(random(0,colorContrast),random(0,colorContrast),random(0,colorContrast));
  }

  // create a new fractal that will
  // cover all the values of PI (0 - 3.14)
  fractal = new Fractal(PI/frames*2, frames);

  // picks the best values for rendering the fractal
  fractal.simulate();

  // "rewind" the fractal backwards once on the mid frame
  fractal.setReversePoint(frames/2);
}

void draw () {
  // set color
  background(255 - rgb.x, 255 - rgb.y, 255 - rgb.z);
  // inverse color for stroke
  stroke(rgb.x,rgb.y, rgb.z, 50);
  noFill();

  // count frames
  framesCount++;

  // draw fractal
  fractal.draw();

  // new frame
  gifFrame();
}

// deal with Gif
void gifFrame(){
  if (frames >= framesCount) {
    gifExport.addFrame();
    if (framesCount == frames) {
      gifExport.finish();
      print("GIF saved");
      print("\n");

      // EXIT PROGRAM
      exit();
    }
  }
}
