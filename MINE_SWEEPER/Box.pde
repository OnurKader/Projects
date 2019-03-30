class Box {
  int x, y, w, mine_count, row, col;
  boolean has_mine, opened, flagged;

  Box(int row, int col, int w) {
    this.row = row;
    this.col = col;
    this.w = w;
    x = row * w;
    y = col * w;
    mine_count = 0;
    has_mine = false;
    opened = false;
    flagged = false;
  }

  void display() {
    stroke(0);
    noFill();
    rect(x, y, w, w);
    if (opened) {
      if (flagged) {
        fill(200, 50, 60);
        rect(x, y, w, w);
      } else if (has_mine) {
        fill(150);
        ellipse(x + w/2, y + w/2, w/2, w/2);
      } else if (!flagged) {
        fill(231);
        rect(x, y, w, w);
        if (mine_count > 0) {
          textAlign(CENTER);
          fill(1);
          textSize(26);
          text(mine_count, x + w/2, y + w/2 + 9);
        }
      }
    }
  }

  void count_mines() {
    if (has_mine) {
      mine_count = -1;
      return;
    }
    int total = 0;
    for (int xoff = -1; xoff <= 1; xoff++) {
      int cell_i = row + xoff;
      if (cell_i < 0 || cell_i >= rows) continue;
      for (int yoff = -1; yoff <= 1; yoff++) {
        int cell_j = col + yoff;
        if (cell_j < 0 || cell_j >= cols) continue;

        Box neighbour = grid[cell_i][cell_j];
        if (neighbour.has_mine) {
          total++;
        }
      }
    }
    mine_count = total;
  }

  boolean contains(int x, int y) {
    return (x >= this.x && x <= this.x + w && y >= this.y && y <= this.y + w);
  }

  void reveal() {
    opened = true;
    if (mine_count == 0) {
      flood();
    }
  }

  void flood() {
    for (int xoff = -1; xoff <= 1; xoff++) {
      int cell_i = row + xoff;
      if (cell_i < 0 || cell_i >= rows) continue;
      for (int yoff = -1; yoff <= 1; yoff++) {
        int cell_j = col + yoff;
        if (cell_j < 0 || cell_j >= cols) continue;

        Box neighbour = grid[cell_i][cell_j];
        if (!neighbour.opened) {
          neighbour.reveal();
        }
      }
    }
  }
}
