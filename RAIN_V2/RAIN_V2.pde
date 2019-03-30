rain_drop[] rain = new rain_drop[2575];


void setup() {
  //size(1280,720); 
  fullScreen();
  noCursor();
  background(8);

  for (int i=0; i < rain.length; i++)
    rain[i] = new rain_drop();
}

void draw() {
  background(8);
  for (int i=0; i < rain.length; i++) {
    rain[i].update();
    rain[i].show();
    rain[i].reset();
    if (rain[i].pos_r.y() >= height/2 + 20 && rain[i].pos_r.x() > width/2 - 120 && rain[i].pos_r.x() < width/2 + 120) {
      //rain[i].angle = PI;
      //rain[i].vel.mult(-0.5);
      //rain[i].pos_r.Rotate(PI);
    }
  }
  fill(116, 56, 20);
  stroke(255);
  strokeWeight(1);
  //rect(width/2 - 120, height/2+20, 240, 20);
}
