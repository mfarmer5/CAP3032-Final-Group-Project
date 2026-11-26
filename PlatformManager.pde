class PlatformManager {
  ArrayList<Platform> platforms = new ArrayList<Platform>();

  float padW = 150;
  float padH = 40;
  float minGap = 90;    // min vertical distance between platforms
  float maxGap = 200;   // max vertical distance (max jump height is ~500px, so this is safe)
  float topY;           // y of the highest platform generated so far
  float scrolled = 0;   // total distance scrolled (use for score)
  boolean lastWasTemp = false;

  FinalPlatform finalPlatform = null;
  boolean finalSpawned = false;
  int finalScore = 1000; // score needed to spawn final platform

    // Starts a fresh level with one platform near the bottom
    void reset() {
    platforms.clear();
    scrolled = 0;
    lastWasTemp = false;
    platforms.add(new Platform(width/2, 700, padW, padH, color(#659B5E)));
    topY = 700;
    finalPlatform = null;
    finalSpawned = false;

    generate();
  }

  // Keep adding platforms until there are some above the top of the screen
  void generate() {
    if (finalSpawned) return;
    while (topY > -100) {
      topY -= random(minGap, maxGap);
      float px = random(padW/2, width - padW/2);
      float r = random(1);

      if (r < 0.15) {
        platforms.add(new BouncyPlatform(px, topY, padW, padH));
        lastWasTemp = false;
      } else if (r < 0.40 && !lastWasTemp) {
        platforms.add(new TemporaryPlatform(px, topY, padW, padH));
        lastWasTemp = true;   // never two temporary platforms in a row
      } else {
        platforms.add(new Platform(px, topY, padW, padH, color(#659B5E)));
        lastWasTemp = false;
      }
    }
  }

  void update() {
    for (Platform p : platforms) p.update();
  }

  void display() {
    for (Platform p : platforms) {
      PImage img = normalPad;
      if (p instanceof BouncyPlatform) img = bouncyPad;
      else if (p instanceof TemporaryPlatform) img = temporaryPad;
      p.display(color(#B8DDE5), img);
    }
  }

  // Landing check (call right after frog.update())
  void checkLanding(Frog frog) {
    if (frog.velocityY <= 0) return;   // only land while falling

    for (Platform p : platforms) {
      if (p.landedOn(frog.x, frog.previousY, frog.y, frog.w, frog.h)) {
        frog.land(p.top() - frog.h/4);
        p.onLand(frog);                // bouncy launches, temporary starts fading
        frog.standingOn = frog.onGround ? p : null;
        break;
      }
    }
  }

  // Sliding camera: when the frog climbs high, push the world down
  void scroll(Frog frog, ArrayList<Enemies> enemies) {
    float threshold = height * 0.4;

    if (frog.y < threshold) {
      float dy = threshold - frog.y;

      frog.y += dy;
      frog.previousY += dy;
      for (Platform p : platforms) p.y += dy;
      for (Enemies e : enemies) e.scroll(dy);

      topY += dy;
      scrolled += dy;
    }

    // Remove things that fell off the bottom of the screen
    for (int i = platforms.size() - 1; i >= 0; i--) {
      Platform p = platforms.get(i);
      if (p.y - p.h/2 > height + 50) platforms.remove(i);
    }
    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemies e = enemies.get(i);
      if (e.y - e.h/2 > height + 50) enemies.remove(i);
    }
    // Spawn the final platform once the score is high enough
    if (!finalSpawned && int(scrolled / 10) > finalScore) {
      finalPlatform = new FinalPlatform(width/2, topY - 150, 400, 60);
      platforms.add(finalPlatform);
      finalSpawned = true;
    }

    generate();
  }
}
