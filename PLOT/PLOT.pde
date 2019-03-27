float domain[] = {0, 8.7};
PGraphics axis;
float increment;
float range[] = {0, 0};
ArrayList<PVector> points;
boolean zero = true;

float f(float x) {
  // Enter The Function Here:
  //float y = abs(sin(pow(x,x))/(pow(2, (pow(x,x)-HALF_PI)/PI))); // COOL
  //float y = sin(2*sin(2*sin(2*sin(x)))); // SQUARE WAVE
  float y = pow(x, 1.f/x);
  return -y;
}

float get_scaling_factor_x() {
  float max_factor = max(abs(domain[0]), abs(domain[1]));
  return (width/2 - 8) / max_factor;
}

float get_scaling_factor_y() {
  float max_factor = max(abs(range[0]), abs(range[1]));
  return (height/2 - 4) / max_factor;
}

void plot(color col) {
  float x = 0, y = 0;
  float max_y = range[1], min_y = range[0];
  translate(width/2, height/2);
  beginShape();
  for (x = domain[0]; x <= domain[1] + increment; x += increment) {
    y = -f(x);
    if (y > max_y) {
      max_y = y;
    }
    if (y < min_y) {
      min_y = y;
    }
    y *= -1;
    if (zero && (x <= 1e-6 && x >= -1e-6) && x == 0) {
      continue;
    }
    fill(30, 30, 200, 50);
    stroke(col);
    strokeWeight(4);
    range[0] = min_y;
    range[1] = max_y;
    vertex(x * get_scaling_factor_x(), y * get_scaling_factor_y());
    points.add(new PVector(x * get_scaling_factor_x(), y * get_scaling_factor_y()));
  }
  endShape();
}


void setup() {
  size(800, 800, P2D);
  background(0);
  increment = (domain[1] - domain[0]) / 192;
  axis = createGraphics(width, height);
  axis.beginDraw();
  axis.noFill();
  axis.stroke(51);
  axis.strokeWeight(1);
  axis.line(width/2, 0, width/2, height);
  axis.line(0, height/2, width, height/2);
  axis.endDraw();

  points = new ArrayList<PVector>();
}

PVector mouse_over() {
  float error = 1;
  for (PVector point : points) {
    float d = dist(mouseX - width/2, (mouseY - height/2), point.x, point.y);
    if (d <= 5) {
      return point;
    }
  }
  return new PVector(-width, -height);
}


void draw() {
  background(0);
  image(axis, 0, 0);
  plot(color(250, 200, 250));
  PVector dr = mouse_over();
  noFill();
  stroke(60, 250, 90, 210);
  strokeWeight(13);
  point(dr.x, dr.y);
  println(" x=" + (dr.x / get_scaling_factor_x()) + "\ty=" + -(dr.y / get_scaling_factor_y()));
}
