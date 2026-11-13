class Platform {
  float x, y, w, h;
  color padColor;
  float prescaler = random(2,2.5);

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
    pushStyle();

    // Shadow
    noStroke();
    fill(0, 35);
    ellipse(x + 3, y + 4, w, h);

    // Lily pad body
    fill(padColor);
    stroke(35, 100, 60);
    strokeWeight(2);
    ellipse(x, y, w, h);

    // Cut out a small wedge to create the lily pad notch
    noStroke();
    fill(bgColor);

    float angle = radians(32);
    
    float notchX1 = x + cos(-angle) * w;
    float notchY1 = y + sin(-angle) * h/prescaler;

    float notchX2 = x + cos(angle) * w;
    float notchY2 = y + sin(angle) * h/prescaler;

    triangle(x, y, notchX1, notchY1, notchX2, notchY2);

    // Lily pad veins
    stroke(35, 115, 65);
    strokeWeight(1.5);

    for (float a = 0.8; a < TWO_PI - 0.8; a += 0.55) {
      float endX = x + cos(a) * w * 0.38;
      float endY = y + sin(a) * h * 0.38;

      line(x, y, endX, endY);
    }

    popStyle();
  }
}
