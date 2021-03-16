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

  void show() {
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

  int check() {
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
