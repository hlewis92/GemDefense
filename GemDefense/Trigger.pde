class Trigger {

  // variables
  int x;
  int y;
  int w;
  int h;

  int dirChange; // This variable is a number 0-2

  int left;
  int right;
  int top;
  int bottom;
  
  // speed of gems
  int speed;

  // constructor
  Trigger(int tx, int ty, int tw, int th, int dir) {
    x = tx;
    y = ty;
    w = tw;
    h = th;

    dirChange = dir;
    // 0 means change right, 1 change down, 2 change left

    left = x-w/2;
    right = x+w/2;
    top = y-h/2;
    bottom = y+h/2;
    
    speed = 2;
  }

  // functions
  void changeDirection(Gem aGem) {
    if (top<= aGem.bottom+25 &&
      bottom >= aGem.top-25 &&
      left <= aGem.right+25 &&
      right >= aGem.left-25 && dirChange==0) { // Trigger that changes right
      aGem.ySpeed=0;
      aGem.xSpeed=speed;
    }
    if (top<= aGem.bottom+25 &&
      bottom >= aGem.top-25 &&
      left <= aGem.right+25 &&
      right >= aGem.left-25 && dirChange==1) { // Trigger that changes down
      aGem.xSpeed=0;
      aGem.ySpeed=speed;
    }
    if (top<= aGem.bottom+25 &&
      bottom >= aGem.top-25 &&
      left <= aGem.right+25 &&
      right >= aGem.left-25 && dirChange==2) { // Trigger that changes left
      aGem.ySpeed=0;
      aGem.xSpeed=-speed;
    }
  }
}
