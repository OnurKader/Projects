final int repeat = 6;
Helix left, right;

void setup() {
    size(800, 800, P3D);
    background(0);
    left = new Helix(repeat, 0.f);
    right = new Helix(repeat, PI);
}
int i = 0;
void draw() {
    background(0);
    translate(width/2, -666, -875);
    rotateY(-radians(i++));
    left.display();
    right.display();
}
