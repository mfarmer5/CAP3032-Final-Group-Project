class Platform {
  float x, y, w, h;
  color padColor;
  float prescaler = random(2, 2.5);
  float opacity = 255;
  boolean active = true;

  Platform(float _x, float _y, float _w, float _h, color _c) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    padColor = _c;
  }

  // Top surface of the platform
  float top() {
    return y - h/2;
  }

  // Check whether the frog lands on the platform
  boolean landedOn(float frogX, float previousY, float currentY,
    float frogW, float frogH) {
    if (!active) return false;

    // Frog's bottom edge before and after movement
    float previousBottom = previousY + frogH/2;
    float currentBottom = currentY + frogH/2;

    // Check if frog crosses the platform from above
    boolean crossedTop = previousBottom <= top() &&
      currentBottom >= top();

    // Check horizontal overlap
    boolean overlapsX = frogX + frogW/2 > x - w/2 &&
      frogX - frogW/2 < x + w/2;

    return crossedTop && overlapsX;
  }

  void display(color bgColor) {
    if (!active) return;

    pushStyle();

    // Shadow
    noStroke();
    fill(0, 35 * opacity / 255.0);
    ellipse(x + 3, y + 4, w, h);

    // Lily pad body
    fill(padColor, opacity);
    stroke(red(padColor) * 0.55,
      green(padColor) * 0.55,
      blue(padColor) * 0.55, opacity);
    strokeWeight(2);
    ellipse(x, y, w, h);

    // Cut out a small wedge to create the lily pad notch
    noStroke();
    fill(bgColor, opacity);

    float angle = radians(32);

    float notchX1 = x + cos(-angle) * w;
    float notchY1 = y + sin(-angle) * h/prescaler;

    float notchX2 = x + cos(angle) * w;
    float notchY2 = y + sin(angle) * h/prescaler;

    triangle(x, y, notchX1, notchY1, notchX2, notchY2);

    // Lily pad veins
    stroke(red(padColor) * 0.55,
      green(padColor) * 0.55,
      blue(padColor) * 0.55, opacity);
    strokeWeight(1.5);

    for (float a = 0.8; a < TWO_PI - 0.8; a += 0.55) {
      float endX = x + cos(a) * w * 0.38;
      float endY = y + sin(a) * h * 0.38;

      line(x, y, endX, endY);
    }

    popStyle();
  }

  void update() { // other classes will override
  }

  void onLand(Frog frog) { // other classes will override
  }
}
