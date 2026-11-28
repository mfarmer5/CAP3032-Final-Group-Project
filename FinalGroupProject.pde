import processing.sound.*;

PImage frog1, frog2, frog3, blueBird, darkPurpleBird, lightPurpleBird, pinkBird, redBird;
SoundFile menuMusic, win, lose, jump, gameplayMusic, forestSounds, rumble, landing, button;

// Buttons
Button normal;
Button endless;

// Platforms (for debugging)
Platform p1;
BouncyPlatform p2;
TemporaryPlatform p3;

// Platform manager
PlatformManager platforms;

//Enemies
ArrayList<Enemies> enemies;

// Levels
Levels levelNormal, levelEndless;

// Frog
Frog frog;

// Custom Font
PFont pixelFont;

// Vars
int gameState; // 0 = menu, 1 = normal, 2 = endless, 3 = game over, 4 = win
int rumbleStopTime = 0;

void setup() {
  size(500, 800);
  frameRate(60);

  // Load custom font
  pixelFont = createFont("zx_spectrum-7.ttf", 64);
  textFont(pixelFont);

  //Loads images and music
  //frog1 = loadImage("frog1.png");
  frog2 = loadImage("frog2.png");
  //frog3 = loadImage("frog3.png");
  redBird = loadImage("redBird.png");
  blueBird = loadImage("bird enemies (blue).png");
  darkPurpleBird = loadImage("bird enemies (dark purple).png");
  //lightPurpleBird = loadImage("bird enemies (light purple).png");
  //pinkBird = loadImage("bird enemies (pink).png");
  normalPad = loadImage("normalPad.png");
  bouncyPad = loadImage("bouncyPad.png");
  temporaryPad = loadImage("temporaryPad.png");

  menuMusic = new SoundFile(this, "menuMusic.mp3"); //Main menu music for when the game first opens
  win = new SoundFile(this, "win.mp3"); //music for when the user wins
  lose = new SoundFile(this, "lose.mp3"); //when the user falls this sound appears 
  jump = new SoundFile(this, "jump.mp3"); //jump sound for the bouncy lily pads
  rumble = new SoundFile(this, "ripple.mp3"); //For temporary platform
  landing = new SoundFile(this, "landing.mp3");//For normal lily pads
  gameplayMusic = new SoundFile(this, "gameplayMusic.mp3"); //background music for when the the user is playing in either endless or story mode
  forestSounds = new SoundFile(this, "forestSounds.mp3"); //if possible play these two sounds at the same time
  button = new SoundFile(this, "button.mp3");//for buttons on the main menu

  // Initialize buttons (def. w,h is 200,50. def. textSize is 20)
  normal = new Button(width/2, height/2 + 100, 300, 50, "Normal Mode", 30, color(#659B5E));
  endless = new Button(width/2, height/2 + 170, 280, 50, "Endless Mode", 28, color(#659B5E));

  // Platform setup
  platforms = new PlatformManager();

  // Initialize enemies list and spawn sample enemies
  enemies = new ArrayList<Enemies>();
  // Horizontal enemy: (x, y, w, h, speed, minPos, maxPos, horizontal)
  enemies.add(new Enemies(250, 520, 350, 350, 3, 50, 450, true, blueBird));
  // Vertical enemy: (x, y, w, h, speed, minPos, maxPos, horizontal)
  enemies.add(new Enemies(100, 380, 350, 350, 2, 200, 550, false, darkPurpleBird));

  state(0);
}

void state(int newState) {
  menuMusic.stop();
  gameplayMusic.stop();
  forestSounds.stop();
  win.stop();
  lose.stop();

  gameState = newState;

  if (newState == 0) {
    menuMusic.loop();
  } else if (newState == 1 || newState == 2) {
    gameplayMusic.loop();
    forestSounds.loop();
  } else if (newState == 3) {
    lose.play();
  } else if (newState == 4) {
    win.play();
  }
}

void draw() {
  if (rumbleStopTime > 0 && millis() > rumbleStopTime) {
    rumble.stop();
    rumbleStopTime = 0;  
  }

  switch(gameState) {
  case 0:
    background(#B8DDE5);

    // buttons
    normal.update();
    normal.display();

    endless.update();
    endless.display();

    break;

  case 1:
    background(#B8DDE5);

    // Update platforms and frog
    platforms.update();
    frog.update();
    platforms.checkLanding(frog);
    platforms.scroll(frog, enemies);

    // Display platforms and frog
    platforms.display();
    frog.displayAim();
    frog.display();

    //Update and draw all enemies
    for (Enemies e : enemies) {
      e.update();
      e.display();
    }

    // Score
    fill(0);
    textAlign(LEFT, TOP);
    textSize(24);
    int score = (int)platforms.scrolled / 10;
    if (score < 1000) text("Until End : " + (1000 - score), 15, 15);

    if (frog.y - frog.h/2 > height) state(3);

    // Final platform countdown
    if (platforms.finalPlatform != null && platforms.finalPlatform.landed) {
      fill(0);
      textAlign(CENTER, TOP);
      textSize(30);
      text("Game ends in " + ceil(platforms.finalPlatform.secondsLeft()), width/2, 60);
    }

    // End the game when the countdown finishes
    if (platforms.finalPlatform != null && platforms.finalPlatform.timeUp()) {
      state(4);
    }

    break;
  case 3:
    background(#B8DDE5);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("Game Over", width/2, height/2 - 40);
    textSize(24);
    text("Score: " + int(platforms.scrolled / 10), width/2, height/2 + 10);
    text("Click to return to menu", width/2, height/2 + 60);
    break;
  case 4:
    background(#B8DDE5);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("You Win!", width/2, height/2 - 40);
    textSize(24);
    text("Score: " + int(platforms.scrolled / 10), width/2, height/2 + 10);
    text("Click to return to menu", width/2, height/2 + 60);
    break;
  }
}

void mousePressed() {
  switch(gameState) {
  case 0:
    if (normal.mouseOver()) {
      button.play();
      startGame();
    }
    if (endless.mouseOver()) {
      button.play();
      state(2);
    }
    break;
  case 1:
    frog.startAim();
    break;

  case 3:
    state(0);
    break;
  case 4:
    state(0);
    break;
  }
}

void mouseReleased() {
  if (gameState == 1) {
    frog.releaseAim();
  }
}

void startGame() {
  platforms.reset();

  Platform start = platforms.platforms.get(0);
  frog = new Frog(start.x, 0, frog2);
  frog.y = start.top() - frog.h/4;
  frog.onGround = true;
  frog.standingOn = start;

  enemies = new ArrayList<Enemies>();
  enemies.add(new Enemies(250, 520, 350, 350, 3, 50, 450, true, blueBird));
  enemies.add(new Enemies(100, 380, 350, 350, 2, 200, 550, false, darkPurpleBird));

  state(1);
}
