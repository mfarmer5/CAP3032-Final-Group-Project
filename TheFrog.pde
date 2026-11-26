class Frog {

  // Position and dimensions
  float x, y;
  float w = 55;
  float h = 55;

  // Movement
  float previousY;
  float velocityX = 0;
  float velocityY = 0;
  float gravity = 0.5;

  // Movement settings
  float maxDrag = 150;
  float minDrag = 15;
  float powerScale = 0.15;

  // Status
  boolean onGround = false;
  boolean aiming = false;
  boolean canAirJump = false; // for bouncy platform
  boolean canJump = true;
  float dragStartX, dragStartY;
  Platform standingOn = null;

  // Image
  PImage frogImage;

  Frog(float startX, float startY, PImage img) {
    x = startX;
    y = startY;
    frogImage = img;
  }

  // Apply gravity and update position
  void update() {
    previousY = y;

    // Platform vanished under the frog? Start falling.
    if (standingOn != null && !standingOn.active) {
      standingOn = null;
      onGround = false;
      
      if (!canAirJump) {
        //aiming = false;
        //canAirJump = true;
      }
    }

    if (onGround) {
      velocityX = 0;
      velocityY = 0;
      return;
    }

    velocityY += gravity;
    x += velocityX;
    y += velocityY;

    if (x < w/2) {
      x = w/2;
      velocityX *= -1;
    } else if (x > width - w/2) {
      x = width - w/2;
      velocityX *= -1;
    }
  }

  // Display frog
  void display() {
    imageMode(CENTER);
    image(frogImage, x, y, w, h);
  }
  // Call from mousePressed()
  void startAim() {
    if (canJump && (onGround || canAirJump)) {
      aiming = true;
      dragStartX = mouseX;
      dragStartY = mouseY;
    }
  }

  // Call from mouseReleased()
  void releaseAim() {
    if (!aiming) return;
    aiming = false;

    float[] v = getLaunchVelocity();
    float dragAmount = dist(0, 0, v[0], v[1]) / powerScale;

    // Only jump if dragged far enough and the launch is upward
    if (dragAmount >= minDrag && v[1] < 0) {
      velocityX = v[0];
      velocityY = v[1];
      onGround = false;
      canAirJump = false;
      standingOn = null;
    }
  }

  // Launch velocity is the OPPOSITE of the drag direction, capped by maxDrag
  float[] getLaunchVelocity() {
    float dx = dragStartX - mouseX;
    float dy = dragStartY - mouseY;

    float d = dist(0, 0, dx, dy);
    if (d > maxDrag) {
      dx = dx / d * maxDrag;
      dy = dy / d * maxDrag;
    }
    return new float[] { dx * powerScale, dy * powerScale };
  }

  // Call this when the frog touches a platform
  void land(float newY) {
    y = newY;
    velocityX = 0;
    velocityY = 0;
    onGround = true;
    canAirJump = false;
  }

  // Draws the drag line and a dotted trajectory preview (call before display())
  void displayAim() {
    if (!aiming) return;

    float[] v = getLaunchVelocity();

    pushStyle();

    // Drag line
    stroke(255, 100);
    strokeWeight(2);
    line(dragStartX, dragStartY, mouseX, mouseY);

    // Trajectory preview
    noStroke();
    fill(255, 200);
    float px = x;
    float py = y;
    float vx = v[0];
    float vy = v[1];
    for (int i = 0; i < 25; i++) {
      vy += gravity;
      px += vx;
      py += vy;
      if (px < w/2 || px > width - w/2) vx *= -1;
      if (i % 2 == 0) ellipse(px, py, 6, 6);
    }

    popStyle();
  }

  // Automatic launch straight up (used by bouncy platforms)
  void bounce(float power) {
    velocityY = -power;
    onGround = false;
    canAirJump = true;
  }
}
