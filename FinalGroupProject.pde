import processing.sound.*;

PImage frog1, frog2, frog3, blueBird, darkPurpleBird, lightPurpleBird, pinkBird, redBird;
SoundFile rainSounds, rainForest, natureSounds,chill, flipNote;

// Buttons
Button normal;
Button endless;

// Platforms (for debugging)
Platform p1;
BouncyPlatform p2;
TemporaryPlatform p3;

//Enemies
ArrayList<Enemies> enemies;

// Levels
Levels levelNormal, levelEndless;

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
  
  //Loads images and music
  frog1 = loadImage("frog1.png");
  //frog2 = loadImage("frog2.png");
  //frog3 = loadImage("frog3.png");
  redBird = loadImage("redBird.png");
  blueBird = loadImage("bird enemies (blue).png");
  darkPurpleBird = loadImage("bird enemies (dark purple).png");
  //lightPurpleBird = loadImage("bird enemies (light purple).png");
  //pinkBird = loadImage("bird enemies (pink).png");

  //rainSounds = new SoundFile(this, "rainSoundsEffects.mp3");
  //rainForest = new SoundFile(this, "rainforestSounds.mp3");
  //natureSounds = new SoundFile(this, "NatureSounds.mp3");
  //chill = new SoundFile(this, "chill.mp3");
  //flipNote = new SoundFile(this, "FlipNoteSoundEffects.mp3");

  // Initialize buttons (def. w,h is 200,50. def. textSize is 20)
  normal = new Button(width/2, height/2 + 100, 300, 50, "Normal Mode", 30, color(#659B5E));
  endless = new Button(width/2, height/2 + 170, 280, 50, "Endless Mode", 28, color(#659B5E));

  // Initialize platforms for debugging
  p1 = new Platform(100, 600, 150, 40, color(#659B5E));
  p2 = new BouncyPlatform(350, 450, 150, 40);
  p3 = new TemporaryPlatform(150, 300, 150, 40);
  
  // Initialize enemies list and spawn sample enemies
  enemies = new ArrayList<Enemies>();
  // Horizontal enemy: (x, y, w, h, speed, minPos, maxPos, horizontal)
  enemies.add(new Enemies(250, 520, 350, 350, 3, 50, 450, true, blueBird));
  // Vertical enemy: (x, y, w, h, speed, minPos, maxPos, horizontal)
  enemies.add(new Enemies(100, 380, 350, 350, 2, 200, 550, false, darkPurpleBird));
  
  gameState = 0;
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
    //Update and draw all enemies
    for (Enemies e : enemies) {
      e.update();
      e.display();
    }
    break;
  }
}

void mousePressed() {
  switch(gameState) {
  case 0:
    gameState = 1;

    break;
  }
}
