class Button {
  String label;
  float x, y, w, h;
  color c, og_c;

  Button(float _x, float _y, String _label, color _c) {
    rectMode(CENTER);
    x = _x;
    y = _y;
    w = 200;
    h = 50;
    label = _label;
    c = _c;
    og_c = _c;
  }
    Button(float _x, float _y, float _w, float _h, String _label, color _c) {
    rectMode(CENTER);
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    label = _label;
    c = _c;
    og_c = _c;
  }

  void update() {
    if (mouseOver()) {
      c = lerpColor(og_c, color(0), 0.3);
    } else {
      c = og_c;
    }
  }

  boolean mouseOver() {
    return(mouseX > x - w/2 && mouseX < x + w/2 &&
      mouseY > y - h/2 && mouseY < y + h/2);
  }
  void display() {
    fill(c);
    stroke(0);
    strokeWeight(2);

    rectMode(CENTER);
    rect(x, y, w, h, h/2);


    // Button text
    fill(0);
    noStroke();
    textAlign(CENTER, CENTER);
    textSize(20);
    text(label, x, y);
  }
}
