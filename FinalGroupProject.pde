Button normal;
Button endless;

PFont pixelFont;

int gameState; // 0 = menu, 1 = normal, 2 = endless,

void setup(){
  size(500, 800);
  frameRate(60);
  
  // Load custom font
  pixelFont = createFont("zx_spectrum-7.ttf", 64);
  textFont(pixelFont);
  
  // Initialize buttons
  normal = new Button(width/2, height/2 + 100, "Normal Mode", color(#659B5E));
  endless = new Button(width/2, height/2 + 200, "Endless Mode", color(#659B5E));


  gameState = 0;
}

void draw(){
 
  switch(gameState){
  case 0:
  background(#99DDC8);
  
  // buttons
  normal.update();
  normal.display();
    
  }
  
}
