class Block {
  constructor(x, w, m, v, con) {
    this.x = x;
    this.y = height - w;
    this.w = w;
    this.v = v;
    this.m = m;
    this.x_constrain = con;
  }


  update() {
    this.x += this.v;
  }

  show() {
    const x = constrain(this.x, this.x_constrain, width);
    image(block_img, x, this.y, this.w, this.w);
  }

  collide(other) {
    return !(this.x + this.w < other.x || this.x > other.x + other.w)
  }

  bounce(other) {
    let summ = this.m + other.m;
    let n_v = (this.m - other.m) / summ * this.v;
    n_v += 2 * other.m / summ * other.v;
    return n_v;
  }

  wall() {
    return (this.x <= 0)
  }

  reverse() {
    this.v = -this.v;
  }


}