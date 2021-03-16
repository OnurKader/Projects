int tile_size;
Game game;
PImage[] numbers;
float time;

void setup() {
  //size(900, 900);
  fullScreen();
  orientation(PORTRAIT);
  background(186);
  tile_size = int(min(width, height) / 12) + 3;
  game = new Game();

  numbers = new PImage[9];
  numbers[0] = loadImage("one.png");
  numbers[1] = loadImage("two.png");
  numbers[2] = loadImage("three.png");
  numbers[3] = loadImage("four.png");
  numbers[4] = loadImage("five.png");
  numbers[5] = loadImage("six.png");
  numbers[6] = loadImage("seven.png");
  numbers[7] = loadImage("eight.png");
  numbers[8] = loadImage("nine.png");

  for (PImage number : numbers) {
    number.resize(78, 78);
  }


  game.onetwo();
  time = millis();
  game.generate(9);
  game.ready((int)random(40, 81 - 18));
  println("Took " + (millis() - time) + " ms to generate.");

  time = millis();
}

boolean mouse_over(int x1, int y1, int x2, int y2) {
  return (mouseX <= x2 && mouseX >= x1 && mouseY <= y2 && mouseY >= y1);
}

boolean mouse_over(float x1, float y1, float x2, float y2) {
  return (mouseX <= x2 && mouseX >= x1 && mouseY <= y2 && mouseY >= y1);
}

boolean not_over(float x1, float y1, float x2, float y2) {
  return (mouseX < x1 || mouseX > x2) || (mouseY < y1 || mouseY > y2);
}


void draw() {
  background(175);
  board(USER);
  karl();
  win_check();
}

void board(int test) {
  game_board(test); // USER - PC
  game.show();
  if (popped) {
    numpad.show();
  }

  if (red && popped && game.grid_copy[p_i][p_j] == -1 && mousePressed) {
    game.grid[p_i][p_j] = numpad.check();
  }
}

void win_check() {
  if (frameCount % 123 == 45) {
    if (game.win()) {
      noLoop();
      background(0, 233, 55);
      textSize(71);
      time = millis() - time;
      fill(254);
      if ((time / 1000.0) > 60.01) {
        textSize(58);
        text("It took you " + int((time / 1000.0) / 60) + " minutes and\n\t" + int((time/1000.0) % 60) + " secs.", 13, width/2 - 1);
      } else {
        text("It took you " + int(time / 1000.0) + " secs.", 17, width/2 - 1);
      }
    }
  }
}

// numpad mouse_over(-20 + numpad.pos.x + j*numpad.tile_size, 32 + numpad.pos.y + i*numpad.tile_size, -20 + numpad.pos.x + (j+1)*numpad.tile_size, 32 + numpad.pos.y + (i+1)*numpad.tile_size)

void karl() {
  boolean press = mouse_over(width/9 + p_j*tile_size, height/9 + p_i*tile_size, width/9 + (p_j+1)*tile_size, height/9 + (p_i+1)*tile_size);

  if (mousePressed && press) {
    numpad = new Popup(new PVector(mouseX + 5, mouseY + 5));
    popped = true;
  } else if (popped && mousePressed && not_over(-20 + numpad.pos.x, 32 + numpad.pos.y, -20 + numpad.pos.x + 3 * numpad.tile_size, 32 + numpad.pos.y + 3 * numpad.tile_size)) {
    popped = false;
  }
}
