import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SUDOKU extends PApplet {

int tile_size;
Game game;
PImage[] numbers;
float time;

// _9_ ___ _25  | 193 764 825
// 4_5 2__ ___  | 475 298 316
// _6_ _3_ ___  | 862 135 974

// 28_ 3__ 1_9  | 286 347 159
// ___ 8_1 ___  | 549 821 637
// 3_7 __6 _48  | 317 956 248

// ___ _1_ _8_  | 724 619 583
// ___ __3 7_2  | 951 483 762
// 63_ ___ _9_  | 638 572 491

int[] a = {1, 9, 3, 7, 6, 4, 8, 2, 5};
int[] b = {4, 7, 5, 2, 9, 8, 3, 1, 6};
int[] c = {8, 6, 2, 1, 3, 5, 9, 7, 4};

int[] d = {2, 8, 6, 3, 4, 7, 1, 5, 9};
int[] e = {5, 4, 9, 8, 2, 1, 6, 3, 7};
int[] f = {3, 1, 7, 9, 5, 6, 2, 4, 8};

int[] g = {7, 2, 4, 6, 1, 9, 5, 8, 3};
int[] h = {9, 5, 1, 4, 8, 3, 7, 6, 2};
int[] i = {6, 3, 8, 5, 7, 2, 4, 9, 1};

int[][] test = {a, b, c, d, e, f, g, h, i};

public void setup() {
  
  //fullScreen();
  background(186);
  tile_size = PApplet.parseInt(min(width, height) / 12) + 3;
  frameRate(59);

  //game = new Game(test);
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

public boolean mouse_over(int x1, int y1, int x2, int y2) {
  return (mouseX <= x2 && mouseX >= x1 && mouseY <= y2 && mouseY >= y1);
}

public boolean mouse_over(float x1, float y1, float x2, float y2) {
  return (mouseX <= x2 && mouseX >= x1 && mouseY <= y2 && mouseY >= y1);
}

public boolean not_over(float x1, float y1, float x2, float y2) {
  return (mouseX < x1 || mouseX > x2) || (mouseY < y1 || mouseY > y2);
}


public void draw() {
  background(175);
  board(USER);
  karl();

  win_check();
}

public void board(int test) {
  game_board(test); // USER - PC
  game.show();
  if (popped) {
    numpad.show();
  }

  if (red && popped && game.grid_copy[p_i][p_j] == -1 && mousePressed) {
    game.grid[p_i][p_j] = numpad.check();
  }
}

public void win_check() {
  if (frameCount % 123 == 45) {
    if (game.win()) {
      noLoop();
      background(0, 233, 55);
      textSize(71);
      time = millis() - time;
      fill(254);
      if ((time / 1000.0f) > 60.01f) {
        textSize(58);
        text("It took you " + PApplet.parseInt((time / 1000.0f) / 60) + " minutes and\n\t" + PApplet.parseInt((time/1000.0f) % 60) + " secs.", 13, width/2 - 1);
      } else {
        text("It took you " + PApplet.parseInt(time / 1000.0f) + " secs.", 17, width/2 - 1);
      }
    }
  }
}

// numpad mouse_over(-20 + numpad.pos.x + j*numpad.tile_size, 32 + numpad.pos.y + i*numpad.tile_size, -20 + numpad.pos.x + (j+1)*numpad.tile_size, 32 + numpad.pos.y + (i+1)*numpad.tile_size)

public void karl() {
  boolean press = mouse_over(width/9 + p_j*tile_size, height/9 + p_i*tile_size, width/9 + (p_j+1)*tile_size, height/9 + (p_i+1)*tile_size);

  if (mousePressed && press) {
    numpad = new Popup(new PVector(mouseX + 5, mouseY + 5));
    popped = true;
  } else if (popped && mousePressed && not_over(-20 + numpad.pos.x, 32 + numpad.pos.y, -20 + numpad.pos.x + 3 * numpad.tile_size, 32 + numpad.pos.y + 3 * numpad.tile_size)) {
    popped = false;
  }
}

public void keyPressed() {
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

public void game_board(int input) {
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


public void print_2D(int[][] a) {
  int cols = a[0].length;
  int rows = a.length;
  for (int i=0; i < rows; i++) {
    for (int j=0; j < cols; j++) {
      print(a[i][j] + " ");
    }
    println();
  }
}
boolean red = false, zeroth = false;
int p_i, p_j;
char[] nums = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
IntList green, yellow;
int USER = 0, PC = 1;
int gen[];
IntList num_arr;

/* ------------------------------------------- */
// CLASS GAME \\
class Game {
  int[][] grid;
  int[][] grid_copy;
  int[][] carbon;

  Game() {
    grid = new int[9][9];
    grid_copy = new int[9][9];
    carbon = new int[9][9];
    green = new IntList();
    yellow = new IntList();
    num_arr = new IntList();

    for (int i = 1; i < 10; i++) {
      num_arr.append(i);
    }

    gen = new int[81];
    for (int i=0; i < 81; i++) {
      gen[i] = -1;
    }

    for (int j=0; j < 9; j++) {
      for (int i=0; i < 9; i++) {
        grid[i][j] = -1;
        grid_copy[i][j] = -1;
        carbon[i][j] = 0;
      }
    }
  }

  Game(int[][] s) {
    grid = new int[9][9];
    grid_copy = new int[9][9];
    carbon = new int[9][9];
    yellow = new IntList();
    num_arr = new IntList();
    green = new IntList();
    gen = new int[81];

    for (int i=0; i < 81; i++) {
      gen[i] = -1;
    }

    for (int i=0; i < 9; i++) {  
      grid[i] = s[i];
    }

    for (int i = 1; i < 10; i++) {
      num_arr.append(i);
    }

    for (int i=0; i < 9; i++) {
      for (int j=0; j < 9; j++) {
        grid_copy[i][j] = grid[i][j];
        carbon[i][j] = grid[i][j];
      }
    }
  }

  public boolean win() {
    boolean zeros = false;

    for (int i=0; i < 9; i++) {
      for (int j=0; j < 9; j++) {
        if (grid[i][j] == 0 || grid[i][j] == -1) {
          zeros = true;
        }
      }
    }

    boolean same = true;
    if (!zeros) {
      for (int i=0; i < 9; i++) {
        for (int j=0; j < 9; j++) {
          if (grid[i][j] != carbon[i][j]) {
            same = false;
          }
        }
      }
    }
    return same && !zeros;
  }

  public boolean check_sqr(int row_start, int col_start, int num) {
    for (int i=0; i < 3; i++) {
      for (int j=0; j < 3; j++) {
        if (grid[row_start + i][col_start + j] == num)
          return true;
      }
    }
    return false;
  }

  public void reset() {
    for (int i=0; i < 9; i++) {
      num_arr.set(i, i+1);
    }
  }

  public boolean empty() {
    for (int i = 0; i < 81; i++) {
      if (gen[i] == -1) {
        return true;
      }
    }
    return false;
  }

  public boolean check_sqr(int index, int num) { // 11
    int row = index / 9; // 1
    int col = index % 9; // 2
    int square_num = (row / 3) * 3 + (col / 3); // 0
    int row_start = (square_num / 3) * 3;
    int col_start = square_num % 3 * 3;

    for (int i = row_start; i < row_start + 3; i++) {
      for (int j = col_start; j < col_start + 3; j++) {
        if (gen[j + 9 * i] == num) {
          return true;
        }
      }
    }
    return false;
  }

  public boolean check_col(int index, int num) {
    int row = index / 9;
    int col = index % 9;
    for (int i = 0; i < row; i++) {
      if (gen[col + 9 * i] == num) {
        return true;
      }
    }
    return false;
  }

  public void swap_gen(int a, int b) {
    int temp = gen[a];
    gen[a] = gen[b];
    gen[b] = temp;
  }

  public boolean check(int index, int val) { // Checks gen[]
    int row = index / 9;
    int col = index % 9;

    if (check_sqr(index, val)) {
      return true;
    }

    //TODO CHecK BOttOM https://stackoverflow.com/questions/6963922/java-sudoku-generatoreasiest-solution

    for (int i = 0; i < 9; i++) {
      if (gen[col + i * 9] == val) {
        return true;
      }
    }

    for (int j = 0; j < 9; j++) {
      if (gen[row * 9 + j] == val) {
        return true;
      }
    }
    return false;
  }

  public void onetwo() {
    num_arr.shuffle();
    for (int i = 0; i < 9; i++) {
      gen[i] = num_arr.pop();
    }
    reset();
  }

  public int row_start(int index) {
    return index - (index % 9);
  }

  public boolean solve(int row, int col) {
    int index = col + 9 * row;

    if (col == 9) {
      col = 0;
      row++;

      if (row == 9) {
        return true;
      }
    }

    if (gen[col + 9*row] > 0) {
      return solve(row, col + 1);
    }

    for (int val = 1; val < 10; val++) {
      index = col + 9 * row;
      if (!check(index, val)) {
        gen[index] = val;
        if (solve(row, col + 1)) {
          return true;
        }
      }
    }

    gen[index] = -1;
    return false;
  }  

  public void generate(int index) {
    int row = index / 9;
    int col = index % 9;
    solve(row, col);

    for (int i=0; i < 9; i++) {
      for (int j=0; j < 9; j++) {
        grid_copy[i][j] = gen[j + 9*i];
        grid[i][j] = grid_copy[i][j];
        carbon[i][j] = grid_copy[i][j];
      }
    }
  }

  public void input(char num) {
    if (grid_copy[p_i][p_j] == -1) {
      grid[p_i][p_j] = num - 48;
    }
  }

  public void show() {
    for (int j=0; j < 9; j++) {
      for (int i=0; i < 9; i++) {
        imageMode(CORNER);
        switch(grid[i][j]) {
        case 1: 
          image(numbers[0], 4 + width/9 + j * tile_size, 3 + height/9 + i * tile_size); 
          break;
        case 2:
          image(numbers[1], 1 + width/9 + j * tile_size, 1 + height/9 + i * tile_size); 
          break;
        case 3:
          image(numbers[2], 2 + width/9 + j * tile_size, 1 + height/9 + i * tile_size); 
          break;
        case 4:
          image(numbers[3], 2 + width/9 + j * tile_size, 3 + height/9 + i * tile_size); 
          break;
        case 5:
          image(numbers[4], 1 + width/9 + j * tile_size, 3 + height/9 + i * tile_size); 
          break;
        case 6:
          image(numbers[5], 0 + width/9 + j * tile_size, 3 + height/9 + i * tile_size);
          break;
        case 7:
          image(numbers[6], 1 + width/9 + j * tile_size, 3 + height/9 + i * tile_size);
          break;
        case 8:
          image(numbers[7], 0 + width/9 + j * tile_size, 3 + height/9 + i * tile_size); 
          break;
        case 9:
          image(numbers[8], 0 + width/9 + j * tile_size, 2 + height/9 + i * tile_size);
          break;
        default:
          break;
        }
      }
    }
  }

  public boolean is_diff(int row, int col) {
    return (grid[row][col] != grid_copy[row][col]);
  }

  public void ready(int n) {
    for (int i=0; i < n; i++) {
      int row = PApplet.parseInt(random(0, 9));
      int col = PApplet.parseInt(random(0, 9));
      //It's already empty
      while(grid[row][col] < 1){
        row = PApplet.parseInt(random(0, 9));
        col = PApplet.parseInt(random(0, 9));
      }
      grid[row][col] = -1;
      grid_copy[row][col] = -1;
    }
    if (grid[0][0] != -1) {
      zeroth = true;
    }
  }
}

class Popup {
  PVector pos;
  int tile_size;

  Popup() {
    pos = new PVector(-164, -164);  
    this.tile_size = 69;
  }

  Popup(PVector mm) {
    pos = mm.copy();  
    this.tile_size = 69;
  }

  public void show() {
    for (int i=0; i < 3; i++) {
      for (int j=0; j < 3; j++) {
        stroke(8);
        strokeWeight(4);
        rectMode(CORNER);
        fill(238, 238, 252, 242);
        rect(-20 + pos.x + j * tile_size, 32 + pos.y + i * tile_size, tile_size, tile_size);
        imageMode(CORNER);
        image(numbers[j + 3*i], -20 + pos.x + j * tile_size, 32 + pos.y + i * tile_size, tile_size, tile_size);
      }
    }
  }

  public int check() {
    int val = -1;
    for (int i=0; i < 3; i++) {
      for (int j=0; j < 3; j++) {
        int index = j + 3 * i;
        if (mouse_over(-20 + pos.x + j*tile_size, 32 + pos.y + i*tile_size, -20 + pos.x + (j+1)*tile_size, 32 + pos.y + (i+1)*tile_size) && mousePressed) {
          switch(index) {
          case 0: 
            val = 1;
            break;
          case 1: 
            val = 2;
            break;
          case 2: 
            val = 3;
            break;
          case 3: 
            val = 4;
            break;
          case 4: 
            val = 5;
            break;
          case 5: 
            val = 6;
            break;
          case 6: 
            val = 7;
            break;
          case 7: 
            val = 8;
            break;
          case 8: 
            val = 9;
            break;
          }
        }
      }
    }
    return val;
  }
}
  public void settings() {  size(900, 900); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SUDOKU" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
