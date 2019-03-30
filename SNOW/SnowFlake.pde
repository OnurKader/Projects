class SnowFlake {
  PVector pos, vel, acc;
  float gravity, size;
  SnowFlake() {
    pos = new PVector(random(width), random(-height + 21, -42));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    gravity = 0.1;
    size = random(2, 8);
  }

  SnowFlake(float x, float y, float velX, float velY, float size) {
    pos = new PVector(x, y);
    vel = new PVector(velX, velY);
    gravity = 0.1;   
    this.size = size;
    acc = new PVector(0, 0);
  } 

  void fall(){
   float res = 0.0331 / (size * 2.718171);  //0.05 
   acc.y += res;
   acc.mult(0.666);
  }

  void update() {
    fall();
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void show() {
    noStroke();
    fill(254);
    ellipse(pos.x, pos.y, 2*size, 2*size);
  }

  void reset() {
    if (pos.y >= height + size + 1) {
      pos = new PVector(random(width), random(-200, -42));
      vel = new PVector(0, 0);
      acc.mult(0);
      size = random(2, 8);
    }
  }









}
