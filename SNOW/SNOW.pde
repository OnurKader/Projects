SnowFlake snowflakes[] = new SnowFlake[1250];



void setup() {
  //size(800, 800);
  fullScreen();
  noCursor();
  background(1);
  for(int i=0; i < snowflakes.length; i++)
     snowflakes[i] = new SnowFlake();
}

void draw() {
  background(1);
  
  for(int i=0; i < snowflakes.length; i++){
     snowflakes[i].update();
     snowflakes[i].reset();
     snowflakes[i].show();
  }
  
  
  
  
  
}
