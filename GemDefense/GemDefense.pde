// Gem Defense

//////// declare global vars

// path
int pathX1;
int pathY1;
int pathW1;
int pathH1;

int pathX2;
int pathY2;
int pathW2;
int pathH2;

int pathX3;
int pathY3;
int pathW3;
int pathH3;

int pathX4;
int pathY4;
int pathW4;
int pathH4;

int pathX5;
int pathY5;
int pathW5;
int pathH5;

color pathColor;

// game numbers
int points;
int hp;
int wave;
int pointsPerWave;

// gem spawns
int gemsSpawned;
int waveLength;

// objects
ArrayList<Turret> turretList;
ArrayList<Turret> bombTurretList;
Turret nTurret = null;
Turret nBombTurret = null;

ArrayList<Gem> gemList;
ArrayList<Gem> bombGemList;
int gemHp;

ArrayList<Bullet> bulletList;
ArrayList<Bullet> bombList;

Trigger tr0;
Trigger tr1;
Trigger tr2;
Trigger tr3;
Trigger tr4;

Button nextWave;
Button newTurret1;
Button newTurret2;
Button startButton;
Button controlsButton;
Button backButton;

//timer
int startTime;
int startTimeForTurret;
boolean turretIsFiring;
int currentTime;
int interval = 1000;

// state var
int state;

int statePlaceholder;

int menuState;

// boolean for placing a turret
boolean isBuyingTurret = false;
boolean isBuyingBombTurret = false;

// boolean to determine if wave ended
boolean waveEnded = false;

PImage regGemImage;
PImage bombGemImage;
PImage regBulletImage;
PImage bombBulletImage;

PImage regTurretImage;
PImage regTurretImageR;
PImage regTurretImageL;
PImage regTurretImageU;
PImage regTurretImageD;

PImage bombTurretImage;
PImage bombTurretImageR;
PImage bombTurretImageL;
PImage bombTurretImageU;
PImage bombTurretImageD;

PImage regTurretImageBuy;
PImage bombTurretImageBuy;

PImage caveBackground;

// sound
import processing.sound.*;
SoundFile attackSound;
SoundFile backgroundSound;
SoundFile diamondSound;

void setup() {
  size(1200, 800);

  rectMode(CENTER);

  // initialize global vars
  pathX1 = width/2;
  pathY1 = 175;
  pathW1 = 100;
  pathH1 = 350;

  pathX2 = 775;
  pathY2 = 300;
  pathW2 = 450;
  pathH2 = 100;

  pathX3 = 950;
  pathY3 = 425;
  pathW3 = 100;
  pathH3 = 350;

  pathX4 = 650;
  pathY4 = 550;
  pathW4 = 700;
  pathH4 = 100;

  pathX5 = 350;
  pathY5 = 650;
  pathW5 = 100;
  pathH5 = 300;

  pathColor = color(#E5CF4C);

  hp = 5;
  points = 100;
  wave = 0;
  pointsPerWave = 100;

  gemsSpawned = 0;
  waveLength=1;

  turretList = new ArrayList<Turret>();
  bombTurretList = new ArrayList<Turret>();

  gemList = new ArrayList<Gem>();
  bombGemList = new ArrayList<Gem>();
  gemHp = 0;

  bulletList = new ArrayList<Bullet>();
  bombList = new ArrayList<Bullet>();

  tr0 = new Trigger(width/2, 0, 100, 10, 1);
  tr1 = new Trigger(width/2, 355, 100, 10, 0);
  tr2 = new Trigger(1005, 300, 10, 100, 1);
  tr3 = new Trigger(950, 605, 100, 10, 2);
  tr4 = new Trigger(295, 550, 10, 100, 1);

  nextWave = new Button(100, 150, 150, 40, color(60));
  newTurret1 = new Button(65, 300, 50, 50, color(255));
  newTurret2 = new Button(65, 500, 50, 50, color(255, 0, 0));
  startButton = new Button(width/2, 450, 800, 150, color(255));
  controlsButton = new Button(width/2, 650, 800, 150, color(255));
  backButton = new Button(100, 100, 100, 100, color(255));

  startTime = millis();
  startTimeForTurret = 0;

  state=0;

  statePlaceholder=0;

  menuState=0;

  regGemImage = loadImage("emerald0.png");
  bombGemImage = loadImage("diamond0.png");
  regBulletImage = loadImage("pickaxe0.png");
  bombBulletImage = loadImage("dynamite0.png");

  regTurretImage = loadImage("minerU0.png");
  regTurretImageR = loadImage("minerR0.png");
  regTurretImageL = loadImage("minerL0.png");
  regTurretImageU = loadImage("minerU0.png");
  regTurretImageD = loadImage("minerD0.png");

  bombTurretImage = loadImage("bomberU0.png");
  bombTurretImageR = loadImage("bomberR0.png");
  bombTurretImageL = loadImage("bomberL0.png");
  bombTurretImageU = loadImage("bomberU0.png");
  bombTurretImageD = loadImage("bomberD0.png");

  regTurretImageBuy = loadImage("minerU0.png");
  bombTurretImageBuy = loadImage("bomberU0.png");

  caveBackground = loadImage("graniteCave.png");

  regTurretImage.resize(100, 100);
  bombTurretImage.resize(100, 100);
  regTurretImageBuy.resize(100, 100);
  bombTurretImageBuy.resize(100, 100);

  caveBackground.resize(width, height);

  // Load a soundfile from the /data folder of the sketch and play it back
  attackSound = new SoundFile(this, "hitSound.mp3");
  backgroundSound = new SoundFile(this, "undergroundMusic.mp3");
  backgroundSound.amp(1);
  diamondSound = new SoundFile(this, "hitDiamondSound.mp3");
}

void draw() {

  imageMode(CENTER);

  if (!backgroundSound.isPlaying()) {
    backgroundSound.loop();
  }

  switch(menuState) {
  case 0:
    // start screen
    background(20);

    textSize(200);
    fill(#047C20);
    text("G", 400, 150);
    fill(#047C20);
    text("E", 520, 150);
    fill(#047C20);
    text("M", 620, 150);

    fill(#BBFAF9);
    text("DEFENSE", 200, 310);

    strokeWeight(16);
    stroke(0);
    startButton.render();
    controlsButton.render();
    strokeWeight(1);

    textSize(100);
    fill(0);
    text("Start", 500, 475);
    text("How to Play", 375, 675);

    break;
  case 1:
    background(20);

    backButton.render();
    fill(0);
    noStroke();
    triangle(65, 100, 95, 70, 95, 130);
    rect(110, 100, 40, 30);

    textSize(50);
    fill(255);
    text(" - Drag and Drop miners from the selection in the brown box on the left onto the field outside of the path.", 600, 250, 1000, 150);
    text(" - After placing a miner, press 'w, a, s, or d' to make the miner attack up, left, down, or right respectively.", 600, 380, 1000, 150);
    text(" - Press 'Next Wave' to begin the first wave and to advance to the next wave after all gems have been defeated in a wave. Make sure you have bomb throwing miners for the diamond Gems!", 600, 600, 1000, 300);
    text(" - Successfully defend against 8 waves to win!", 600, 780, 1000, 150);
    break;
  case 2:
    image(caveBackground, width/2, height/2);
    //background(#3B8E31);

    ///////////////////////////////////// Path that Gems travel
    noStroke();
    fill(pathColor);
    rect(pathX1, pathY1, pathW1, pathH1);
    rect(pathX2, pathY2, pathW2, pathH2);
    rect(pathX3, pathY3, pathW3, pathH3);
    rect(pathX4, pathY4, pathW4, pathH4);
    rect(pathX5, pathY5, pathW5, pathH5);
    stroke(0);

    ////////////////////////////////////// game UI
    fill(#7C5A04);
    rect(50, 450, 200, 400, 8);
    fill(#E8E346);
    textSize(30);
    text("$100", 35, 375);
    text("$150", 35, 575);
    image(regTurretImageBuy, newTurret1.x, newTurret1.y);
    image(bombTurretImageBuy, newTurret2.x, newTurret2.y);
    nextWave.render();
    stroke(0);
    fill(#E8E346);
    textSize(50);
    text("$"+points, 50, 50);
    fill(255, 0, 0);
    text("hp: "+hp, 50, 100);
    fill(255);
    textSize(30);
    text("Next Wave", 35, 160);

    if (isBuyingTurret) {
      tint(255, 128);
      image(regTurretImageBuy, mouseX, mouseY);
      tint(255, 255);
    }

    if (isBuyingBombTurret) {
      tint(255, 128);
      image(bombTurretImageBuy, mouseX, mouseY);
      tint(255, 255);
    }

    println("Start time: " + startTimeForTurret);
    println("Current time: " + currentTime);
    println("State: " + state);

    if (currentTime - startTimeForTurret >= interval) {
      turretIsFiring = true;
      startTimeForTurret = millis();
    }

    for (Turret aTurret : turretList) {

      aTurret.render();

      for (Gem aGem : gemList) {
        aTurret.rangeDetector(aGem);
      }

      for (Gem aGem : bombGemList) {
        aTurret.rangeDetector(aGem);
      }

      if (turretIsFiring) {
        aTurret.attack();
      }
    }

    for (int i = 0; i < bulletList.size(); i++) {
      Bullet aBullet = bulletList.get(i);
      aBullet.render();
      aBullet.move();
      aBullet.checkRemove();
      for (Gem aGem : gemList) {
        aBullet.shootGem(aGem);
      }
      for (Gem aGem : bombGemList) {
        aBullet.bounceOffGem(aGem);
      }
      if (aBullet.shouldRemove) {
        bulletList.remove(i);
      }
    }

    ///////////////////////////////////////////////////////// Gem List for loop
    for (int i = 0; i < gemList.size(); i++) {
      Gem aGem = gemList.get(i);
      aGem.render();
      aGem.move();
      aGem.destroy();
      tr0.changeDirection(aGem);
      tr1.changeDirection(aGem);
      tr2.changeDirection(aGem);
      tr3.changeDirection(aGem);
      tr4.changeDirection(aGem);

      if (aGem.shouldRemove) { // an enemy was hit
        gemList.remove(i);
        points+=20;
      }

      if (aGem.y-aGem.h/2 >= height) { // an enemy made it to the end
        gemList.remove(i);
        hp--;
      }
    }

    for (Turret aTurret : bombTurretList) {
      aTurret.render();

      for (Gem aGem : gemList) {
        aTurret.rangeDetector(aGem);
      }

      for (Gem aGem : bombGemList) {
        aTurret.rangeDetector(aGem);
      }

      if (turretIsFiring) {
        aTurret.attack();
      }
    }

    turretIsFiring = false;

    for (int i = 0; i < bombList.size(); i++) {
      Bullet aBullet = bombList.get(i);
      aBullet.render();
      aBullet.move();
      aBullet.checkRemove();
      for (Gem aGem : gemList) {
        aBullet.shootGem(aGem);
      }
      for (Gem aGem : bombGemList) {
        aBullet.shootGem(aGem);
      }
      if (aBullet.shouldRemove) {
        bombList.remove(i);
      }
    }

    ///////////////////////////////////////////////////////// Gem List for loop
    for (int i = 0; i < bombGemList.size(); i++) {
      Gem aGem = bombGemList.get(i);
      aGem.render();
      aGem.move();
      aGem.destroy();
      tr0.changeDirection(aGem);
      tr1.changeDirection(aGem);
      tr2.changeDirection(aGem);
      tr3.changeDirection(aGem);
      tr4.changeDirection(aGem);

      if (aGem.shouldRemove) { // an enemy was hit
        bombGemList.remove(i);
        points+=30;
      }

      if (aGem.y-aGem.h/2 >= height) { // an enemy made it to the end
        bombGemList.remove(i);
        hp-=2;
      }
    }


    if (hp<=0) {
      state=0;
      menuState=4;
    }

    // switch state
    switch (state) {
    case 0:
      statePlaceholder = state;
      break;

    case 1:
      textSize(50);
      fill(0);
      text("Wave "+wave, 1000, 50);
      gemHp=1;

      //////////////////////////////////////////////////////// timer for spawning enemies
      currentTime = millis();

      if (currentTime-startTime>=interval && gemsSpawned < waveLength) {
        //bombGemList.add(new Gem(pathX1, 25, 50, 50, gemHp));
        gemList.add(new Gem(pathX1, 25, 50, 50, gemHp, false));
        gemsSpawned++;
        startTime = millis();
      }

      // gain points at the end of wave
      if (gemList.size()==0 && gemsSpawned>=waveLength) {
        points+=pointsPerWave;
        statePlaceholder = state; // holds value for state
        state = 9; // go to last state in between waves
      }
      break;

    case 2:
      textSize(50);
      fill(0);
      text("Wave "+wave, 1000, 50);
      gemHp=1;

      //////////////////////////////////////////////////////// timer for spawning enemies
      currentTime = millis();

      if (currentTime-startTime>=interval && gemsSpawned < waveLength) {
        gemList.add(new Gem(pathX1, 25, 50, 50, gemHp, false));
        gemsSpawned++;
        startTime = millis();
      }
      // gain points at the end of wave
      if (gemList.size()==0 && gemsSpawned>=waveLength) {
        points+=pointsPerWave;
        statePlaceholder = state; // holds value for state
        state = 9; // go to last state in between waves
      }
      break;

    case 3:
      textSize(50);
      fill(0);
      text("Wave "+wave, 1000, 50);
      gemHp=2;

      //////////////////////////////////////////////////////// timer for spawning enemies
      currentTime = millis();

      if (currentTime-startTime>=interval && gemsSpawned < waveLength) {
        gemList.add(new Gem(pathX1, 25, 50, 50, gemHp, false));
        gemsSpawned++;
        startTime = millis();
      }
      // gain points at the end of wave
      if (gemList.size()==0 && gemsSpawned>=waveLength) {
        points+=pointsPerWave;
        statePlaceholder = state; // holds value for state
        state = 9; // go to last state in between waves
      }
      break;

    case 4:
      textSize(50);
      fill(0);
      text("Wave "+wave, 1000, 50);
      gemHp=3;

      //////////////////////////////////////////////////////// timer for spawning enemies
      currentTime = millis();

      if (currentTime-startTime>=interval && gemsSpawned < waveLength) {
        gemList.add(new Gem(pathX1, 25, 50, 50, gemHp, false));
        gemsSpawned++;
        startTime = millis();
      }
      // gain points at the end of wave
      if (gemList.size()==0 && gemsSpawned>=waveLength) {
        points+=pointsPerWave;
        statePlaceholder = state; // holds value for state
        state = 9; // go to last state in between waves
      }
      break;

    case 5:
      textSize(50);
      fill(0);
      text("Wave "+wave, 1000, 50);
      gemHp=3;

      //////////////////////////////////////////////////////// timer for spawning enemies
      currentTime = millis();

      if (currentTime-startTime>=interval && gemsSpawned < waveLength) {
        bombGemList.add(new Gem(pathX1, 25, 50, 50, gemHp, true));
        gemsSpawned++;
        startTime = millis();
      }
      // gain points at the end of wave
      if (bombGemList.size()==0 && gemsSpawned>=waveLength) {
        points+=pointsPerWave;
        statePlaceholder = state; // holds value for state
        state = 9; // go to last state in between waves
      }
      break;

    case 6:
      textSize(50);
      fill(0);
      text("Wave "+wave, 1000, 50);
      gemHp=4;

      //////////////////////////////////////////////////////// timer for spawning enemies
      currentTime = millis();

      if (currentTime-startTime>=interval && gemsSpawned < waveLength) {
        if (gemsSpawned % 2 == 0) {
          gemList.add(new Gem(pathX1, 25, 50, 50, gemHp, false));
        } else {
          bombGemList.add(new Gem(pathX1, 25, 50, 50, gemHp, true));
        }
        gemsSpawned++;
        startTime = millis();
      }
      // gain points at the end of wave
      if (gemList.size()==0 && gemsSpawned>=waveLength && bombGemList.size()==0) {
        points+=pointsPerWave;
        statePlaceholder = state; // holds value for state
        state = 9; // go to last state in between waves
      }
      break;

    case 7:
      textSize(50);
      fill(0);
      text("Wave "+wave, 1000, 50);
      gemHp=4;

      //////////////////////////////////////////////////////// timer for spawning enemies
      currentTime = millis();

      if (currentTime-startTime>=interval && gemsSpawned < waveLength) {
        if (waveLength/2 > gemsSpawned) {
          gemList.add(new Gem(pathX1, 25, 50, 50, gemHp, false));
        } else {
          bombGemList.add(new Gem(pathX1, 25, 50, 50, gemHp, true));
        }
        gemsSpawned++;
        startTime = millis();
      }
      // gain points at the end of wave
      if (gemList.size()==0 && gemsSpawned>=waveLength && bombGemList.size()==0) {
        points+=pointsPerWave;
        statePlaceholder = state; // holds value for state
        state = 9; // go to last state in between waves
      }
      break;

    case 8:
      textSize(50);
      fill(0);
      text("Wave "+wave, 1000, 50);
      gemHp=5;

      //////////////////////////////////////////////////////// timer for spawning enemies
      currentTime = millis();

      if (currentTime-startTime>=interval && gemsSpawned < waveLength) {
        if (gemsSpawned % 3 == 0) {
          gemList.add(new Gem(pathX1, 25, 50, 50, gemHp, false));
        } else {
          bombGemList.add(new Gem(pathX1, 25, 50, 50, gemHp, true));
        }
        gemsSpawned++;
        startTime = millis();
      }
      // gain points at the end of wave
      if (gemList.size()==0 && gemsSpawned>=waveLength && bombGemList.size()==0) {
        points+=pointsPerWave;
        statePlaceholder = state; // holds value for state
        state=0;
        menuState = 3; // go to win state
      }
      break;

    case 9:
      textSize(50);
      fill(0);
      text("Wave " + wave, 1000, 50);
      break;
    }
    break;
  case 3:
    // win screen
    background(20);
    textSize(400);
    fill(#BBFAF9);
    text("YOU", 200, 310);
    fill(#047C20);
    text("WIN!", 200, 650);
    textSize(40);
    fill(255);
    text("Click to restart, Mr. Winner!", 360, 720);
    hp=5;
    points=100;
    wave=0;
    pointsPerWave=100;
    waveLength=1;
    gemsSpawned=0;
    turretList = new ArrayList<Turret>();
    bombTurretList = new ArrayList<Turret>();

    gemList = new ArrayList<Gem>();
    bombGemList = new ArrayList<Gem>();

    bulletList = new ArrayList<Bullet>();
    bombList = new ArrayList<Bullet>();

    break;

  case 4:
    // lose screen
    background(20);
    textSize(400);
    fill(#BBFAF9);
    text("YOU", 200, 310);
    fill(#E81725);
    text("LOSE!", 100, 650);
    textSize(40);
    fill(255);
    text("Click to restart, loser.", 400, 720);
    hp=5;
    points=100;
    wave=0;
    pointsPerWave=100;
    waveLength=1;
    gemsSpawned=0;
    turretList = new ArrayList<Turret>();
    bombTurretList = new ArrayList<Turret>();

    gemList = new ArrayList<Gem>();
    bombGemList = new ArrayList<Gem>();

    bulletList = new ArrayList<Bullet>();
    bombList = new ArrayList<Bullet>();

    break;
  }
}

void mousePressed() {
  if (gemList.size()==0 && nextWave.isPressed() && bombGemList.size()==0) { // advances the wave and increases necessary elements
    gemsSpawned=0;
    waveLength++;
    wave++;
    pointsPerWave+=10;
    state = statePlaceholder+1;
  }

  if (newTurret1.isPressed() && nTurret==null && points>=100) { // buys a turret when pressing the button and can't buy a turret before the direction for the most recent turret is set
    isBuyingTurret = true;
  }
  if (newTurret2.isPressed() && nBombTurret==null && points>=150) {
    isBuyingBombTurret = true;
  }
  if (startButton.isPressed() && menuState==0) {
    menuState=2;
  }
  if (controlsButton.isPressed() && menuState==0) {
    menuState=1;
  }
  if (backButton.isPressed() && menuState==1) {
    menuState=0;
  }

  for (Turret aTurret : turretList) {
    if (aTurret.left <= mouseX &&
      aTurret.right >= mouseX &&
      aTurret.top <= mouseY &&
      aTurret.bottom >= mouseY) {
      aTurret.isSelected = !aTurret.isSelected;
    }
  }

  for (Turret aTurret : bombTurretList) {
    if (aTurret.left <= mouseX &&
      aTurret.right >= mouseX &&
      aTurret.top <= mouseY &&
      aTurret.bottom >= mouseY) {
      aTurret.isSelected = !aTurret.isSelected;
    }
  }

  if (menuState == 3 || menuState == 4) {
    menuState = 0;
    state = 0;
  }
}

void mouseReleased() {
  if (isBuyingTurret && mouseX>200) {
    nTurret=new Turret(mouseX, mouseY, 50, 50, false);
    turretList.add(nTurret);
    isBuyingTurret=false;
    points-=100;
  }
  if (isBuyingBombTurret && mouseX>200) {
    nBombTurret=new Turret(mouseX, mouseY, 50, 50, true);
    bombTurretList.add(nBombTurret);
    isBuyingBombTurret=false;
    points-=150;
  }
}

void keyPressed() {
  if (nTurret != null) { // sets the direction of the turret based on what the player presses
    if (key == 'w') {
      nTurret.isTurnedReg=true;
      nTurret.setDirection(3); // up
      nTurret = null; // done placing
    }
    if (key == 's') {
      nTurret.isTurnedReg=true;
      nTurret.setDirection(2); // down
      nTurret = null; // done placing
    }
    if (key == 'a') {
      nTurret.isTurnedReg=true;
      nTurret.setDirection(1); // left
      nTurret = null; // done placing
    }
    if (key == 'd') {
      nTurret.isTurnedReg=true;
      nTurret.setDirection(0); // right
      nTurret = null; // done placing
    }
  }
  if (nBombTurret != null) { // sets the direction of the turret based on what the player presses
    if (key == 'w') {
      nBombTurret.isTurnedBomb=true;
      nBombTurret.setDirection(3); // up
      nBombTurret = null; // done placing
    }
    if (key == 's') {
      nBombTurret.isTurnedBomb=true;
      nBombTurret.setDirection(2); // down
      nBombTurret = null; // done placing
    }
    if (key == 'a') {
      nBombTurret.isTurnedBomb=true;
      nBombTurret.setDirection(1); // left
      nBombTurret = null; // done placing
    }
    if (key == 'd') {
      nBombTurret.isTurnedBomb=true;
      nBombTurret.setDirection(0); // right
      nBombTurret = null; // done placing
    }
  }
}
