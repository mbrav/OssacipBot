// Based on Vincent D. Warmerdam's formula
// http://koaning.io/fluctuating-repetition.html

class Fractal {
  // number of points per frame
  int pointsNumber = 1000000;
  PVector pos = new PVector(0,0,0);

  // Formula variables
  float[] vars = new float[6];
  int morphingVar; // the value that causes the moves

  float increment; // added to morphingVar every frame
  int frames; // total frames
  int frameCount; // current frame number

  // sets the frame on which the fracal reverses
  int reverseFrameIndex;
  boolean reverse = false;

  // for simulating and debuging
  int simulationCount = 0;
  PVector max = new PVector(-10,-10,-10);
  PVector min = new PVector(10,10,10);
  PVector delta = new PVector();
  long millis;

  Fractal(float _increment, int _frames) {
    increment = _increment;
    frames = _frames;

    randomizeFractal();
  }

  void randomizeFractal() {
    for (int i = 0; i < vars.length; i++) {
      vars[i] = random(0,frames) * PI/frames;
    }

    // chose a random number that will morph
    morphingVar = int(random(0, 6));
    vars[morphingVar] = 0;
    resetFractal();
  }

  // set the fractal to its begining without re-randomizing values
  void resetFractal() {
    vars[morphingVar] = 0;
    reverse = false;
    frameCount = 0;
  }

  // draw the Fractal
  void draw() {
    renderFractal(true);
  }

  // a funtion that simulates the randomized variables
  // checks if the animation is "good" enough
  void simulate() {
    int timer = millis();

    // while not a good Fractal, continue simulating
    boolean goodFractal = false;
    while (!goodFractal) {
      // asume the fractal is good to begin with
      goodFractal = true;

      // simulate all the fractal's frames
      for (int i = 0; i < frames; i++) {

        // render fractal without drawing it
        renderFractal(false);

        // arguments that categorize the fractal as "not good"
        // (based on a ton of data monitoring without any particular reasoning behind the rules. it's math and logic.)
        // Generally, when to many values equal zero, that's when you get an empty/booring frame
        boolean arg1 = (delta.x < 0.3 && delta.y < 0.3 && delta.z < 0.3);
        boolean arg2 = (min.x == 0 && min.y == 0 && min.z == 0);
        boolean arg3 = (max.x == 0 && max.y == 0 && max.z == 0);
        // at least on zero in both min an max vectors
        boolean arg4 = (min.x == 0 || min.y == 0 || min.z == 0) && (max.x == 0 || max.y == 0 || max.z == 0);
        // two zero's in min and max vectors
        boolean arg6 = ((min.x == 0 && min.y == 0) || (min.x == 0 && min.z == 0) || (min.y == 0 && min.z == 0));
        boolean arg5 = ((max.x == 0 && max.y == 0) || (max.x == 0 && max.z == 0) || (max.y == 0 && max.z == 0));

        // provide arguments that question the fractal's "goodness"
        if (arg1 || arg2 || arg3 || arg4 || arg5 || arg6) {
          simulationCount ++;
          goodFractal = false;

          // re-radnomiz fractal
          randomizeFractal();
          break;
        } else {
          goodFractal = true;
        }
      }
    }

    resetFractal();

    print("Took ");
    print(millis() - timer);
    print(" milliseconds to simulate.");
    print("\n");
    print("While saving you from ");
    print(simulationCount);
    print(" boring animations.");
    print("\n");

  }

  // The main fractal function that simulates or renders the Fractal
  // If false, the fractal will just be calculated without being displayed
  void renderFractal(boolean paint) {

    // "rewind" animation
    if (reverse && frameCount == reverseFrameIndex) {
      increment = -increment;
    }

    // increase the value of the morphing value
    vars[morphingVar] += increment;

    // reset debug values
    millis = millis();
    max.set(0,0,0);
    min.set(0,0,0);
    PVector newPos = new PVector(0,0,0);

    // number of points to draw
    int points;
    if (paint) {
      points = pointsNumber;
    } else {
      // less points are needed when simulating
      points = 10000;
    }

    // itirate throught all the points
    for (int i = 0; i < points; i++) {
      newPos.x = sin(vars[0] * pos.y) + cos(vars[1] * pos.x) - cos(vars[2] * pos.z);
      newPos.y = sin(vars[3] * pos.x) + cos(vars[4] * pos.y) - cos(vars[5] * pos.z);
      newPos.z = pos.x + PI/120;
      pos.x = newPos.x;
      pos.y = newPos.y;
      pos.z = newPos.z;

      // unecessary to draw the fractal when calculating
      if (paint) {
        // draw point on screen
        point(pos.x * width/(6) + width/2, pos.y * height/(6) + height/2);
      }

      // stuff for simulating and debuging
      if (max.x < pos.x) {
        max.x = pos.x;
      }
      if (max.y < pos.y) {
        max.y = pos.y;
      }
      if (max.z < pos.z) {
        max.z = pos.z;
      }

      if (min.x > pos.x) {
        min.x = pos.x;
      }
      if (min.y > pos.y) {
        min.y = pos.y;
      }
      if (min.z > pos.z) {
        min.z = pos.z;
      }
    }

    // count as a completed frame
    frameCount ++;

    // calculate delta between the max's an min's
    delta.set(max.x - min.x, max.y - min.y, max.z - min.z);

    if (paint) {
      print("Frame ");
      print(frameCount);
      print(" took ");
      print((millis() - millis));
      print(" milliseconds to render ");
      // print(" min");
      // print(min);
      // print(" max");
      // print(max);
      // print(" delta");
      // print(delta);
      print("\n");
    }
  }

  // option to "rewind" the fractal backwards
  void setReversePoint(int frameIndex) {
    reverse = !reverse;
    reverseFrameIndex = frameIndex;
  }
}
