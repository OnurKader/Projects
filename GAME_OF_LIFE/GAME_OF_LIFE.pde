int[][] grid;
int rows, cols;
int resolution;
boolean start = false;
int fps = 5;

void setup() {
  size(1296, 780);
  smooth();
  background(1);
  resolution = 12;
  rows = height / resolution;
  cols = width / resolution;

  grid = new int[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (start) {
        grid[i][j] = int(random(2)); // Random
      } else {
        grid[i][j] = 0;
      }
    }
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  fps -= e;
  fps = constrain(fps, 1, 144);
}

void mousePressed() {
  if (!start) {
    if (mouseButton == LEFT && grid[m_i][m_j] != 1) {
      grid[m_i][m_j] = 1;
    } else if (mouseButton == RIGHT && grid[m_i][m_j] != 0) {
      grid[m_i][m_j] = 0;
    }
  }
}

void mouseDragged() {
  if (!start) {
    if (mouseButton == LEFT && grid[m_i][m_j] != 1) {
      grid[m_i][m_j] = 1;
    } else if (mouseButton == RIGHT && grid[m_i][m_j] != 0) {
      grid[m_i][m_j] = 0;
    }
  }
}

void keyPressed() {
  if (key == 'q') {
    exit();
  }
  if (key == ' ') {
    start = !start;
  }
  if (key == 'c') {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) { 
        grid[i][j] = 0;
      }
    }
  }
}

int m_i = 0, m_j = 0;

void draw() {
  background(192);
  m_i = (mouseY / resolution);
  m_j = (mouseX / resolution);
  m_i = constrain(m_i, 0, rows - 1);
  m_j = constrain(m_j, 0, cols - 1);

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int x = j * resolution;
      int y = i * resolution;
      if (grid[i][j] == 1) {
        fill(240);
        stroke(0);
        rect(x, y, resolution, resolution);
      }
    }
  }

  if (!start) {
    frameRate(144);
    fill(60, 80, 200, 240);
    stroke(1);
    rect(m_j * resolution, m_i * resolution, resolution, resolution);
  }

  int[][] next = new int[rows][cols];
  if (start) {
    frameRate(fps);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        int state = grid[i][j];
        int sum = 0;
        int neighbors = count_neighbours(grid, i, j);

        if (state == 0 && neighbors == 3) {
          next[i][j] = 1;
        } else if (state == 1 && (neighbors < 2 || neighbors > 3)) {
          next[i][j] = 0;
        } else {
          next[i][j] = state;
        }
      }
    }

    grid = next;
  }
}

int count_neighbours(int[][] arr, int i, int j) {
  int sum = 0;
  for (int x = -1; x < 2; x++) {
    for (int y = -1; y < 2; y++) {
      int row = (y + i + rows) % rows;
      int col = (x + j + cols) % cols;
      sum += grid[row][col];
    }
  }
  sum -= grid[i][j];
  return sum;
}
