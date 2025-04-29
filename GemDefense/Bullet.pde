class Bullet {

  //variables
  int x;
  int y;
  int d;

  int speed;

  int dir;

  boolean shouldRemove;

  int left;
  int right;
  int top;
  int bottom;

  boolean isBomb;

  // constructor !! The dir int is only 0 to 3 where 0 is left, 1 is right,
  //////////////////// 2 is down, and 3 is up
  Bullet(int startingX, int startingY, int bDir, boolean isB) {
    x = startingX;
    y = startingY;
    d = 15;
    dir = bDir;
    isBomb = isB;

    speed = 10;

    shouldRemove = false;

    left = x-d/2;
    right = x+d/2;
    top = y-d/2;
    bottom = y+d/2;

    regBulletImage.resize(60, 60);
    bombBulletImage.resize(60, 60);
  }

  //functions
  void render() {
    if (!isBomb) {
      image(regBulletImage, x, y);
    } else {
      image(bombBulletImage, x, y);
    }
  }

  void move() {
    if (dir == 0) {
      x+=speed; // move left
    } else if (dir == 1) {
      x-=speed; // move right
    } else if (dir == 2) {
      y+=speed; // move down
    } else if (dir == 3) {
      y-=speed; // move up
    }

    // re-initialize hitbox as the Bullet moves
    left = x-d/2;
    right = x+d/2;
    top = y-d/2;
    bottom = y+d/2;
  }

  // removes off-screen bullets
  void checkRemove() {
    if (y<0 || y>height || x>width || x<0) {
      shouldRemove = true;
    }
  }

  void shootGem(Gem aGem) {
    // if the bullet collides with the Gem, then damage the Gem
    if (top<= aGem.bottom &&
      bottom >= aGem.top &&
      left <= aGem.right &&
      right >= aGem.left) {
      aGem.hp-=1;
      shouldRemove = true;
      attackSound.play();
    }
  }

  void bounceOffGem(Gem aGem) {
    if (top<= aGem.bottom &&
      bottom >= aGem.top &&
      left <= aGem.right &&
      right >= aGem.left) {
      shouldRemove = true;
      diamondSound.play();
    }
  }
}
