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

//color
PVector rgb;
int colorContrast = 220; // 0 - 255

// prime numbers might work better
int frames = 61;
int framesCount;

void setup() {
  frameRate(30);
  size(500, 500, P2D);
  smooth(2);

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

  // "rewind" the fractal backwards once on the mid frame
  fractal.setReversePoint(frames/2);
}

void draw () {
  // set color
  background(rgb.x,rgb.y,rgb.z);
  // inverse color for stroke
  stroke(255 - rgb.x,255 - rgb.y, 255 - rgb.z, 50);
  noFill();

  // draw fractal
  fractal.draw();

  // Deal with Gif
  gifFrame();
}

void gifFrame(){
  // count frames
  framesCount++;
  print(framesCount);
  print(" ");

  // gif control
  if (frames >= framesCount) {
    gifExport.setDelay(1);
    gifExport.addFrame();
    if (framesCount == frames) {
      gifExport.finish();
      println("GIF saved");
      println("exiting program...");

      // EXIT PROGRAM
      exit();
    }
  }
}
