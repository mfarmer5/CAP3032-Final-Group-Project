import processing.sound.*;

PImage frog1, frog 2, frog3, blueBird, darkPurpleBird, lightPurpleBird, pinkBird, redBird;
SoundFile rainSounds, rainForest, natureSounds,chill, flipNote;

// Buttons
Button normal;
Button endless;

// Platforms (for debugging)
Platform p1;
BouncyPlatform p2;
TemporaryPlatform p3;

// Levels
Level levelNormal, levelEndless;

// Frog
Frog frog;

// Custom Font
PFont pixelFont;

// Vars
int gameState; // 0 = menu, 1 = normal, 2 = endless,

void setup() {
  size(500, 800);
  frameRate(60);

  // Load custom font
  pixelFont = createFont("zx_spectrum-7.ttf", 64);
  textFont(pixelFont);

  // Initialize buttons (def. w,h is 200,50. def. textSize is 20)
  normal = new Button(width/2, height/2 + 100, 300, 50, "Normal Mode", 30, color(#659B5E));
  endless = new Button(width/2, height/2 + 170, 280, 50, "Endless Mode", 28, color(#659B5E));

  // Initialize platforms for debugging
  p1 = new Platform(100, 600, 150, 40, color(#659B5E));
  p2 = new BouncyPlatform(350, 450, 150, 40);
  p3 = new TemporaryPlatform(150, 300, 150, 40);

  gameState = 0;

  //Loads images and music
  frog1 = loadImage("frog1.png");
  frog2 = loadImage("frog2.png");
  frog3 = loadImage("frog3.png");
  redBird = loadImage("redBird.png");
  blueBird = loadImage("bird enemies (blue).png");
  darkPurpleBird = loadImage("bird enemies (dark purple).png");
  lightPurpleBird = loadImage("bird enemies (light purple).png");
  pinkBird = loadImage("bird enemies (pink).png");

  rainSounds = new SoundFile(this, "rainSoundsEffects.mp3");
  rainForest = new SoundFile(this, "rainforestSounds.mp3");
  natureSounds = new SoundFile(this, "NatureSounds.mp3");
  chill = new SoundFile(this, "chill.mp3");
  flipNote = new SoundFile(this, "FlipNoteSoundEffects.mp3");
}

void draw() {

  switch(gameState) {
  case 0:
    background(#99DDC8);

    // buttons
    normal.update();
    normal.display();

    endless.update();
    endless.display();

    break;

  case 1:
    background(#283F3B);

    p1.display(color(#283F3B));
    p2.display(color(#283F3B));
    p3.display(color(#283F3B));
  }
}

void mousePressed() {
  switch(gameState) {
  case 0:
    gameState = 1;

    break;
  }
}
