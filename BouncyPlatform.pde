class BouncyPlatform extends Platform {
  float bounceSpeed;

  BouncyPlatform(float _x, float _y, float _w, float _h) {
    this(_x, _y, _w, _h, 14);
  }

  BouncyPlatform(float _x, float _y, float _w, float _h,
                 float _bounceSpeed) {

    super(_x, _y, _w, _h, color(155, 105, 195));

    bounceSpeed = _bounceSpeed;
  }

  @Override
  void onLand(Frog frog) {
    // Launch frog upward
    frog.velocityY = -bounceSpeed;

    // Frog is no longer standing on the platform
    frog.onGround = false;

    // Grant an extra midair jump
    frog.canAirJump = true;
  }
}
