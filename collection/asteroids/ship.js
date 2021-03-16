function Ship() {
  this.pos = createVector(width / 2, height / 2);
  this.vel = createVector(0, 0);
  this.heading = 0;
  this.is_boosting = false;
  this.rotation = 0;
  this.r = 25;
  this.render = function() {
    push()
    translate(this.pos.x, this.pos.y);
    rotate(this.heading + PI / 2);
    fill(1);
    stroke(255);
    triangle(-this.r, this.r, this.r, this.r, 0, -this.r);
    pop();
  }

  this.update = function() {
    if (this.is_boosting)
      this.boost();
    this.pos.add(this.vel);
    this.vel.mult(0.98);
  }

  this.boosting = function(boost) {
    this.is_boosting = boost;
  }

  this.set_rotation = function(angle) {
    this.rotation = angle;
  }

  this.turn = function() {
    this.heading += this.rotation;
  }

  this.boost = function() {
    var force = p5.Vector.fromAngle(this.heading);
    force.mult(0.25);
    this.vel.add(force);
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

  this.hits = function(asteroid) {
    var d = dist(this.pos.x, this.pos.y, asteroid.pos.x, asteroid.pos.y);
    if (d < asteroid.r + this.r) {
      return true;
    } else {
      return false;
    }
  }



}
