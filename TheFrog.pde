class Frog{
 
  // Position and dimensions
  float x, y;
  float w = 55;
  float h = 55;

  // Movement
  float previousY;
  float velocityY = 0;
  float gravity = 0.5;
  float jumpSpeed = -16;

  // Status
  boolean onGround = false;
  boolean canAirJump = false;

  // Image
  PImage frogImage;

  Frog(float startX, float startY, PImage img) {
    x = startX;
    y = startY;
    frogImage = img;
    velocityY = -12;
  }

  // Apply gravity and update position
  void update() {
    previousY = y;
    velocityY += gravity;
    y += velocityY;
  }

  // Display frog
  void display() {
    imageMode(CENTER);
    image(frogImage, x, y, w, h);
  }

  // Normal jump
  void jump() {
    velocityY = jumpSpeed;
    onGround = false;
  }
  
  void moveWithMouse() {
  x = constrain(mouseX, w/2, width - w/2);
  }
}
