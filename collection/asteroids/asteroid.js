function Asteroid(pos, size) {
  if (pos)
    this.pos = pos.copy();
  else
    this.pos = createVector(random(width), random(height));

  this.vel = p5.Vector.random2D();
  if (size)
    this.r = size;
  else
    this.r = random(31, 85);

  this.total = random(5, 16);
  this.offset = [];
  for (var i = 0; i < this.total; i++) {
    if (this.r > 29)
      this.offset[i] = random(-22, 22);
    else
      this.offset[i] = random(-6, 6);
  }


  this.render = function() {
    push();
    translate(this.pos.x, this.pos.y);
    noFill();
    stroke(255);
    beginShape();
    for (var i = 0; i <= this.total; i++) {
      var angle = map(i, 0, this.total, 0, TWO_PI);
      var x = (this.r + this.offset[i]) * cos(angle);
      var y = (this.r + this.offset[i]) * sin(angle);
      vertex(x, y);
    }
    endShape(CLOSE);
    pop();
  }

  this.update = function() {
    this.pos.add(this.vel);
  }

  this.edge = function() {
    if (this.pos.x > width + this.r)
      this.pos.x = -this.r;
    else if (this.pos.x < -this.r)
      this.pos.x = width + this.r;
    if (this.pos.y > height + this.r)
      this.pos.y = -this.r;
    else if (this.pos.y < -this.r)
      this.pos.y = height + this.r;
  }

  this.breakup = function() {
    var new_a = [];
    new_a[0] = new Asteroid(this.pos, this.r / 2);
    new_a[1] = new Asteroid(this.pos, this.r / 2);
    return new_a;
  }


}
