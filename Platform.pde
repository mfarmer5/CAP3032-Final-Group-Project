PImage normalPad;
PImage bouncyPad;
PImage temporaryPad;


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
      
    // Tweak landing range for accurate collision
    float frogHitbox = frogW * 0.7;
    float padHitbox = w * 0.9;

    // Check horizontal overlap
    boolean overlapsX = frogX + frogHitbox/2 > x - padHitbox/2 &&
      frogX - frogHitbox/2 < x + padHitbox/2;

    return crossedTop && overlapsX;
  }

  void display(color bgColor, PImage padImage) {
    if (!active || padImage == null) return;

    pushStyle();
  
    imageMode(CENTER);
    tint(255, opacity);
  
    // Lily pad image sizing
    float displayW = w * 0.98;
    float displayH = h * 1.0;
  
    image(padImage, x, y, displayW, displayH);
  
    popStyle();
  }

  void update() { // other classes will override
  }

  void onLand(Frog frog) { // other classes will override
  }
}
