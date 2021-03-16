// Yellow, Blue, Red, Purple, Orange, Green, Brown, 8 - BLACK
final int X = 0;
final int Y = 1;
final float max_vel = 18;

color[] colors = {color(242, 242, 242), color(240, 187, 76), color(42, 60, 128), 
    color(183, 15, 15), color(40, 20, 86), 
    color(255, 120, 40), color(2, 108, 45), 
    color(100, 25, 30), color(25, 25, 25)};

class Ball {
    PVector pos, vel, acc;
    final int num;
    float angle;
    final static float size = 20;
    float mass;
    boolean in_pocket, moving;

    Ball(PVector pos, int num) {
        this.num = num;
        this.pos = pos.copy();
        vel = new PVector();
        acc = new PVector();
        angle = 0.f;
        in_pocket = false;
        moving = false;
        mass = map(size, 15, 25, 0.75, 1.5);
    }

    void apply_force(PVector force) {
        acc.add(force.div(mass));
    }

    void update() {
        vel.add(acc);
        pos.add(vel);
        acc.mult(0);

        angle = vel.heading();
        vel.mult(0.9932);
        edges();
        pockets();
        vel.limit(max_vel);
        pos.x = constrain(pos.x, 0, width);
        pos.y = constrain(pos.y, 0, height);

        if (vel.mag() > 0.086) {
            moving = true;
        } else {
            moving = false;
            vel.setMag(0);
        }
    }

    void display() {
        if (!in_pocket) {
            stroke(0, 200);
            strokeWeight(1);
            if (this.num < 9) {
                fill(colors[this.num]);
                // Ball
                circle(pos.x, pos.y, size * 2);
            } else {
                fill(colors[this.num - 8]);
                // Ball
                circle(pos.x, pos.y, size * 2);
                stroke(255);
                strokeWeight(6);
                line(pos.x - size + 4, pos.y, pos.x + size - 4, pos.y);
            }
        } else {
            pos.mult(0);
        }
    }

    void bounce(int ax) {
        if (ax == 0) {
            vel.x = -vel.x;
        } else {
            vel.y = -vel.y;
        }
        vel.mult(0.97);
    }

    PVector[] pockets = {new PVector(60, 68), new PVector(width/2, 41), new PVector(width - 60, 68), new PVector(60, height - 69), new PVector(width/2, height - 44), new PVector(width - 60, height - 69)};

    void pockets() {
        float d = 0.f;
        for (PVector pocket : pockets) {
            d = dist(pos.x, pos.y, pocket.x, pocket.y);
            if (d <= 36) {
                in_pocket = true;
                angle = 0.f;
            }
        }
    }

    void edges() {
        // Horizontal Check
        if (pos.y - size <= 67 && ((pos.x >= 111 && pos.x <= width/2 - 24) || (pos.x >= width/2 + 24 && pos.x <= width - 111))) { // Upper Line
            bounce(Y);
            pos.y += 3;
        } else if (pos.y + size >= height - 71 && ((pos.x >= 111 && pos.x <= width/2 - 24) || (pos.x >= width/2 + 24 && pos.x <= width - 111))) { // Bottom Line
            bounce(Y);
            pos.y -= 3;
        }

        // Vertical Check
        if (pos.x - size <= 61 && ((pos.y >= 124) || (pos.y <= height - 124))) {
            bounce(X);
            pos.x += 3;
        } else if (pos.x + size >= width - 61 && ((pos.y >= 124) || (pos.y <= height - 124))) {
            bounce(X);
            pos.x -= 3;
        }
    }

    void reset() {
        pos = middle.copy();
        in_pocket = false;
        vel.mult(0);
    }

    void collide(Ball other) {
        PVector dist = PVector.sub(other.pos, this.pos);
        float n_dist = dist.mag();

        if (n_dist < 1 + this.size + other.size) {
            dist = dist.normalize();
            this.pos.sub(dist.mult(0.1));

            PVector _dist = PVector.sub(this.pos, other.pos);
            _dist = _dist.normalize();

            PVector n_v = new PVector(_dist.x, _dist.y);
            n_v.normalize();

            float v_store = other.vel.mag();

            this.vel.mult(0.972);
            other.vel.mult(0.958);

            this.apply_force(_dist.mult(0.5*v_store));
            other.apply_force(n_v.mult(-0.5*v_store));
        }
    }
}
