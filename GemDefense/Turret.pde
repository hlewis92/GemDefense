class Turret {

  //variables
  int x;
  int y;
  int w;
  int h;
  boolean isBombTurret;

  int dir; // direction the turret faces/shoots

  // attack radius hitbox
  int left;
  int right;
  int top;
  int bottom;
  int rangeSize;

  // timer for each turret
  int startTimeTurr;
  int currentTimeTurr;
  int intervalTurr;

  // boolean to determine if in range
  boolean isInRange;

  // boolean to determine if this thing is primed to fire
  boolean canFire;

  // boolean to determine if turret is fully placed yet
  boolean isPlaced;

  // boolean to fire the turret the first instance of being in range
  boolean isFiringFirst;

  boolean isSelected;

  boolean isTurnedReg;
  boolean isTurnedBomb;

  //constructor
  Turret(int tx, int ty, int tw, int th, boolean isBT) {
    x = tx;
    y = ty;
    w = tw;
    h = th;
    isBombTurret = isBT;

    rangeSize = 300;
    left = x-rangeSize/2-w/2;
    right = x+rangeSize/2+w/2;
    top = y-rangeSize/2-h/2;
    bottom = y+rangeSize/2+h/2;

    startTimeTurr = millis();
    currentTimeTurr = millis();
    intervalTurr = 1000;

    isInRange = false;

    dir=-1;

    isPlaced = false;

    canFire = false;
    isFiringFirst = true;
    isSelected = false;

    isTurnedReg=false;
    isTurnedBomb=false;
  }

  // functions
  // draw turret
  void render() {
    if (!isBombTurret) {
      if (!isTurnedReg) {
        regTurretImage.resize(100, 100);
        image(regTurretImage, x, y);
      } else {
        if (dir==0) {
          regTurretImageR.resize(100, 100);
          image(regTurretImageR, x, y);
        } else if (dir==1) {
          regTurretImageL.resize(100, 100);
          image(regTurretImageL, x, y);
        } else if (dir==2) {
          regTurretImageD.resize(100, 100);
          image(regTurretImageD, x, y);
        } else if (dir==3) {
          regTurretImageU.resize(100, 100);
          image(regTurretImageU, x, y);
        }
      }
    } else {
      if (!isTurnedBomb) {
        bombTurretImage.resize(100, 100);
        image(bombTurretImage, x, y);
      } else {
        if (dir==0) {
          bombTurretImageR.resize(100, 100);
          image(bombTurretImageR, x, y);
        } else if (dir==1) {
          bombTurretImageL.resize(100, 100);
          image(bombTurretImageL, x, y);
        } else if (dir==2) {
          bombTurretImageD.resize(100, 100);
          image(bombTurretImageD, x, y);
        } else if (dir==3) {
          bombTurretImageU.resize(100, 100);
          image(bombTurretImageU, x, y);
        }
      }
    }
    if (isSelected) {
      fill(0, 0, 0, 128);
      rect(x, y, w+rangeSize, h+rangeSize);
    }
  }

  // sets the direction the turret faces and shoots
  void setDirection(int dirFacing) {
    if (dirFacing==3) {
      dir=dirFacing;
      isPlaced=true;
    }
    if (dirFacing==2) {
      dir=dirFacing;
      isPlaced=true;
    }
    if (dirFacing==1) {
      dir=dirFacing;
      isPlaced=true;
    }
    if (dirFacing==0) {
      dir=dirFacing;
      isPlaced=true;
    }
  }

  void rangeDetector(Gem aGem) { // determines if a Gem is in range of a turret
    if (top <= aGem.bottom &&
      bottom >= aGem.top &&
      left <= aGem.right &&
      right >= aGem.left) {
      isInRange = true;
      if (isFiringFirst) {
        startTimeForTurret = currentTime;
        attack();
      }
    } else {
      isInRange = false;
    }
  }

  void attack() { // turrets start shooting bullets
    if (isInRange) {
      if (!isBombTurret) {
        bulletList.add(new Bullet(x, y, dir, false));
      } else {
        bombList.add(new Bullet(x, y, dir, true));
      }
      canFire = false;
      isFiringFirst = false;
    } else {
      isFiringFirst = true;
    }
  }
}
