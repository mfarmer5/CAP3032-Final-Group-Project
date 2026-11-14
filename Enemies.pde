//ENEMY CLASS
class Enemies {
  
  //The enemy's position on the screen.
  float x, y;
  
  //The enemy's width and height
  float w, h;
  
  //Determines how fast the enemy moves
  float speed;
  
  //The minimum and maximum positioms that the enemy is allowed to travel betwen
  float minPosition;
  float maxPosition;
  
  //Determines which direction the enemy is moving
  //true = moving forward
  //false = moving backward
  boolean movingForward;
  
  //Determines the direction of movement
  //true = horizontal (left and right)
  //false = vertical (up and down)
  boolean horizontal;

  //Stores the bird sprite for this enemy
  PImage img;
  
  //The constructor creates a new enemy and assigns values to all of its variables.
  Enemies(float x, float y, float w, float h, float speed, float minPosition, float maxPosition, boolean horizontal, PImage img) {
    
    //Store the starting position
    this.x = x;
    this.y = y;
    
    //Store the enemy's dimensions
    this.w = w;
    this.h = h;
    
    //Store the enemy's movement speed
    this.speed = speed;
    
    //Store the movement boundaries
    this.minPosition = minPosition;
    this.maxPosition = maxPosition;
    
    //Decide whether  the enemy moves horizontally or vertically
    this.horizontal = horizontal;
    
    //Store the bird image
    this.img = img;

    //Make the enemy start by moving forward
    movingForward = true;
  }

  //It updates the enemy's position every frame.
  void update() {
    //Check whether the enemy moves horizontally
    if (horizontal) {
      //Move right if moving forward.
      //Move left if moving backward.
      if (movingForward == true) {
        x += speed;
      } else {
        x -= speed;
      }
      
      //Check if the enemy has reached either boundary
      if (x >= maxPosition || x <= minPosition) {
        //Reverse the movement direction
        movingForward = !movingForward;
      }
    } else {
      //If the enemy is not horizontal, it moves vertically instead. 
      //Move down if moving forward. Move up if moving backward.
      if (movingForward == true) {
        y += speed;  // Move down
      } else {
        y -= speed;  // Move up
      }
      
      //Check if the enemy has reached either boundary
      if (y >= maxPosition || y <= minPosition) {
        //Reverse the movement direction
        movingForward = !movingForward;
      }
    }
  }


  //This draws the enemy on the screen. 
  //For now, the enemy is just a red circle but that can be changed once we have an image.
  void display() {
    if (img != null) {
      imageMode(CENTER);
      image(img, x, y, w, h);
    } else {
      //Fallback red circle if no image is assigned
      fill(255, 70, 70);
      noStroke();
      ellipse(x, y, w, h);
    }
  }
}
