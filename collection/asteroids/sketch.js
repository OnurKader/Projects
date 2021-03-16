var ship;
var asteroids = [];
var lasers = [];
var is_hit;

function setup() {
  createCanvas(windowWidth, windowHeight);
  is_hit = false;
  background(1);
  ship = new Ship();
  for (var i = 0; i < 6; i++)
    asteroids.push(new Asteroid());

}

function draw() {
  if (is_hit)
    background(255, 25, 25);
  else
    background(1);

  for (var i = asteroids.length - 1; i >= 0; i--) {
    if (ship.hits(asteroids[i])) {
      is_hit = true;
    } else {
      is_hit = false;
    }
    asteroids[i].edge();
    asteroids[i].update();
    asteroids[i].render();
  }

  for (var i = lasers.length - 1; i >= 0; i--) {
    lasers[i].update();
    lasers[i].render();
    if (lasers[i].offscreen()) {
      lasers.splice(i, 1);
    } else {
      for (var j = asteroids.length - 1; j >= 0; j--) {
        if (lasers[i].hits(asteroids[j])) {
          if (asteroids[j].r > 19) {
            var new_ast = asteroids[j].breakup();
            asteroids = asteroids.concat(new_ast);
          }
          asteroids.splice(j, 1);
          lasers.splice(i, 1);
          break;
        }
      }
    }
  }

  ship.update();
  ship.edge();
  ship.turn();
  ship.render();

  if (asteroids.length <= 3) {
    for (var i = 0; i < 3; i++)
      asteroids.push(new Asteroid());
  }

}

function keyReleased() {
  ship.set_rotation(0);
  ship.boosting(false);
}

function keyPressed() {
  if (key == ' ')
    lasers.push(new Laser(ship.pos, ship.heading));
  else if (keyCode == RIGHT_ARROW)
    ship.set_rotation(0.1);
  else if (keyCode == LEFT_ARROW)
    ship.set_rotation(-0.1);
  else if (keyCode == UP_ARROW)
    ship.boosting(true);

}
