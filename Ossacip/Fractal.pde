// Based on Vincent D. Warmerdam's formula
// http://koaning.io/fluctuating-repetition.html

class Fractal {
  // number of points per frame
  int pointsNumber = 250000;
  PVector pos = new PVector(0,0,0);

  // Formula variables
  float[] vars = new float[6];
  int morphingVar; //

  float increment;
  int frames; // total frames
  int frameCount; // tcurrent frame number

  // CONFIGURABLE VARIABLES
  // sets the frame on which the fracal reverses
  int reverseFrameIndex;
  boolean reverse = false;

  // for simulating
  PVector max = new PVector(0,0,0);
  PVector min = new PVector(0,0,0);

  Fractal(float _increment, int _frames) {
    increment = _increment;
    frames = _frames;

    randomizeFractal();
  }

  // randomize fractal variables
  void randomizeFractal() {
    for (int i = 0; i < vars.length; i++) {
      // round to numbers that are division of PI
      // increases the clarity of geomtric lines
      vars[i] = int(random(0,frames)) * PI/frames;
    }

    // chose a random number that will morph
    morphingVar = int(random(0, 6));
    // set it to 0
    vars[morphingVar] = 0;
  }

  // draw the Fractal
  void draw() {
    render(true);
  }

  // a funtion that simulates the randomized variables
  // checks if the animation is "good" enough
  // TODO
  void simulate() {
    int simulationCount = 0;
    int now = millis();

    // while not a good Fractal, continue simulating
    boolean goodFractal = false;
    while (!goodFractal) {
        goodFractal = true;
    }

    print("Took ");
    print(millis() - now);
    println(" milliseconds to simulate.");
    print("Saved you from ");
    print(simulationCount);
    println(" boring Fractal animations.");
  }

  // The main fractal function that simulates or renders the Fractal
  // If false, the fractal will just be calculated without being displayed
  void render(boolean paint) {

    if (reverse && frameCount == reverseFrameIndex) {
      // "rewind" animation
      increment = -increment;
    }

    vars[morphingVar] += increment;

    int points;
    if (paint) {
      points = pointsNumber;
    } else {
      // decrease number of points in simulation
      points = pointsNumber/100;
    }

    PVector newPos = new PVector(0,0,0);
    for (int i = 0; i < points; i++) {

      newPos.x = sin(vars[0] * pos.y) + cos(vars[1] * pos.x) - cos(vars[2] * pos.z);
      newPos.y = sin(vars[3] * pos.y) + cos(vars[4] * pos.x) - cos(vars[5] * pos.z);
      newPos.z = pos.x + PI/120;
      pos.x = newPos.x;
      pos.y = newPos.y;
      pos.z = newPos.z;

      if (paint) {
        // draw point on screen
        point(pos.x * width/(PI*2) + width/2, pos.y * height/(PI*2) + height/2);
      } else {
        // debug stuff for simulation
        if (abs(max.x) < abs(pos.x)) {
          max.x = pos.x;
        }
        if (abs(max.y) < abs(pos.y)) {
          max.y = pos.y;
        }
        if (abs(max.z) < abs(pos.z)) {
          max.z = pos.z;
        }

        if (abs(min.x) > abs(pos.x)) {
          min.x = pos.x;
        }
        if (abs(min.y) > abs(pos.y)) {
          min.y = pos.y;
        }
        if (abs(min.z) > abs(pos.z)) {
          min.z = pos.z;
        }
      }
    }
    frameCount ++;
  }

  // option "rewind" the fractal backwards
  void setReversePoint(int frameIndex) {
    reverse = !reverse;
    reverseFrameIndex = frameIndex;
  }
}
