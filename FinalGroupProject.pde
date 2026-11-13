// Buttons
Button normal;
Button endless;

// Platforms (for debugging)
Platform p1, p2, p3;

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
  p2 = new Platform(350, 450, 150, 40, color(#659B5E));
  p3 = new Platform(150, 300, 150, 40, color(#659B5E));

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
  }
}

void mousePressed() {
  switch(gameState) {
  case 0:
    gameState = 1;

    break;
  }
}
