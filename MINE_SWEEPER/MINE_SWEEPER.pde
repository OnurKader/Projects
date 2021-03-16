Box[][] grid;
int rows, cols, w = 40;

int total_mine = 36;

void setup() {
  size(800, 800);
  background(1);
  rows = int(height / w);
  cols = int(width / w);
  grid = new Box[rows][cols];
  ArrayList<int[]> options = new ArrayList<int[]>();

  for (int i=0; i < rows; i++) {
    for (int j=0; j < cols; j++) {
      grid[i][j] = new Box(i, j, w);
      int[] option = new int[2];
      option[0] = i;
      option[1] = j;
      options.add(option);
    }
  }

  for (int a=0; a < total_mine; a++) {
    int index = int(random(options.size()));
    int[] choice = options.get(index);
    int i = choice[0];
    int j = choice[1];

    grid[i][j].has_mine = true;
    options.remove(index);
  }

  for (int i=0; i < rows; i++) {
    for (int j=0; j < cols; j++) {
      grid[i][j].count_mines();
    }
  }
}

void game_over() {
  for (int i=0; i < rows; i++) {
    for (int j=0; j < cols; j++) {
      grid[i][j].opened = true;
    }
  }
}

void mousePressed() {
  for (int i=0; i < rows; i++) {
    for (int j=0; j < cols; j++) {
      if (mouseButton == LEFT && grid[i][j].contains(mouseX, mouseY)) {
        grid[i][j].reveal();

        if (grid[i][j].has_mine) {
          game_over();
        }
      } else if (!grid[i][j].opened && mouseButton == RIGHT && grid[i][j].contains(mouseX, mouseY)) {
        grid[i][j].flagged = true;
        grid[i][j].opened = true;
      }
    }
  }
}

void draw() {
  background(250);
  for (int i=0; i < rows; i++) {
    for (int j=0; j < cols; j++) {
      grid[i][j].display();
    }
  }
}
