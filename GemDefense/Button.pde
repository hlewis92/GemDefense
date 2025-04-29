class Button {

  /////////////////////////////////////////
  // variables
  /////////////////////////////////////////

  int x;
  int y;
  int w;
  int h;
  color c;

  /////////////////////////////////////////
  // constructor
  //  initialize vars
  /////////////////////////////////////////

  Button(int bx, int by, int bw, int bh, color buttonColor) {
    x = bx;
    y = by;
    w = bw;
    h = bh;
    c = buttonColor;
  }

  /////////////////////////////////////////
  // functions
  /////////////////////////////////////////

  // This function draws the button on the screen.
  void render() {
    fill(c);
    stroke(255);
    rect(x, y, w, h);
  }

  // This function determines if the mouse is in a button
  boolean isInButton() {
    boolean inButton = false;

    int bTop = y - h/2;
    int bBottom = y + h/2;
    int bLeft = x - w/2;
    int bRight = x + w/2;

    if (mouseY>=bTop && mouseY<=bBottom && mouseX>=bLeft && mouseX<=bRight) {
      inButton = true;
    } else {
      inButton = false;
    }
    return inButton;
  }

  // This function determines if a button is pressed
  boolean isPressed() {
    boolean isButtonPressed = false;
    if (isInButton()) {
      isButtonPressed = true;
    } else {
      isButtonPressed = false;
    }
    return isButtonPressed;
  }
}
