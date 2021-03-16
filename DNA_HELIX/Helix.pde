class Helix {
    PVector pos;
    int rep;
    int z_mul = 88;
    float phase;
    int off = floor(random(4));
    color colors[] = {color(60, 75, 250), color(50, 250, 60), color(250, 250, 60), color(250, 60, 50)};

    Helix(int repeat, float phase) { 
        pos = new PVector(width/128, height/7, 0);
        rep = repeat;
        this.phase = phase;
    }

    void display() {
        float x, y, z, t;
        float r = 200;
        pushMatrix();
        pushStyle();
        translate(pos.x, pos.y, pos.z);
        rotateX(HALF_PI);
        beginShape();
        for (t = 0; t <= rep * TWO_PI; t += PI/30) {
            x = r * cos(t + phase);
            y = r * sin(t + phase);
            z = -t * z_mul;

            stroke(161, 82, 255);
            strokeWeight(10);
            noFill();
            vertex(x, y, z);
        }
        endShape();
        popStyle();

        int i = 0;
        for (t = 0; t <= rep * TWO_PI; t += QUARTER_PI * 1.25) {
            x = r * cos(t + phase);
            y = r * sin(t + phase);
            z = -t * z_mul;
            stroke(colors[(i + off) % 4]);
            strokeWeight(7);
            noFill();
            line(x, y, z, 0, 0, z);
            i++;
        }

        popMatrix();
    }
}
