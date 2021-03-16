float x, y, r;
ArrayList<PVector> points;

void setup() {
  size(900, 900, P2D);
  //fullScreen();
  background(0);
  points = new ArrayList<PVector>();
  x = 7;
  y = 0;
  r = 55;
  Batman();
  noLoop();
}

void draw() {
  background(138, 48, 205);
  translate(width/2, height/2);

  noStroke();
  fill(1);
  ellipse(0, 0, width - 18, height - 238);
  fill(244, 243, 24);
  ellipse(0, 0, width - 60, height - 290);

  stroke(4);
  strokeWeight(1);
  noFill();
  beginShape();
  for (PVector point : points) {
    vertex(point.x, point.y);
  }
  endShape();
}

void Append() {
  points.add(new PVector(x * r, y * r));
}

void Batman() {
  //for (float i=0; i <= TWO_PI; i+=radians(0.0021)) {
  while (x >= -7) {
    x -= 0.00198;

    //Top Wing
    if (abs(x) >= 4) {
      y = (3 * sqrt(-pow((x/7.0f), 2) + 1));
      Append();
    }

    //Bottom Wing
    if (abs(x) >= 3) {
      y = -(3 * sqrt(-pow((x/7.0), 2) + 1));
      Append();
    }

    //Neck?
    if (abs(x) <= 1 && abs(x) >= 0.75) {
      y = -9 + 8 * abs(x);
      Append();
    }

    //Ears Inner
    if (abs(x) <= 0.75 && abs(x) >= 0.5) {
      y = -(3 * abs(x) + 0.75);
      Append();
    }

    //Ear Connector
    if (abs(x) <= 0.5) {
      y = -2.25;
      Append();
    }

    //Wing to Head ( Inner Wings )
    if (abs(x) >= 1) {
      y = -(1.5 - 0.5*abs(x) - (6*sqrt(10)/14)*(sqrt(3 + 2*abs(x) - x*x) - 2));
      Append();
    }

    //Squiggly Line At the Bottom
    y = -(abs(x/2) - ((3*sqrt(33) - 7)/112)*pow(x, 2) + sqrt(1-pow((abs(abs(x) - 2) - 1), 2)) - 3);
    Append();
  }
}
