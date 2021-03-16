PImage table;
Ball[] balls;
float root_3;
PVector middle;
Player p_1, p_2;
int turn = 0;

boolean selected;
boolean game_over;
boolean won;

IntList balls_in_pocket = new IntList();

void setup() {
    size(1280, 800);
    background(0);
    smooth();
    this.surface.setTitle("8-Ball Pool");
    selected = false;
    middle = new PVector(width/3 - 75, height/2 - 1);
    table = loadImage("pool_bg.png");
    table.resize(width, height);
    root_3 = sqrt(3.f);

    p_1 = new Player(0);
    p_2 = new Player(1);

    won = false;
    game_over = false;

    balls = new Ball[16];

    balls[0] = new Ball(middle, 0);
    float ball_3 = Ball.size*root_3;

    balls[1]   = new Ball(new PVector(width/2 + 152 + 0 * ball_3, height/2 + 0 * Ball.size + 0 * 5), 1);
    balls[2]   = new Ball(new PVector(width/2 + 152 + 1 * ball_3, height/2 - 1 * Ball.size + -1 * 5), 2);
    balls[3]   = new Ball(new PVector(width/2 + 152 + 1 * ball_3, height/2 + 1 * Ball.size + 1 * 5), 3);
    balls[4]   = new Ball(new PVector(width/2 + 152 + 2 * ball_3, height/2 - 2 * Ball.size + -2 * 5), 4);
    balls[5]   = new Ball(new PVector(width/2 + 152 + 2 * ball_3, height/2 + 0 * Ball.size + 0 * 5), 8);
    balls[6]   = new Ball(new PVector(width/2 + 152 + 2 * ball_3, height/2 + 2 * Ball.size + 2 * 5), 6);
    balls[7]   = new Ball(new PVector(width/2 + 152 + 3 * ball_3, height/2 - 3 * Ball.size + -3 * 5), 7);
    balls[8]   = new Ball(new PVector(width/2 + 152 + 3 * ball_3, height/2 - 1 * Ball.size + -1 * 5), 5);
    balls[9]   = new Ball(new PVector(width/2 + 152 + 3 * ball_3, height/2 + 1 * Ball.size + 1 * 5), 9);
    balls[10]  = new Ball(new PVector(width/2 + 152 + 3 * ball_3, height/2 + 3 * Ball.size + 3 * 5), 10);
    balls[11]  = new Ball(new PVector(width/2 + 152 + 4 * ball_3, height/2 - 4 * Ball.size + -4 * 5), 11);
    balls[12]  = new Ball(new PVector(width/2 + 152 + 4 * ball_3, height/2 - 2 * Ball.size + -2 * 5), 12);
    balls[13]  = new Ball(new PVector(width/2 + 152 + 4 * ball_3, height/2 - 0 * Ball.size + 0 * 5), 13);
    balls[14]  = new Ball(new PVector(width/2 + 152 + 4 * ball_3, height/2 + 2 * Ball.size + 2 * 5), 14);
    balls[15]  = new Ball(new PVector(width/2 + 152 + 4 * ball_3, height/2 + 4 * Ball.size + 4 * 5), 15);

    balls[0].mass = 1.666;
}

void mousePressed() {
    float d = dist(mouseX, mouseY, balls[0].pos.x, balls[0].pos.y);
    if (d <= balls[0].size + 2 && mousePressed) {
        selected = true;
    } else {
        selected = false;
    }
}

void keyPressed() {
    if (key == ' ') {
        balls[0].reset();
    }
}

void mouseReleased() {
    PVector head = new PVector(mouseX - balls[0].pos.x, mouseY - balls[0].pos.y);
    head.div(max_vel * -0.9);
    if (selected && !balls[0].moving) {
        balls[0].apply_force(head);
        turn++;
    }
}

void arrow() {
    PVector head = new PVector(balls[0].pos.x - mouseX, balls[0].pos.y - mouseY);
    if (mousePressed && selected && !balls[0].moving) {
        float lol = map(head.mag(), 0, width/2 - 50, 0, 1);
        color col = lerpColor(color(60, 250, 100), color(250, 50, 60), lol);
        stroke(col, 222);
        strokeWeight(4);
        line(mouseX, mouseY, balls[0].pos.x, balls[0].pos.y);
    }
}

void draw() {
    background(table);
    turn %= 2;
    for (int i = balls.length - 1; i >= 0; i--) {
        Ball ball = balls[i];

        for (int j = 0; j < balls.length; j++) {
            if (i != j) {
                ball.collide(balls[j]);
            }
        }
        ball.update();
        ball.display();

        if (ball.in_pocket && ball != balls[0]) {
            balls_in_pocket.appendUnique(ball.num);
            balls_in_pocket.sort();
        }
    }

    println(balls_in_pocket);

    arrow();
    if (balls[0].in_pocket) {
        balls[0].reset();
    } else if (balls[5].in_pocket) {
        game_over = true;
    }

    textAlign(CENTER);
    stroke(0);
    strokeWeight(20);
    textSize(38);
    fill(58, 255, 81);
    text("Player " + nf(turn + 1, 1) + "'s Turn!", width/2 + 360, 38);


    if (game_over) {
        background(65, 250, 85);
        textSize(66);
        textAlign(CENTER);
        fill(255);
        text("GAME OVER!", width/2, height/2);
        noLoop();
    }
}
