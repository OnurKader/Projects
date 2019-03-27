import peasy.*;

final int repeat = 1;
Helix left, right;
PeasyCam cam;

void setup() {
  size(800, 800, P3D);
  background(0);
  left = new Helix(repeat, 0.f);
  right = new Helix(repeat, PI);
  //cam = new PeasyCam(this, 500, 500, 400, 800);
}
int i = 0;
void draw() {
  background(0);
  translate(width/2, 18, -1);
  rotateY(-radians(i++));
  left.display();
  right.display();
}
