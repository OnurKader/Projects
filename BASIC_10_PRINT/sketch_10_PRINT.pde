int x, y;
void setup() {
  size(800, 800);
  background(0);
  x = 0;
  y = 0;
}

final int size = 25;

void draw() {
  stroke(255);
  translate(x, y);
  if (random(1) < 0.5f) {
    line(0, size, size, 0);
  } else {
    line(0, 0, size, size);
  }

  if (x <= width) {
    x += size;
  } else {
    x = 0;
    y += size;
  }
  if (y >= height) {
    y = 0;
  }
  if (x >= width - size && y >= height - size) {
    noLoop();
  }
}
