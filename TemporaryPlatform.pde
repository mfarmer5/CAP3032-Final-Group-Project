class TemporaryPlatform extends Platform {

  boolean withering = false;

  int waitFrames = 30;
  int fadeFrames = 60;
  int elapsedFrames = 0;

  TemporaryPlatform(float _x, float _y, float _w, float _h) {
    super(_x, _y, _w, _h, color(165, 190, 120));
  }

  @Override
  void onLand(Frog frog) {
    // Start withering the first time it is touched
    if (!withering) {
      withering = true;
      elapsedFrames = 0;
    }
  }

  @Override
  void update() {
    if (!withering || !active)
      return;

    elapsedFrames++;

    // Wait before starting to fade
    if (elapsedFrames <= waitFrames)
      return;

    // Gradually decrease opacity
    float progress = (float)(elapsedFrames - waitFrames) / fadeFrames;

    opacity = 255 * (1 - constrain(progress, 0, 1));

    // Remove platform when completely faded
    if (progress >= 1) {
      opacity = 0;
      active = false;
    }
  }
}
