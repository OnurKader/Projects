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

  boolean win() {
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

  boolean check_sqr(int row_start, int col_start, int num) {
    for (int i=0; i < 3; i++) {
      for (int j=0; j < 3; j++) {
        if (grid[row_start + i][col_start + j] == num)
          return true;
      }
    }
    return false;
  }

  void reset() {
    for (int i=0; i < 9; i++) {
      num_arr.set(i, i+1);
    }
  }

  boolean empty() {
    for (int i = 0; i < 81; i++) {
      if (gen[i] == -1) {
        return true;
      }
    }
    return false;
  }

  boolean check_sqr(int index, int num) { // 11
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

  boolean check_col(int index, int num) {
    int row = index / 9;
    int col = index % 9;
    for (int i = 0; i < row; i++) {
      if (gen[col + 9 * i] == num) {
        return true;
      }
    }
    return false;
  }

  void swap_gen(int a, int b) {
    int temp = gen[a];
    gen[a] = gen[b];
    gen[b] = temp;
  }

  boolean check(int index, int val) { // Checks gen[]
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

  void onetwo() {
    num_arr.shuffle();
    for (int i = 0; i < 9; i++) {
      gen[i] = num_arr.pop();
    }
    reset();
  }

  int row_start(int index) {
    return index - (index % 9);
  }

  boolean solve(int row, int col) {
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

  void generate(int index) {
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

  void input(char num) {
    if (grid_copy[p_i][p_j] == -1) {
      grid[p_i][p_j] = num - 48;
    }
  }

  void show() {
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

  boolean is_diff(int row, int col) {
    return (grid[row][col] != grid_copy[row][col]);
  }

  void ready(int n) {
    for (int i=0; i < n; i++) {
      int row = int(random(0, 9));
      int col = int(random(0, 9));
      //It's already empty
      while(grid[row][col] < 1){
        row = int(random(0, 9));
        col = int(random(0, 9));
      }
      grid[row][col] = -1;
      grid_copy[row][col] = -1;
    }
    if (grid[0][0] != -1) {
      zeroth = true;
    }
  }
}
