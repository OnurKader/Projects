function Laser(pos, heading) {
  this.pos = createVector(pos.x, pos.y);
  this.vel = p5.Vector.fromAngle(heading);
  this.vel.setMag(9);

  this.update = function() {
    this.pos.add(this.vel);
  }

  this.render = function() {
    push();
    stroke(255);
    strokeWeight(6);
    point(this.pos.x, this.pos.y);
    pop();
  }

  this.hits = function(asteroid) {
    var d = dist(this.pos.x, this.pos.y, asteroid.pos.x, asteroid.pos.y);
    if (d < asteroid.r - 2)
      return true;
    else
      return false;
  }

  this.offscreen = function() {
    if (this.pos.x > width || this.pos.x < 0)
      return true;
    if (this.pos.y > height || this.pos.y < 0)
      return true;
    return false;
  }







}
