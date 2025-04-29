class Gem {

  // variables
  int x;
  int y;

  int w;
  int h;

  int xSpeed;
  int ySpeed;

  int left;
  int right;
  int top;
  int bottom;

  int hp;

  boolean shouldRemove;
  
  boolean isBombGem;

  // contructor
  Gem(int gx, int gy, int gw, int gh, int health, boolean isBG) {
    x = gx;
    y = gy;
    w = gw;
    h = gh;
    isBombGem = isBG;

    xSpeed = 0;
    ySpeed = 0;

    hp = health;

    shouldRemove = false;

    left = x-w/2;
    right = x+w/2;
    top = y-h/2;
    bottom = y+h/2;
    
    regGemImage.resize(w,h);
    bombGemImage.resize(w,h);
  }

  //functions
  void render() {
    if (!isBombGem) {
      image(regGemImage,x,y);
    } else {
      image(bombGemImage,x,y);
    }
  }

  void move() {
    x+=xSpeed;
    y+=ySpeed;

    left = x-w/2;
    right = x+w/2;
    top = y-h/2;
    bottom = y+h/2;
  }

  void destroy() {
    if (hp<=0) {
      shouldRemove=true;
    }
  }
}
