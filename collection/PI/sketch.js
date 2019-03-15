let block_img;
let block1;
let block2;
let clack;

let count_div;
let count = 0;
let digits = 6;
const time_step = 52000;

function preload() {
  block_img = loadImage("pi.jpeg");
  clack = loadSound("clack.wav");
}

function setup() {
  createCanvas(windowWidth, 450);
  block1 = new Block(250, 80, 1, 0, 0);
  let mass = pow(100, digits);
  block2 = new Block(width / 2 - 200, 275, mass, -5 / time_step, 80);
  count_div = createDiv(count);
  count_div.style("font-size", "69pt");

}

function draw() {
  let should_clack = false;

  background(196, 79, 142);
  stroke(1, 250);
  strokeWeight(8);
  for (let i = 0; i < time_step; i++) {
    block1.update();
    if (block1.collide(block2)) {
      const v1 = block1.bounce(block2);
      const v2 = block2.bounce(block1);
      // clack.play();
      should_clack = true;
      block1.v = v1;
      block2.v = v2;
      count++;
    }

    block2.update();
    if (block1.wall()) {
      block1.reverse();
      // clack.play();
      should_clack = true;
      count++;
    }

  }
  count_div.html(nf(count, digits + 1));
  block1.show();
  block2.show();
  line(0, height, width, height);
  line(0, 0, 0, height);
  if (should_clack) {
    clack.play();
  }
}