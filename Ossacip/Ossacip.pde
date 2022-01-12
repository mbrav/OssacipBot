// Ossacip Bot v2

// by Michael Braverman
// July 7th, 2016

// Updated
// November 26th, 2021

// DEPENDENCIES:
// Make sure you have the following Processing 3 libraries installed:
// processing-video : https://github.com/processing/processing-video

// libraries
import com.hamoid.*;
// create a new VideoExport-object
VideoExport videoExport;

// classes
Fractal fractal;

// color
PVector rgb;
int colorContrast = 220; // 0 - 255

// frames
int frames = 120;
int framesCount;

void setup() {
  frameRate(30);
  size(1080, 1080, P2D);
  noSmooth();

  // setup Video export
  videoExport = new VideoExport(this, "export.mp4");
  videoExport.setFrameRate(30);  
  videoExport.startMovie();

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

  // create a new fractal that will cover all values from 0 to te value of "range"
  float range = random(PI/8, PI);
  fractal = new Fractal(range/frames*2, frames);

  // picks the best values for rendering the fractal
  fractal.simulate();

  // vars = fractal.vars;
  // increment = fractal.increment;
  // morphingVar = fractal.morphingVar;

  // println("Variables:");
  // println("a:", vars[0]);
  // println("b:", vars[1]);
  // println("c:", vars[2]);
  // println("d:", vars[3]);
  // println("e:", vars[4]);
  // println("f:", vars[5]);
  // println("morphing:", morphingVar, " increment:", increment);



  // "rewind" the fractal backwards once on the mid frame
  fractal.setReversePoint(frames/2);
}

void draw () {
  // set color
  background(255 - rgb.x, 255 - rgb.y, 255 - rgb.z);
  // inverse color for stroke
  stroke(rgb.x,rgb.y, rgb.z, 10);
  // stroke(rgb.x,rgb.y, rgb.z, 18);
  noFill();

  // count frames
  framesCount++;

  // draw fractal
  fractal.draw();

  // export new frame
  newFrame();
}

// deal with frame
void newFrame(){
  if (framesCount <= frames) {
    videoExport.saveFrame();
    if (framesCount == frames) {
      videoExport.endMovie();
      print("Movie saved \n");
      // EXIT PROGRAM
      exit();
    }
  }
}
