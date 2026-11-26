class FinalPlatform extends Platform {
  boolean landed = false;
  int landTime = 0;
  int countdownMs = 5000;   // time on the platform before the game ends

  FinalPlatform(float _x, float _y, float _w, float _h) {
    super(_x, _y, _w, _h, color(#659B5E));
  }

  @Override
  void onLand(Frog frog) {
    if (!landed) {
      landed = true;
      landTime = millis();
    }
    // Frog can no longer jump
    frog.canJump = false;
    frog.aiming = false;
    frog.canAirJump = false;
  }

  float secondsLeft() {
    if (!landed) return countdownMs / 1000.0;
    return max(0, (countdownMs - (millis() - landTime)) / 1000.0);
  }

  boolean timeUp() {
    return landed && millis() - landTime >= countdownMs;
  }
}
