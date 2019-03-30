
class rain_drop{
  Matrix pos = new Matrix(2, 1);  //Initialized as zero
  Matrix vel = new Matrix(2, 1);  //Initialized as zero
  Matrix acc = new Matrix(2, 1);  //Initialized as zero
  Matrix pos_r = new Matrix(2, 1);//Rotated position (End of the drop)
  float len;
  float gravity;
  float angle;
  
  rain_drop(){
    gravity = -0.029;
    angle = 0;
    pos.x(random(1, width - 1));
    pos.y(random(11, height - 25));
    vel.y(random(-2, -0.01));
    len = 6;
    pos_r.y(pos.y() + len);
    pos_r.x(pos.x());
  }
  
  void update(){
   pos.add(vel);
   acc.y(gravity);
   pos_r.y(-pos.y() + len);
   pos_r.add(vel);   
   //pos_r.Rotate(angle);
   vel.Rotate(angle);
   vel.mult(0.99);
   vel.x(random(-0.092,0.092));
   vel.add(acc);
  }
  
  void show(){
        stroke(250,247,255);
        strokeWeight(2);
        line(pos.x(),pos.y(), pos_r.x(), pos_r.y());
        //line(pos.x(),pos.y(), pos.x(), pos.y()+len);
        angle += 0.0081;
  }
  
  void reset(){
   if(pos.y() >= height || vel.y() == 0)
   {
    pos.x(random(1, width - 1));
    pos.y(random(0, height - 50));
    vel.y(random(-2.2, -0.01));
    pos_r.x(pos.x());
    pos_r.y(-pos.y());
   }    
  }
  
  
  
  
  
  
  
  
  
  
  
  
}
