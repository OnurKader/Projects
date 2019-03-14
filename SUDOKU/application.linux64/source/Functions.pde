void keyPressed() {
  if (key == ' ') {
    red = false;
  }
  if (key == 'q' || key == 'Q') {
    exit();
  }
  if (red) {
    for (char num : nums) {
      if (key == num) {
        game.input(key);
      }
    }
  }

  if (keyCode == UP) {
    p_i = (p_i + 8) % 9;
  } else if (keyCode == DOWN) {
    p_i = (p_i + 1) % 9;
  } else if (keyCode == RIGHT) {
    p_j = (p_j + 1) % 9;
  } else if (keyCode == LEFT) {
    p_j = (p_j + 8) % 9;
  }
}

Popup numpad = new Popup();
boolean popped = false;

void game_board(int input) {
  for (int j=0; j < 9; j++) {
    for (int i=0; i < 9; i++) {
      stroke(10);
      boolean hover = mouse_over(width/9 + j*tile_size, height/9 + i*tile_size, width/9 + (j+1)*tile_size, height/9 + (i+1)*tile_size);
      boolean press = mouse_over(width/9 + p_j*tile_size, height/9 + p_i*tile_size, width/9 + (p_j+1)*tile_size, height/9 + (p_i+1)*tile_size);

      if (hover && mousePressed && !popped) {
        red = true;
        p_i = i;
        p_j = j;
      }


      if (hover) {
        rectMode(CORNER);
        strokeWeight(3);
        fill(198, 231, 255);
        rect(width/9 + j*tile_size, height/9 + i*tile_size, tile_size, tile_size);
      } else {
        fill(241);
        rectMode(CORNER);
        strokeWeight(3);
        rect(width/9 + j*tile_size, height/9 + i*tile_size, tile_size, tile_size);
      }

      if (red) {
        fill(255, 64, 81);
        rectMode(CORNERS);
        strokeWeight(4);
        rect(width/9 + p_j*tile_size, height/9 + p_i*tile_size, width/9 + (p_j+1)*tile_size, height/9 + (p_i+1)*tile_size);
        //END OF RED
      }


      // Green - Yellow
      if (game.is_diff(i, j) && input == 0) { // USER MODIFIED
        if (game.grid[i][j] == game.carbon[i][j]) {// True - Green
          game.grid_copy[i][j] = game.grid[i][j];
          green.set(j + 9 * i, j + 9 * i);
        } else {
          if (game.grid[i][j] != 0) {
            yellow.set(j + 9 * i, j + 9 * i);
          } else {
            yellow.set(j + 9 * i, 0);
          }
        }
      }
    }
  }

  for (int elem : yellow) {
    int row, col;
    row = elem / 9;
    col = elem % 9;
    if (elem != 0) {
      rectMode(CORNER);
      strokeWeight(3);
      fill(241, 233, 77, 205);
      rect(width/9 + col*tile_size, height/9 + row*tile_size, tile_size, tile_size);
    }
  }

  for (int elem : green) {
    int row, col;
    row = elem / 9;
    col = elem % 9;
    if (elem != 0) {
      rectMode(CORNER);
      strokeWeight(3);
      fill(42, 251, 52, 222);
      rect(width/9 + col*tile_size, height/9 + row*tile_size, tile_size, tile_size);
    }
  }

  if (game.grid[0][0] == game.carbon[0][0] && !zeroth && input == USER) {
    rectMode(CORNER);
    strokeWeight(3);
    fill(42, 251, 52, 222);
    rect(width/9, height/9, tile_size, tile_size);
  }

  //Strokes every third
  for (int j = 0; j < 9; j++) {
    if (j % 3 == 0) {
      stroke(0);
      strokeWeight(7);
      line(width/9 + j*tile_size, height/9, width/9 + j*tile_size, height/9 + 9*tile_size);
    }
  }
  for (int i=0; i < 9; i++) {
    if (i % 3 == 0) {
      stroke(0);
      strokeWeight(7);
      line(width/9, height/9 + i*tile_size, width/9 + 9*tile_size, height/9 + i*tile_size);
    }
  }

  //Outer Shell
  stroke(0);
  rectMode(CORNERS);
  strokeWeight(7);
  noFill();
  rect(width/9, height/9, width/9 + 9*tile_size, height/9 + 9*tile_size);
}


void print_2D(int[][] a) {
  int cols = a[0].length;
  int rows = a.length;
  for (int i=0; i < rows; i++) {
    for (int j=0; j < cols; j++) {
      print(a[i][j] + " ");
    }
    println();
  }
}
